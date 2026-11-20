AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_uzi")
end

-- Base info
SWEP.PrintName = "UZI"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_imi_uzi01.mdl")
SWEP.WorldModel = Model("models/weapons/w_uzi_imi.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 64

SWEP.Primary.RPM = 600 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 20 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.028 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.018 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_uzi.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(-1, 0, 0.2) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector( 3.858, -2.945, 0.057 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -5.237, 40.471, 0 )
