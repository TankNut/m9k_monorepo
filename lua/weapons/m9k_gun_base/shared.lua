AddCSLuaFile()

--[[
	A note about variable naming for GetOwner():

	ply, owner and npc are used interchangably based on which code paths are reachable for which type, SWEP:Think and Reload never get called by NPC's for example so we can safely assume it'll be a player whereas SWEP:PrimaryFire will be called by NPC's, hence the use of owner in that context.
]]

SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_tct_famas.mdl")
SWEP.WorldModel = Model("models/weapons/w_tct_famas.mdl")

SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 950
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 29

SWEP.Primary.SpreadHip = .025
SWEP.Primary.SpreadIronSights = .015

SWEP.Primary.Sound = "Weapon_FAMTC.Single"

include("sh_attack.lua")
include("sh_reload.lua")
include("sh_running.lua")

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetAutomatic(self.Primary.Automatic)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "FinishReload")
	self:NetworkVar("Bool", "Running")
	self:NetworkVar("Bool", "Automatic") -- Honestly might be better to make it an int so you can do burst fire
	self:NetworkVar("Bool", "Silencer")
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty") -- Could be a var
		self:Reload()

		return false
	end

	if not self.CanShootWhileRunning and self:GetRunning() then
		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self.Primary.Automatic = self:GetAutomatic()

	self:TakePrimaryAmmo(1)

	self:FireEffects()
	self:FireWeapon()

	self:SetNextPrimaryFire(CurTime() + 1 / (self.Primary.RPM / 60))
end

function SWEP:Think()
	-- Alternatively: if SERVER or not game.SinglePlayer() then
	-- Important for any code that does prediction-y stuff
	if GetPredictionPlayer():IsValid() then
		self:UpdateRunning()
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end
