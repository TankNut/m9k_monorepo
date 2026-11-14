AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_dbarrel")
end

-- Base info
SWEP.PrintName = "Double Barrel Shotgun"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_doublebarrl.mdl")
SWEP.WorldModel = Model("models/weapons/w_double_barrel_shotgun.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 250 -- Rounds Per Minute
SWEP.Primary.NumShots = 18 -- Bullets fired per shot
SWEP.Primary.Damage = 10 -- Damage per single bullet

-- Recoil
SWEP.Primary.KickUp = 10 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Double_Barrel.Single" -- Sound played when firing

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.5 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector( 11.475, -7.705, -2.787 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 0.574, 51.638, 5.737 )

function SWEP:ShouldAimState()
	return false
end

local isDoubleShot = false

function SWEP:TakeAmmo()
	self:TakePrimaryAmmo(isDoubleShot and 2 or 1)
end

function SWEP:GetAimCone()
	return isDoubleShot and 0.06 or 0.03
end

function SWEP:ModifyBullet(bullet)
	if isDoubleShot then
		bullet.Num = 31
	end
end

function SWEP:SecondaryAttack()
	if self:GetNextPrimaryFire() > CurTime() then return end

	if self:Clip1() == 2 then
		isDoubleShot = true
	end

	self:PrimaryAttack()

	isDoubleShot = false
end
