AddCSLuaFile()
DEFINE_BASECLASS("m9k_base")

SWEP.Base = "m9k_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_ied_detonator")
end

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.PrintName = "IED Detonator"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75
SWEP.ViewModel = Model("models/weapons/v_invisib.mdl")
SWEP.WorldModel = Model("models/weapons/w_camphon2.mdl")

SWEP.Primary.Ammo = "Improvised_Explosive"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

SWEP.VElements = {{
	Model = "models/weapons/w_camphon2.mdl",
	Bone = "Da Machete",
	Pos = Vector(-4.327, -6.361, 15.64),
	Ang = Angle(-141.658, -25.886, -28.254),
	Scale = Vector(1, 1, 1)
}}

SWEP.ViewModelBoneMods = {
	["r-ring-low"]   = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0.148, 0), Ang = Angle(14.43, 0, 0)},
	["r-middle-mid"] = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-77.495, 0, 0)},
	["r-pinky-mid"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-101.027, 0, 0)},
	["r-ring-mid"]   = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-86.765, 0, 0)},
	["r-index-low"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-3.405, 0, 0)},
	["r-forearm"]    = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(0, 3.042, 100.974)},
	["r-thumb-mid"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(38.379, 0, 0)},
	["r-index-mid"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-108.598, 0, 0)},
	["r-middle-low"] = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(4.488, 0, 0)},
	["r-pinky-low"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(25.802, 0, 0)},
	["r-thumb-tip"]  = {Scale = Vector(1, 0.845, 0.989), Pos = Vector(0, 0, 0),     Ang = Angle(-17.769, 0, 0)},
	["r-thumb-low"]  = {Scale = Vector(1, 1, 1),         Pos = Vector(0, 0, 0),     Ang = Angle(-13.4, 32.006, -34.099)}
}

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetHoldType("pistol")
end

function SWEP:Deploy()
	self:SetHoldType("pistol")
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:PrimaryAttack()
	if self:Ammo1() == 0 then
		self:EmitSound("HL2Player.UseDeny")
		self:SetNextPrimaryFire(CurTime() + 0.2)
		return
	end

	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:EmitSound("WeaponFrag.Throw")

	if SERVER then
		local ply = self:GetOwner()
		local pos, ang = LocalToWorld(Vector(0, -5, -10), Angle(90, 0, 0), ply:M9K_GetShootPos(), ply:GetAimVector():Angle())

		local ent = ents.Create("m9k_improvised_explosive")
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent.BombOwner = ply
		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		phys:ApplyForceCenter(ply:GetAimVector() * 1500)
	end
end

function SWEP:SecondaryAttack()
	self:EmitSound("Buttons.snd34")
	self:SetNextSecondaryFire(CurTime() + 0.2)

	if SERVER then
		for _, v in ipairs(ents.FindByClass("m9k_improvised_explosive")) do
			if v.BombOwner == self:GetOwner() then
				v.Boom = true
			end
		end
	end
end

function SWEP:Reload()
end
