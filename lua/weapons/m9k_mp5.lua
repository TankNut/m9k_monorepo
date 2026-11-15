AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_mp5")
end

-- Base info
SWEP.PrintName = "HK MP5"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_navymp5.mdl")
SWEP.WorldModel = Model("models/weapons/w_hk_mp5.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 800 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 22 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.023 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.013 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "mp5_navy_Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.549, -0.927, 1.09 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.125, -0.071, 0 )

SWEP.RunSightsPos = Vector( -3.0328, 0, 1.888 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -24.2146, -36.522, 10 )
