AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_striker12")
end

-- Base info
SWEP.PrintName = "Striker 12"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_striker_12g.mdl")
SWEP.WorldModel = Model("models/weapons/w_striker_12g.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 36

SWEP.Primary.RPM = 365 -- Rounds Per Minute
SWEP.Primary.NumShots = 6 -- Bullets fired per shot
SWEP.Primary.Damage = 8 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.04 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.04 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.6 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "ShotStriker12.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.3 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 1, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 2, 0)

SWEP.SightsPos = Vector(2, 1, 1) -- Applied while aiming
SWEP.SightsAng = Vector(0, 2, 0)

SWEP.RunSightsPos = Vector( -3.237, -6.376, 1.167 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -8.391, -63.543, 0 )
