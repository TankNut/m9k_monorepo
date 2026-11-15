AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_mossberg590")
end

-- Base info
SWEP.PrintName = "Mossberg 590"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60

SWEP.ViewModel = Model("models/weapons/v_shot_mberg_590.mdl")
SWEP.WorldModel = Model("models/weapons/w_mossberg_590.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 75 -- Rounds Per Minute
SWEP.Primary.NumShots = 10 -- Bullets fired per shot
SWEP.Primary.Damage = 9 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.03 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.03 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.8 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.8 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Mberg_590.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.5 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -2.72, -3.143, 1.26 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, -0.75, 3 )

SWEP.RunSightsPos = Vector( 7, -9.429, -0.857 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -7, 63, 0 )
