AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_jackhammer")
end

-- Base info
SWEP.PrintName = "Pancor Jackhammer"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 60

SWEP.ViewModel = Model("models/weapons/v_jackhammer2.mdl")
SWEP.WorldModel = Model("models/weapons/w_pancor_jackhammer.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 240 -- Rounds Per Minute
SWEP.Primary.NumShots = 6 -- Bullets fired per shot
SWEP.Primary.Damage = 10 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.045 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.045 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_Jackhammer.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(4.026, -2.296, 0.917) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(-3.116, -3.935, 0.492) -- Applied while sprinting
SWEP.RunSightsAng = Vector(-19.894, -47.624, 10.902)
