AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_ithacam37")
end

-- Base info
SWEP.PrintName = "Ithaca M37"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_ithaca_m37shot.mdl")
SWEP.WorldModel = Model("models/weapons/w_ithaca_m37.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 60 -- Rounds Per Minute
SWEP.Primary.NumShots = 8 -- Bullets fired per shot
SWEP.Primary.Damage = 12 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.023 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.023 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.9 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.6 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.6 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "IthacaM37.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.4 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.16, -1.429, 0.6 ) -- Applied while aiming
SWEP.SightsAng = Vector( 3, 0, 0 )

SWEP.RunSightsPos = Vector( -3.116, -3.935, 0.492 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -19.894, -47.624, 10.902 )
