AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_kac_pdw")
end

-- Base info
SWEP.PrintName = "KAC PDW"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Submachine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_kac_pdw1.mdl")
SWEP.WorldModel = Model("models/weapons/w_kac_pdw.mdl")

SWEP.HoldType = "smg"

-- Stats
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 600 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 15 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.02 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.015 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "KAC_PDW.Single" -- Sound played when firing
SWEP.Primary.SilencedSound  = "KAC_PDW.SilentSingle"

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = true -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 3.342, 0, 0.514 ) -- Applied while aiming
SWEP.SightsAng = Vector( 2.46, -0.025, 0 )

SWEP.RunSightsPos = Vector( -4.646, -4.173, 0 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -10.197, -53.189, 0 )
