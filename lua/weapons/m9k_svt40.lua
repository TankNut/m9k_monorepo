AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_svt40")
end

-- Base info
SWEP.PrintName = "SVT 40"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Sniper Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_snip_svt40.mdl")
SWEP.WorldModel = Model("models/weapons/w_svt_40.mdl")

SWEP.HoldType = "rpg"

-- Stats
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 350 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 80 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.01 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.0001 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_SVT40.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 5 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseMilDot = true

SWEP.ScopeScale = 0.7
SWEP.ReticleScale = 0.6

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = false -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -2) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(-3.462, -1.775, 0.079) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector(3.388, -4.501, 0) -- Applied while sprinting
SWEP.RunSightsAng = Vector(-9.096, 47.727, 0)
