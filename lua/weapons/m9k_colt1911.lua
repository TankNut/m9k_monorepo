AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_colt1911")
end

-- Base info
SWEP.PrintName = "Colt 1911"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/f_dmgf_co1911.mdl")
SWEP.WorldModel = Model("models/weapons/s_dmgf_co1911.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 45

SWEP.Primary.RPM = 700 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 17 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.025 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.015 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Dmgfok_co1911.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -2.6004, -1.3877, 1.1892 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.3756, -0.0032, 0.103 )

SWEP.RunSightsPos = Vector( 3.444, -7.823, -6.27 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 60.695, 0, 0 )
