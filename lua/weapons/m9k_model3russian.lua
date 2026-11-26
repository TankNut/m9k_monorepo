AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_model3russian")
end

-- Base info
SWEP.PrintName = "S&W Model 3 Russian"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 60

SWEP.ViewModel = Model("models/weapons/v_pist_model3.mdl")
SWEP.WorldModel = Model("models/weapons/w_model_3_rus.mdl")

SWEP.HoldType = "revolver"

-- Stats
SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 115 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 30 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.02 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.01 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Model3.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(1, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(2, 0, -0.5) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(-0.165, -10.329, -5.41) -- Applied while sprinting
SWEP.RunSightsAng = Vector(70, 0, 0)
