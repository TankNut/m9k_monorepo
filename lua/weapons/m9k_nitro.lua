AddCSLuaFile()
DEFINE_BASECLASS("m9k_nade_base")

SWEP.Base = "m9k_nade_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_nitro")
end

-- Base info
SWEP.PrintName = "Nitro Glycerine"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_invisible_nade.mdl")
SWEP.WorldModel = Model("models/weapons/w_nitro.mdl")

-- Stats
SWEP.Primary.Ammo = "nitroG"

SWEP.GrenadeClass = "m9k_thrown_nitrox"

SWEP.VElements = {{
	Model = Model("models/weapons/w_nitro.mdl"),
	Bone = "v_weapon.Flashbang_Parent",
	Pos = Vector(-4.538, -7.218, -14.072),
	Ang = Angle(-164.236, 6.253, -97.573),
	Scale = Vector(0.666, 0.666, 0.666)
}}

SWEP.ViewModelBoneMods = {
	["v_weapon.Left_Middle01"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0, 17.5, 0)},
	["v_weapon.Left_Ring01"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0, 23.271, 0)},
	["v_weapon.Left_Index01"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0, 25.108, 0)},
	["v_weapon.Left_Pinky01"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0), Ang = Angle(0, 34.459, 0)}
}
