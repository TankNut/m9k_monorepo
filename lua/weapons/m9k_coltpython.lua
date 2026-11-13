AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_coltpython")
end

-- Base info
SWEP.PrintName = "Colt Python"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_pist_python.mdl")
SWEP.WorldModel = Model("models/weapons/w_colt_python.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 115 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 29 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.02 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.01 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_ColtPython.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -2.7, -1.676, 1.796 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.611, 0.185, 0 )

SWEP.RunSightsPos = Vector( 2.124, -9.365, -3.987 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 48.262, -8.214, 0 )
