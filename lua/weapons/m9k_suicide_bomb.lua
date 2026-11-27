AddCSLuaFile()

SWEP.m_WeaponDeploySpeed = 10

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_suicide_bomb")
end

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.PrintName = "Timed C4"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/v_sb.mdl")
SWEP.WorldModel = Model("models/weapons/w_sb.mdl")

SWEP.Primary.Ammo = "C4Explosive"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "Delay")
	self:NetworkVar("Float", "FinishPlant")

	if SERVER then
		self:SetDelay(5)
	end
end

function SWEP:Deploy()
	self:SetHoldType("slam")
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire(CurTime())

	return true
end

function SWEP:Holster()
	self:SetFinishPlant(0)

	return true
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:SetFinishPlant(CurTime() + self:SequenceDuration())
	self:SetNextPrimaryFire(math.huge)
	self:SetNextSecondaryFire(math.huge)
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	self:EmitSound("C4.PlantSound")

	local delay = self:GetDelay()

	if delay == 5 then
		delay = 10
	elseif delay == 10 then
		delay = 15
	elseif delay == 15 then
		delay = 20
	elseif delay == 20 then
		delay = 0
	elseif delay == 0 then
		delay = 5
	end

	self:SetDelay(delay)

	if SERVER then
		local ply = self:GetOwner()

		if delay == 0 then
			ply:PrintMessage(HUD_PRINTCENTER, "WARNING! TIMER REDUCED TO ZERO!")
		else
			ply:PrintMessage(HUD_PRINTCENTER, string.format("Timer set to %s.", string.NiceTime(delay)))
		end
	end
end

function SWEP:Reload()
end

function SWEP:PlantC4()
	self:TakePrimaryAmmo(1)

	local ply = self:GetOwner()

	ply:SetAnimation(PLAYER_ATTACK1)

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire(CurTime())

	if SERVER then
		local tr = util.TraceLine({
			start = ply:M9K_GetShootPos(),
			endpos = ply:M9K_GetShootPos() + ply:GetAimVector() * 100,
			filter = ply
		})

		tr.HitNormal.z = -tr.HitNormal.z

		local ent = ents.Create("m9k_mad_c4")
		ent:SetPos(tr.HitPos + tr.HitNormal)
		ent:SetAngles(tr.HitNormal:Angle() - Angle(90, 180, 0))
		ent.BombOwner = ply
		ent.Timer = self:GetDelay()
		ent:Spawn()
		ent:Activate()

		if tr.Hit then
			local attach = tr.Entity

			if string.find(attach:GetClass(), "^m9k_ammo_") then
				ent:SetParent(attach)
				attach.Planted = true
			elseif not attach:IsNPC() and not attach:IsPlayer() then
				ent:SetParent(attach)
			end
		else
			ent:SetMoveType(MOVETYPE_VPHYSICS)
		end

		if self:Ammo1() == 0 then
			timer.Simple(0, function()
				if not self:IsValid() or not ply:IsValid() then
					return
				end

				ply:StripWeapon(self:GetClass())
			end)
		end
	end
end

function SWEP:Suicide()
	if not IsFirstTimePredicted() then return end

	local ply = self:GetOwner()
	local pos = ply:GetPos()

	local effect = EffectData()
	effect:SetOrigin(pos)

	util.Effect("ThumperDust", effect)
	util.Effect("Explosion", effect)

	effect:SetNormal(Vector(0, 0, 1))
	effect:SetEntity(owner)
	effect:SetScale(1.3)
	effect:SetRadius(67)
	effect:SetMagnitude(18)
	util.Effect("m9k_gdcw_cinematicboom", effect)

	self:TakePrimaryAmmo(1)

	if SERVER then
		ply:Kill()

		util.ScreenShake(pos, 2000, 255, 2.5, 1250)
		util.BlastDamage(self, ply, pos, 500, 500)
	end

	self:EmitSound("C4.Explode", 70)
end

function SWEP:Think()
	local time = self:GetFinishPlant()
	local ct = CurTime()

	if time > 0 and time <= ct then
		self:SetFinishPlant(0)

		if self:GetDelay() == 0 then
			self:Suicide()
		else
			self:PlantC4()
		end
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end
