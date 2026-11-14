AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_intervention")
end

-- Base info
SWEP.PrintName = "Intervention"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Sniper Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_snip_int.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_int.mdl")

SWEP.HoldType = "rpg"

-- Stats
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 35 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 95 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.01 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.0001 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.6 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_INT.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 10 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseMilDot = true

SWEP.ScopeScale = 0.7
SWEP.ReticleScale = 0.6

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = true -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.2263, -0.0007, 0.115 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 0 )

SWEP.RunSightsPos = Vector( -2.3095, -3.0514, 1.3965 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -19.8471, -33.9181, 10 )
