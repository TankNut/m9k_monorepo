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

SWEP.VElements = {{
	Model = Model("models/weapons/w_m61_fraggynade.mdl"),
	Bone = "v_weapon.Flashbang_Parent",
	Pos = Vector(0.194, -1.316, 0.54),
	Ang = Angle(-95.096, 12.285, -97.221),
	Scale = Vector(1, 1, 1)
}}

SWEP.WElements = {{
	Model = Model("models/weapons/w_m61_fraggynade.mdl"),
	Bone = "ValveBiped.Bip01_R_Hand",
	Pos = Vector(3.611, -1.751, -2.003),
	Ang = Angle(143.148, -5.699, 0),
	Scale = Vector(1.348, 1.348, 1.348)
}}

SWEP.ViewModelBoneMods = {
	["v_weapon.Root16"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0.293, 0, 0)},
	["v_weapon.Left_Thumb03"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(-9.509, 4.019, -0.26)},
	["v_weapon.Left_Thumb01"] = {Scale = Vector(1, 1, 1), Pos = Vector(-0.362, 0, 0), Ang = Angle(0.465, 15.345, 9.413)},
	["v_weapon.Root17"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0.423, 12.668, 1.228)}
}
