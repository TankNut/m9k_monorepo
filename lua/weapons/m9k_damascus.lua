AddCSLuaFile()
DEFINE_BASECLASS("m9k_melee_base")

SWEP.Base = "m9k_melee_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_damascus")
end

-- Base info
SWEP.PrintName = "Damascus Sword"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 0

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_dmascus.mdl")
SWEP.WorldModel = Model("models/weapons/w_damascus_sword.mdl")

SWEP.BaseData = {}
SWEP.AttackData = {
	{
		Delay = 0.23,
		Window = 0.15,
		Damage = 75,
		DamageType = DMG_SLASH,
		CanBackstab = false,
		Sound = "weapons/blades/woosh.ogg",
		StabSound = "weapons/blades/swordchop.ogg",
		WallSound = "weapons/blades/hitwall.ogg",
		Range = 52,
		Hull = 5
	}
}

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", "AltSlash")
end

function SWEP:PrimaryAttack()
	local sequence = self:GetAltSlash() and "midslash2" or "midslash1"

	self:StartAttack(1, sequence, 0.4)
	self:SetAltSlash(not self:GetAltSlash())
end
