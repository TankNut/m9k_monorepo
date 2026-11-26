AddCSLuaFile()
DEFINE_BASECLASS("m9k_melee_base")

SWEP.Base = "m9k_melee_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_knife")
end

-- Base info
SWEP.PrintName = "Knife"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 0

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_knife_x.mdl")
SWEP.WorldModel = Model("models/weapons/w_extreme_ratio.mdl")

SWEP.BaseData = {
	DamageType = DMG_SLASH,
	CanBackstab = true,
	Sound = "weapons/blades/woosh.ogg",
	StabSound = "weapons/blades/slash.ogg",
	WallSound = "weapons/blades/hitwall.ogg",
	Range = 55,
	Hull = 5
}

SWEP.AttackData = {
	{
		Delay = 0.05,
		Window = 0.15,
		Damage = 35,
		BackstabSound = "weapons/blades/slash.ogg"
	}, {
		Delay = 0.33,
		Window = 0.15,
		Damage = 80,
		BackstabSound = "weapons/blades/nastystab.ogg"
	}
}

function SWEP:Deploy()
	BaseClass.Deploy(self)
	self:EmitSound("weapons/knife/knife_draw_x.ogg", 50, 100)

	return true
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", "AltSlash")
end

function SWEP:PrimaryAttack()
	local sequence = self:GetAltSlash() and "midslash2" or "midslash1"

	self:StartAttack(1, sequence, 0.35)
	self:SetAltSlash(not self:GetAltSlash())
end

function SWEP:SecondaryAttack()
	self:StartAttack(2, "stab", 1.25)
end

function SWEP:Reload()
	self:Throw("m9k_thrown_spec_knife", "weapons/blades/woosh.ogg")
end
