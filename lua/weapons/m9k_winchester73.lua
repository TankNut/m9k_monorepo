AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_winchester73")
end

-- Base info
SWEP.PrintName = "73 Winchester Carbine"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_winchester1873.mdl")
SWEP.WorldModel = Model("models/weapons/w_winchester_1873.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 66 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 85 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.01 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.001 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_73.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.54 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(3, 0, 1) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 2)

SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965) -- Applied while sprinting
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)
