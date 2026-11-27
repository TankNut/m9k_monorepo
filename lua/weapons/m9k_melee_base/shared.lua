AddCSLuaFile()
DEFINE_BASECLASS("m9k_base")

SWEP.Base = "m9k_base"

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/v_invisible_nade.mdl")
SWEP.WorldModel = Model("models/weapons/w_grenade.mdl")

SWEP.Primary.Ammo = ""
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

SWEP.HoldType = "knife"

--[[
	AttackData is __index'ed to BaseData.
	Available fields:

	Delay: Delay before the weapon can hit when swinging
	Window: The window the weapon has to hit
	Damage: Damage dealt, backstabs deal 2x
	DamageType: DMG enum
	CanBackstab: Self-explanatory
	Sound: Swing sound
	StabSound: Hit sound
	BackstabSound: Backstab sound
	WallSound: Non-player/NPC hit sound
	Range: Trace distance
	Hull: Trace hull
]]

SWEP.BaseData = {}
SWEP.AttackData = {}

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetHoldType(self.HoldType)

	for _, v in ipairs(self.AttackData) do
		setmetatable(v, {
			__index = self.BaseData
		})
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "AttackDelay")
	self:NetworkVar("Int", "AttackIndex")
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:Holster()
	self:SetAttackDelay(0)

	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:ClassifyTrace(tr)
	if not tr.Hit then
		return
	end

	if not tr.HitWorld then
		tr.HitFlesh = tr.Entity:IsPlayer() or tr.Entity:IsNPC()
	end

	if tr.HitFlesh then
		tr.Backstab = tr.Entity:GetForward():Dot(tr.Normal) >= 0.7
	end
end

function SWEP:GetMeleeTrace(range, hull)
	local ply = self:GetOwner()
	local pos = ply:M9K_GetShootPos()

	local trace = {
		start = pos,
		endpos = pos + ply:GetAimVector() * range,
		mins = Vector(-hull, -hull, -hull),
		maxs = Vector(hull, hull, hull),
		filter = ply,
		mask = MASK_SHOT
	}

	ply:LagCompensation(true)

	local tr = util.TraceLine(trace)
	self:ClassifyTrace(tr)

	local line = tr

	if not tr.Hit then
		tr = util.TraceHull(trace)
		self:ClassifyTrace(tr)
	end

	ply:LagCompensation(false)

	return tr, line
end

local phys_pushscale = GetConVar("phys_pushscale")

function SWEP:HandleAttack()
	local delay = self:GetAttackDelay()
	local ct = CurTime()

	if delay > 0 and delay <= ct then
		local data = self.AttackData[self:GetAttackIndex()]

		-- Attack window has ended, reset
		if delay + data.Window <= ct then
			self:SetAttackDelay(0)

			return
		end

		local tr, line = self:GetMeleeTrace(data.Range, data.Hull)

		if not tr.Hit then
			return
		end

		self:SetAttackDelay(0)

		local damage = data.Damage * math.Rand(0.98, 1.02)

		if tr.HitFlesh then
			if data.CanBackstab and tr.Backstab then
				damage = damage * 2
				self:EmitSound(data.BackstabSound)
			else
				self:EmitSound(data.StabSound)
			end
		else
			self:EmitSound(data.WallSound)
		end

		local ply = self:GetOwner()

		local dmg = DamageInfo()
		dmg:SetAttacker(ply)
		dmg:SetInflictor(self)
		dmg:SetDamagePosition(tr.HitPos)

		local force = Vector(40, 20, 0)
		force:Mul(damage * phys_pushscale:GetFloat())
		force:Rotate(ply:GetAimVector():Angle())

		dmg:SetDamageForce(force)
		dmg:SetDamage(damage)
		dmg:SetDamageType(data.DamageType)

		tr.Entity:DispatchTraceAttack(dmg, tr)

		if IsFirstTimePredicted() and line.Hit then
			local effectData = EffectData()

			effectData:SetOrigin(line.HitPos)
			effectData:SetStart(line.StartPos)
			effectData:SetNormal(line.HitNormal)
			effectData:SetSurfaceProp(line.SurfaceProps)
			effectData:SetDamageType(data.DamageType)
			effectData:SetHitBox(line.HitBox)
			effectData:SetEntity(line.Entity)

			util.Effect("Impact", effectData)
		end
	end
end

function SWEP:Think()
	self:HandleAttack()
end

function SWEP:StartAttack(index, sequence, delay)
	if self:GetNextPrimaryFire() > CurTime() then
		return
	end

	local data = self.AttackData[index]
	local ply = self:GetOwner()
	local vm = ply:GetViewModel()

	ply:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_IDLE)

	vm:ResetSequence(vm:LookupSequence(sequence))

	self:EmitSound(data.Sound)
	self:SetAttackDelay(CurTime() + data.Delay)
	self:SetAttackIndex(index)

	self:SetNextPrimaryFire(CurTime() + delay)
end

function SWEP:Throw(class, snd)
	if self:GetNextPrimaryFire() > CurTime() then return end

	local ply = self:GetOwner()
	ply:SetAnimation(PLAYER_ATTACK1)

	self:EmitSound(snd)

	if SERVER then
		local ent = ents.Create(class)

		ent:SetAngles(ply:EyeAngles())
		ent:SetPos(ply:M9K_GetShootPos())
		ent:SetOwner(ply)
		ent:SetPhysicsAttacker(ply)
		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		phys:SetVelocity(ply:GetAimVector() * 1500)
		phys:AddAngleVelocity(Vector(0, 500, 0))

		timer.Simple(0, function()
			if not self:IsValid() or not ply:IsValid() then
				return
			end

			ply:StripWeapon(self:GetClass())
		end)
	end
end
