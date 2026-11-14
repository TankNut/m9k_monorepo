AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m3")
end

-- Base info
SWEP.PrintName = "Benelli M3"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_benelli_m3_s90.mdl")
SWEP.WorldModel = Model("models/weapons/w_benelli_m3.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 70 -- Rounds Per Minute
SWEP.Primary.NumShots = 9 -- Bullets fired per shot
SWEP.Primary.Damage = 10 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.0326 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.0326 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.8 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "BenelliM3.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.45 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.279, -1.007, 1.302 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.47, -0.024, 0 )

SWEP.RunSightsPos = Vector( -7.639, -7.796, 0.865 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -17.362, -69.724, 0 )
