AddCSLuaFile()

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.Spawnable = false

SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/v_invisible_nade.mdl")
SWEP.WorldModel = Model("models/weapons/w_grenade.mdl")

SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

SWEP.GrenadeClass = "m9k_thrown_m61"

AddCSLuaFile("cl_sck.lua")

if CLIENT then
	include("cl_sck.lua")
end

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", "Roll")

	self:NetworkVar("Float", "ThrowTime")
	self:NetworkVar("Float", "ReloadTime")
end

function SWEP:Deploy()
	self:SetHoldType("normal")

	return true
end

function SWEP:Holster()
	self:SetThrowTime(0)
	self:SetReloadTime(0)

	return true
end

function SWEP:PrimeThrow(roll)
	if self:GetThrowTime() != 0 or self:GetReloadTime() != 0 then
		return
	end

	self:SetHoldType("grenade")
	self:SendWeaponAnim(ACT_VM_PULLPIN)

	self:SetRoll(roll)
	self:SetThrowTime(CurTime() + self:SequenceDuration())
end

function SWEP:PrimaryAttack()
	self:PrimeThrow(false)
end

function SWEP:SecondaryAttack()
	self:PrimeThrow(true)
end

function SWEP:Throw()
	local ply = self:GetOwner()

	ply:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_THROW)

	self:TakePrimaryAmmo(1)

	if SERVER then
		local dir = ply:GetAimVector()
		local ent = ents.Create(self.GrenadeClass)

		ent._m9kOwner = ply
		ent.DoNotDuplicate = true
		ent:SetOwner(ply)
		ent:SetAngles(dir:Angle())
		ent:SetPos(LocalToWorld(Vector(0, -5, 1), angle_zero, ply:M9K_GetShootPos(), dir:Angle()))
		ent:Spawn()

		dir.z = dir.z + 0.1
		dir:Normalize()

		local phys = ent:GetPhysicsObject()

		phys:SetVelocity(ply:GetVelocity())
		phys:ApplyForceCenter(dir * (self:GetRoll() and 2000 or 5500))
	end

	self:SetThrowTime(0)
	self:SetReloadTime(CurTime() + 0.7)
end

function SWEP:FinishReload()
	self:SetHoldType("normal")
	self:SetReloadTime(0)

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())

	if SERVER and self:Ammo1() == 0 then
		local ply = self:GetOwner()

		timer.Simple(0, function()
			if not ply:IsPlayer() or not self:IsValid() then return end

			ply:StripWeapon(self:GetClass())
		end)
	end
end

function SWEP:Think()
	if not GetPredictionPlayer():IsValid() then
		return
	end

	local ply = self:GetOwner()
	local throw = self:GetThrowTime()
	local reload = self:GetReloadTime()
	local key = self:GetRoll() and IN_ATTACK2 or IN_ATTACK

	if throw > 0 and throw <= CurTime() and not ply:KeyDown(key) then
		self:Throw()
	end

	if reload > 0 and reload <= CurTime() then
		self:FinishReload()
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())

	if CLIENT then
		self:RemoveFakeEntities()
	end
end

function SWEP:OnRemove()
	if CLIENT then
		self:RemoveFakeEntities()
	end
end
