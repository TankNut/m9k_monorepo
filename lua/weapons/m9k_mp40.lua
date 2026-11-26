AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_mp40")
end

-- Base info
SWEP.PrintName = "MP40"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 55

SWEP.ViewModel = Model("models/weapons/v_mp40smg.mdl")
SWEP.WorldModel = Model("models/weapons/w_mp40smg.mdl")

SWEP.HoldType = "smg"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 64

SWEP.Primary.RPM = 500 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 25 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.022 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.015 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.2 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "mp40.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(2, 0, 0.2) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(-5.119, -4.173, 0.865) -- Applied while sprinting
SWEP.RunSightsAng = Vector(-9.094, -56.496, 0)
