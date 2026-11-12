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

SWEP.Primary.SpreadHip = 0.025
SWEP.Primary.SpreadIronSights = 0.015

SWEP.Primary.KickUp = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

SWEP.KickUpMultiplier = 2
SWEP.RecoilKickSpeed = 40

SWEP.Primary.Sound = "Weapon_FAMTC.Single"

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0

SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better
SWEP.Secondary.ScopeZoom = 0 -- Overrides SWEP.Secondary.IronFOV when set

SWEP.SelectiveFire = true
SWEP.CanBeSilenced = false

SWEP.IronSightTime = 0.15
SWEP.ViewModelCorrection = 0 -- How much correction to apply to SWEP.ViewModelFOV when zooming, range [0-1]

SWEP.CustomIdlePos = Vector(0, 0, -1)
SWEP.CustomIdleAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-1, 0, 0)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(1, -3.6, -1)
SWEP.RunSightsAng = Vector(-10, 44, -18)

include("sh_attack.lua")
include("sh_bullet.lua")
include("sh_modes.lua")
include("sh_recoil.lua")
include("sh_reload.lua")
include("sh_running.lua")
include("sh_view.lua")

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetAutomatic(self.Primary.Automatic)

	if CLIENT then
		self.BaseViewModelFOV = self.ViewModelFOV
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "FinishReload")
	self:NetworkVar("Float", "NextAction")
	self:NetworkVar("Float", "CheckAmmo")
	self:NetworkVar("Float", "RunState")
	self:NetworkVar("Float", "AimState")

	self:NetworkVar("Bool", "Running")
	self:NetworkVar("Bool", "Automatic") -- Honestly might be better to make this an int so you can do burst fire
	self:NetworkVar("Bool", "Silencer")

	self:NetworkVar("Angle", "ActiveRecoil")
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self:SetActiveRecoil(angle_zero)

	return true
end

function SWEP:Holster()
	self:SetFinishReload(0) -- Cancel any in-progress reloads

	return true
end

function SWEP:CanPrimaryAttack()
	if self:IsReloading() then return false end

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

	local delay = 1 / (self.Primary.RPM / 60)

	self:SetNextPrimaryFire(CurTime() + delay)
	self:SetCheckAmmo(CurTime() + delay)
end

function SWEP:SecondaryAttack()
end

function SWEP:ShouldRunState()
	if self:IsReloading() then return false end

	return self:GetRunning()
end

function SWEP:ShouldAimState()
	if self:GetRunning() then return false end

	return self:GetOwner():KeyDown(IN_ATTACK2)
end

function SWEP:UpdateStates()
	local running = self:ShouldRunState()
	local aiming = self:ShouldAimState()

	local rate = (1 / self.IronSightTime) * FrameTime()

	self:SetRunState(math.Approach(self:GetRunState(), running and 1 or 0, rate))
	self:SetAimState(math.Approach(self:GetAimState(), aiming and 1 or 0, rate))
end

-- Important for any code that does prediction-y stuff
function SWEP:PredictionThink()
	self:UpdateRunning()
	self:UpdateModes()
	self:UpdateRecoil()
	self:UpdateReload()
end

function SWEP:Think()
	-- Alternatively: if SERVER or not game.SinglePlayer() then
	if GetPredictionPlayer():IsValid() then
		self:PredictionThink()
	end

	self:UpdateStates()

	if CLIENT then
		-- TODO: CanShootWhileRunning lerps to 0.25 instead, figure out how to implement this
		local state = Lerp(self:GetAimState(), 1, 0.25)

		self.SwayScale = state
		self.BobScale = state
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())

	if CLIENT then
		self.BaseViewModelFOV = self.ViewModelFOV
	end
end
