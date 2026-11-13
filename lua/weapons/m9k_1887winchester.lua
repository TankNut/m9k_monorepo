AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_1887winchester")
end

-- Base info
SWEP.PrintName = "Winchester 87"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_1887winchester.mdl")
SWEP.WorldModel = Model("models/weapons/w_winchester_1887.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 12

SWEP.Primary.RPM = 70 -- Rounds Per Minute
SWEP.Primary.NumShots = 10 -- Bullets fired per shot
SWEP.Primary.Damage = 10 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.042 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.042 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.8 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.6 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "1887winch.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 4.84, 0, 1.2 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 2.295 )

SWEP.RunSightsPos = Vector( -2.3095, -3.0514, 2.3965 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -19.8471, -33.9181, 10 )
