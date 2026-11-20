AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m60")
end

-- Base info
SWEP.PrintName = "M60 Machine Gun"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Machine Guns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.ViewModel = Model("models/weapons/v_m60machinegun.mdl")
SWEP.WorldModel = Model("models/weapons/w_m60_machine_gun.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 400

SWEP.Primary.RPM = 575 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 33 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.035 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.025 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.6 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_M_60.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 65 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(-1, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(-2, 0, 1.5) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector( 8.689, -3.444, -0.82 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( 0, 44.18, 0 )
