AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_luger")
end

-- Base info
SWEP.PrintName = "P08 Luger"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_p08_luger.mdl")
SWEP.WorldModel = Model("models/weapons/w_luger_p08.mdl")

SWEP.HoldType = "pistol"

-- Stats
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 45

SWEP.Primary.RPM = 825 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 23 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.021 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.011 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.35 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "weapon_luger.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 2.71, -2.122, 2.27 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.563, -0.013, 0 )

SWEP.RunSightsPos = Vector( 0, 0, 2.575 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -14.657, 0, 0 )
