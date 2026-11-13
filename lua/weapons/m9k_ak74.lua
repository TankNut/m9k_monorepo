AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_ak74")
end

-- Base info
SWEP.PrintName = "AK-74"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_tct_ak47.mdl")
SWEP.WorldModel = Model("models/weapons/w_tct_ak47.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 600 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 31 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.02 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.01 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Tactic_AK47.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector (2.0378, 1, 0.8809) -- Applied while aiming
SWEP.SightsAng = Vector (0, 0, 0)

SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965) -- Applied while sprinting
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)
