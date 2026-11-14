AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_f2000")
end

-- Base info
SWEP.PrintName = "F2000"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_tct_f2000.mdl")
SWEP.WorldModel = Model("models/weapons/w_fn_f2000.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 850 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 23 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.025 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.015 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_F2000.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 4 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseACOG = true

SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.6

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = false -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 3.499, 0, 1.08 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 0 )

SWEP.RunSightsPos = Vector( -7.705, -2.623, 1.475 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -11.476, -55.083, -2.296 )
