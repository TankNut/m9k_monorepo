AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_minigun")
end

-- Base info
SWEP.PrintName = "M134 Minigun"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Machine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_minigunvulcan.mdl")
SWEP.WorldModel = Model("models/weapons/w_m134_minigun.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 300
SWEP.Primary.DefaultClip = 600

SWEP.Primary.RPM = 3500 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 25 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.035 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.035 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "BlackVulcan.Single" -- Sound played when firing

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector( 0, -11.148, -8.033 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 55.082, 0, 0 )

function SWEP:ShouldAimState()
	return false
end

function SWEP:SetWeaponAnim(act)
	if act == ACT_VM_IDLE then return end

	return BaseClass.SetWeaponAnim(self, act)
end
