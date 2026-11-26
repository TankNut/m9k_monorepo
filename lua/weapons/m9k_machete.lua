AddCSLuaFile()
DEFINE_BASECLASS("m9k_melee_base")

SWEP.Base = "m9k_melee_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_machete")
end

-- Base info
SWEP.PrintName = "Machete"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 0

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60

SWEP.ViewModel = Model("models/weapons/v_machete.mdl")
SWEP.WorldModel = Model("models/weapons/w_fc2_machete.mdl")

SWEP.BaseData = {}
SWEP.AttackData = {
	{
		Delay = 0.23,
		Window = 0.15,
		Damage = 150,
		DamageType = DMG_SLASH,
		CanBackstab = false,
		Sound = "weapons/blades/woosh.ogg",
		StabSound = "weapons/blades/slash.ogg",
		WallSound = "weapons/blades/hitwall.ogg",
		Range = 42,
		Hull = 8
	}
}

function SWEP:Deploy()
	BaseClass.Deploy(self)
	self:EmitSound("weapons/knife/knife_draw_x.ogg", 50, 100)

	return true
end

function SWEP:PrimaryAttack()
	self:StartAttack(1, "stab", 0.8)
end

function SWEP:SecondaryAttack()
	self:Throw("m9k_thrown_knife", "Weapon_Knife.Slash")
end
