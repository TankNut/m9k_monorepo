AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_vector")
end

-- Base info
SWEP.PrintName = "KRISS Vector"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_kriss_svs.mdl")
SWEP.WorldModel = Model("models/weapons/w_kriss_vector.mdl")

SWEP.HoldType = "smg"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 1000 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 18 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.026 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.014 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "kriss_vector.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 50 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 1)

SWEP.SightsPos = Vector(2, -2, 0.5) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 1)

SWEP.RunSightsPos = Vector(-3.701, -6.064, -0.551) -- Applied while sprinting
SWEP.RunSightsAng = Vector(-4.685, -62.559, 9.093)
