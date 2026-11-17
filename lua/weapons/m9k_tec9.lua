AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_tec9")
end

-- Base info
SWEP.PrintName = "TEC-9"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_tec_9_smg.mdl")
SWEP.WorldModel = Model("models/weapons/w_intratec_tec9.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 32
SWEP.Primary.DefaultClip = 64

SWEP.Primary.RPM = 825 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 17 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.029 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.019 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_Tec9.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 4.314, -1.216, 2.135 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 0 )

SWEP.RunSightsPos = Vector( -5.434, -1.181, 0.393 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -6.89, -42.166, 0 )
