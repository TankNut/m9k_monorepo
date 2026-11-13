AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_auga3")
end

-- Base info
SWEP.PrintName = "Steyr AUG A3"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_auga3sa.mdl")
SWEP.WorldModel = Model("models/weapons/w_auga3.mdl")

SWEP.HoldType = "smg"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 700 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 22 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.025 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.02 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "aug_a3.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 4 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseAimpoint = true

SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.6

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = false -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.275, -2.9708, 0.5303 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 0 )

SWEP.RunSightsPos = Vector( -3.0328, 0, 1.888 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -24.2146, -36.522, 10 )
