AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_val")
end

-- Base info
SWEP.PrintName = "AS VAL"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_dmg_vally.mdl")
SWEP.WorldModel = Model("models/weapons/w_dmg_vally.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 900 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 27 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.019 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.008 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Dmgfok_vally.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, -1)

SWEP.SightsPos = Vector(-1, 0, 0) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, -1)

SWEP.RunSightsPos = Vector (0.3339, -2.043, 0.6273) -- Applied while sprinting
SWEP.RunSightsAng = Vector (-11.5931, 48.4648, -19.7039)
