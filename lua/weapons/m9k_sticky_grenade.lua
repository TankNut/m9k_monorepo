AddCSLuaFile()
DEFINE_BASECLASS("m9k_nade_base")

SWEP.Base = "m9k_nade_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_sticky_grenade")
end

-- Base info
SWEP.PrintName = "Sticky Grenade"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_sticky_grenade.mdl")
SWEP.WorldModel = Model("models/weapons/w_sticky_grenade.mdl")

-- Stats
SWEP.Primary.Ammo = "StickyGrenade"

SWEP.GrenadeClass = "m9k_thrown_sticky_grenade"

SWEP.WElements = {{
	Model = Model("models/weapons/w_sticky_grenade.mdl"),
	Bone = "ValveBiped.Bip01_R_Hand",
	Pos = Vector(20.322, -2.828, -1.349),
	Ang = Angle(180, -3.81, 5.743),
	Scale = Vector(1.376, 1.376, 1.376)
}}
