AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_davy_crockett")
end

-- Base info
SWEP.PrintName = "Davy Crockett"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_RL7.mdl")
SWEP.WorldModel = Model("models/weapons/w_rl7.mdl")

SWEP.HoldType = "rpg"

-- Stats
SWEP.Primary.Ammo = "Nuclear_Warhead"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Primary.RPM = 20 -- Rounds Per Minute

-- Recoil
SWEP.Primary.KickUp = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "RPGF.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 40 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(-1.5, -3, 0.5) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, -5)

SWEP.RunSightsPos = Vector( 2.4946, -1.5644, 1.699 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -20.1104, 35.1164, -12.959 )

SWEP.VElements = {{
	Model = "models/Failure/MK6/m62.mdl",
	Bone = "Rocket",
	Pos = Vector(-0.093, 7.412, -0.005),
	Ang = Angle(-45, 0, 90),
	Scale = Vector(0.449, 0.449, 0.449)
}}

SWEP.WElements = {{
	Model = "models/failure/mk6/m62.mdl",
	Bone = "ValveBiped.Bip01_R_Hand",
	Pos = Vector(28.054, -1, -5.1),
	Ang = Angle(90, 0, 0),
	Scale = Vector(0.504, 0.504, 0.504)
}}

local cvar_Allowed = GetConVar("DavyCrockettAllowed")
local cvar_AdminOnly = GetConVar("DavyCrocketAdminOnly")
local cvar_Timer = GetConVar("M9K_Davy_Crockett_Timer")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", "Bricked")
	self:NetworkVar("Float", "DeployTimer")
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if SERVER then
		local ply = self:GetOwner()

		if not cvar_Allowed:GetBool() then
			self:SetBricked(true)
			ply:PrintMessage(HUD_PRINTCENTER, "Nukes are admin only on this server.")

			return
		elseif cvar_AdminOnly:GetBool() and not ply:IsAdmin() then
			self:SetBricked(true)
			ply:PrintMessage(HUD_PRINTCENTER, "Nukes are admin only on this server.")

			return
		end

		local time = cvar_Timer:GetFloat()

		ply:PrintMessage(HUD_PRINTCENTER, "Warhead will be armed in " .. string.NiceTime(time) .. ".")

		self:SetBricked(false)
		self:SetDeployTimer(CurTime() + time)
		self.NextBeep = CurTime() + 1
	end

	return true
end

function SWEP:CanPrimaryAttack()
	if self:GetBricked() or self:GetDeployTimer() > CurTime() then
		return false
	end

	return BaseClass.CanPrimaryAttack(self)
end

function SWEP:Think()
	BaseClass.Think(self)

	if SERVER and self.NextBeep and self.NextBeep <= CurTime() then
		local ply = self:GetOwner()
		local timeLeft = self:GetDeployTimer() - CurTime()

		if timeLeft <= 5 then
			self:EmitSound("C4.PlantSound")
		end

		if timeLeft <= 0 then
			ply:PrintMessage(HUD_PRINTCENTER, "WARHEAD IS ARMED AND READY TO FIRE")
		else
			ply:PrintMessage(HUD_PRINTCENTER, string.NiceTime(math.ceil(timeLeft)) .. " remaining!")
		end

		if timeLeft > 0 then
			self.NextBeep = CurTime() + math.min(timeLeft, 1)
		else
			self.NextBeep = nil
		end
	end
end

function SWEP:SetWeaponAnim(act)
	if act == ACT_VM_IDLE then return end

	return BaseClass.SetWeaponAnim(self, act)
end

function SWEP:FireWeapon()
	if SERVER then
		local owner = self:GetOwner()
		local ent = ents.Create("m9k_launched_davycrockett")

		ent:SetPos(self:GetShootPos())
		ent:SetAngles(owner:GetAimVector():Angle() + Angle(90, 0, 0))
		ent:SetOwner(owner)
		ent:Spawn()
		ent:Activate()
	end

	self:AddRecoil()
end
