AddCSLuaFile()
DEFINE_BASECLASS("m9k_nade_base")

SWEP.Base = "m9k_nade_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m61_frag")
end

-- Base info
SWEP.PrintName = "Frag Grenade"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_invisible_nade.mdl")
SWEP.WorldModel = Model("models/weapons/w_grenade.mdl")

-- Stats
SWEP.Primary.Ammo = "Grenade"

SWEP.GrenadeClass = "m9k_thrown_m61"
