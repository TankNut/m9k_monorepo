AddCSLuaFile()
DEFINE_BASECLASS("m9k_base")

SWEP.Base = "m9k_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_orbital_strike")
end

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.PrintName = "Orbital Strike Marker"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/v_invisib.mdl")
SWEP.WorldModel = Model("models/weapons/w_binos.mdl")

SWEP.Primary.Ammo = "SatCannon"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

SWEP.VElements = {{
	Model = "models/weapons/binos.mdl",
	Bone = "r-thumb-low",
	Pos = Vector(3.907, -0.109, -1.125),
	Ang = Angle(-2.829, 27.281, 105.791),
	Scale = Vector(0.5, 0.5, 0.5 )
}}

SWEP.ViewModelBoneMods = {
	["l-ring-low"]          = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-19.507, 0, 0)},
	["r-index-mid"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-71.792, 0, 0)},
	["r-middle-low"]        = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-21.483, 1.309, 0)},
	["l-upperarm-movement"] = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, -0.88),         Ang = Angle(0, 0, 0)},
	["Da Machete"]          = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0.263, -1.826),    Ang = Angle(0, 0, 0)},
	["r-ring-low"]          = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-17.507, 0, 0)},
	["r-pinky-mid"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-47.32, 0, 0)},
	["r-ring-mid"]          = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-54.065, 0, 0)},
	["r-index-low"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-49.646, 0, 0)},
	["r-thumb-tip"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-17.666, 0, 0)},
	["r-upperarm-movement"] = {Scale = Vector(1, 1, 1), Pos = Vector(7.394, 2.101, -9.54), Ang = Angle(-10.502, -12.632, 68.194)},
	["r-pinky-low"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-21.526, 0, 0)},
	["r-middle-mid"]        = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-37.065, 0, 0)},
	["r-thumb-mid"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-4.816, 18.775, -30.143)},
	["l-index-low"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-49.646, 0, 0)},
	["r-thumb-low"]         = {Scale = Vector(1, 1, 1), Pos = Vector(0, 0, 0),             Ang = Angle(-0.982, 0, 0)}
}

local cvar_AdminOnly = GetConVar("OrbitalStrikeAdminOnly")

function SWEP:Initialize()
	BaseClass.Initialize(self)

	self:SetHoldType("camera")
end

function SWEP:SetupDataTables()
	self:InterpolatedNetworkVar("AimState")
end

function SWEP:Deploy()
	self:SetHoldType("camera")
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(math.max(CurTime() + self:SequenceDuration(), self:GetNextPrimaryFire()))

	return true
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if cvar_AdminOnly:GetBool() and not ply:IsAdmin() then
		if SERVER then
			ply:PrintMessage(HUD_PRINTCENTER, "Orbital strikes are admin only on this server.")
		end

		self:SetNextPrimaryFire(CurTime() + 0.2)

		return
	end

	local tr = ply:GetEyeTrace()

	if tr.HitSky then
		self:EmitSound("WallHealth.Deny")
		self:SetNextPrimaryFire(CurTime() + 0.2)

		return
	end

	local sky = util.TraceLine({
		start = tr.HitPos,
		endpos = tr.HitPos + Vector(0, 0, 56756),
		mask = MASK_VISIBLE
	})

	if sky.HitSky then
		local target

		if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
			target = tr.Entity
		end

		if SERVER then
			local ent = ents.Create("m9k_oribital_cannon")

			if target then
				ent.PoorBastard = true
				ent.Target = target
			else
				ent.Ground = tr.HitPos
			end

			ent.Sky = sky.HitPos - Vector(0, 0, 10)
			ent.Owner = ply
			ent:SetPos(ent.Sky)
			ent:Spawn()
		end
	else
		self:EmitSound("WallHealth.Deny")
		self:SetNextPrimaryFire(CurTime() + 0.2)

		return
	end

	self:EmitSound("weapons/satellite/targaquired.ogg")

	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire(CurTime() + 15)

	if SERVER and self:Ammo1() == 0 then
		ply:StripWeapon(self:GetClass())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
	local ply = self:GetOwner()

	self:SetAimState(math.Approach(self:GetAimState(), ply:KeyDown(IN_ATTACK2) and 1 or 0, FrameTime() / 0.15))
end

-- mathlib.h
local function simpleSplineRemapValClamped(value, a, b, c, d)
	if a == b then return value >= b and d or c end

	value = math.Clamp((value - a) / (b - a), 0, 1)
	local valueSquared = value * value

	return c + (d - c) * (3 * valueSquared - 2 * valueSquared * value)
end

function SWEP:GetZoom()
	return simpleSplineRemapValClamped(self:GetAimState(), 0, 1, 1, 5)
end

function SWEP:TranslateFOV(fov)
	local ply = self:GetOwner()

	if ply:GetViewEntity() != ply then
		return
	end

	return fov / self:GetZoom()
end

if CLIENT then
	local gdcw_scopesight = surface.GetTextureID("scope/gdcw_scopesight")

	function SWEP:DrawHUD()
		if not self:GetOwner():KeyDown(IN_ATTACK2) then
			return
		end

		surface.SetDrawColor(0, 0, 0, 255)

		local scrW = ScrW()
		local scrH = ScrH()

		local size = scrH + 1

		surface.SetTexture(gdcw_scopesight)
		surface.DrawTexturedRect(scrW * 0.5 - size, scrH * 0.5 - size, size * 2, size * 2)
	end

	function SWEP:DoDrawCrosshair(x, y)
		return true
	end

	function SWEP:PreDrawViewModel(vm, ply, weapon, flags)
		if self:GetOwner():KeyDown(IN_ATTACK2) then
			return true
		end

		return BaseClass.PreDrawViewModel(self, vm, ply, weapon, flags)
	end
end
