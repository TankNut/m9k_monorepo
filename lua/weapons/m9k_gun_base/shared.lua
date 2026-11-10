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

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0

SWEP.SelectiveFire = true
SWEP.CanBeSilenced = false

include("sh_attack.lua")
include("sh_modes.lua")
include("sh_reload.lua")
include("sh_running.lua")

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetAutomatic(self.Primary.Automatic)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "FinishReload")
	self:NetworkVar("Float", "NextAction")

	self:NetworkVar("Bool", "Running")
	self:NetworkVar("Bool", "Automatic") -- Honestly might be better to make this an int so you can do burst fire
	self:NetworkVar("Bool", "Silencer")
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty") -- Could be a var
		self:StartReload()
		self.Primary.Automatic = false -- Anti-sound spam

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

	self:CheckAmmo()
end

function SWEP:SecondaryAttack()
end

-- Important for any code that does prediction-y stuff
function SWEP:PredictionThink()
	self:UpdateRunning()
	self:UpdateModes()
end

function SWEP:Think()
	-- Alternatively: if SERVER or not game.SinglePlayer() then
	if GetPredictionPlayer():IsValid() then
		self:PredictionThink()
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end
