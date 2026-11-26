AddCSLuaFile()
DEFINE_BASECLASS("m9k_nade_base")

SWEP.Base = "m9k_nade_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_nerve_gas")
end

-- Base info
SWEP.PrintName = "Nerve Gas"
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
SWEP.Primary.Ammo = "NerveGas"

SWEP.GrenadeClass = "m9k_nervegasnade"

SWEP.VElements = {{
	Model = Model("models/healthvial.mdl"),
	Bone = "v_weapon.Flashbang_Parent",
	Pos = Vector(-0.076, 0.24, 0.063),
	Ang = Angle(17.351, 8.782, 99.302),
	Scale = Vector(0.54, 0.54, 0.54),
	Material = Material("models/weapons/gv/nerve_vial.vmt")
}}

SWEP.HideWorldModel = true
SWEP.WElements = {{
	Model = Model("models/healthvial.mdl"),
	Bone = "ValveBiped.Bip01_R_Hand",
	Pos = Vector(3.22, -2.107, -4.025),
	Ang = Angle(0, 0, 0),
	Scale = Vector(0.865, 0.865, 0.865),
	Material = Material("models/weapons/gv/nerve_vial.vmt")
}}
