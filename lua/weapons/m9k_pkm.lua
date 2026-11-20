AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_pkm")
end

-- Base info
SWEP.PrintName = "PKM"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Machine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_mach_russ_pkm.mdl")
SWEP.WorldModel = Model("models/weapons/w_mach_russ_pkm.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 200

SWEP.Primary.RPM = 750 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 33 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.035 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.02 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.6 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "pkm.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(-1, 0.5, 0)

SWEP.SightsPos = Vector(-1, 0, 0) -- Applied while aiming
SWEP.SightsAng = Vector(-1, 0, 0)

SWEP.RunSightsPos = Vector( 5.276, -3.859, 0 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -14.606, 52.087, 0 )
