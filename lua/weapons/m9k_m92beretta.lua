AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m92beretta")
end

-- Base info
SWEP.PrintName = "M92 Beretta"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Pistols"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_pistberettam92.mdl")
SWEP.WorldModel = Model("models/weapons/w_beretta_m92.mdl")

SWEP.HoldType = "pistol"

-- Stats
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = 45

SWEP.Primary.RPM = 500 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 14 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.027 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.019 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_m92b.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -2.379, 0, 1.205 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.05, 0, 0 )

SWEP.RunSightsPos = Vector( 3.444, -7.823, -6.27 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 60.695, 0, 0 )
