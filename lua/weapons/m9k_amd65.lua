AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_amd65")
end

-- Base info
SWEP.PrintName = "AMD 65"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_amd_65.mdl")
SWEP.WorldModel = Model("models/weapons/w_amd_65.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 750 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 31 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.021 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.011 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.7 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.2 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "amd65.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 3.5, -1, 2.115 ) -- Applied while aiming
SWEP.SightsAng = Vector( -3.701, 0, 0 )

SWEP.RunSightsPos = Vector( -5.198, -9.164, 0 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -8.825, -70, 0 )
