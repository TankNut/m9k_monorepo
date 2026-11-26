AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_model500")
end

-- Base info
SWEP.PrintName = "S&W Model 500"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_swmodel_500.mdl")
SWEP.WorldModel = Model("models/weapons/w_sw_model_500.mdl")

SWEP.HoldType = "revolver"

-- Stats
SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 100 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 40 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.02 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.015 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Model_500.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(-1, 0, -0.5) -- Applied while aiming
SWEP.SightsAng = Vector()

SWEP.RunSightsPos = Vector( 3.444, -7.823, -6.27 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 60.695, 0, 0 )
