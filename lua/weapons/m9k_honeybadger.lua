AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_honeybadger")
end

-- Base info
SWEP.PrintName = "AAC Honey Badger"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_aacbadger.mdl")
SWEP.WorldModel = Model("models/weapons/w_aac_honeybadger.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 791 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 24 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.023 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.014 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_HoneyB.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 3.5 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseAimpoint = true

SWEP.ScopeScale = 0.7
SWEP.ReticleScale = 0.6

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = false -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -3.096, -3.695, 0.815 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.039, 0, 0 )

SWEP.RunSightsPos = Vector( 4.094, -2.454, -0.618 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -8.957, 53.188, -9.195 )
