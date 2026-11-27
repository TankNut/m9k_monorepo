AddCSLuaFile()

SWEP.m_WeaponDeploySpeed = 10

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_proxy_mine")
end

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.PrintName = "Prox Mine"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel = Model("models/weapons/v_px.mdl")
SWEP.WorldModel = Model("models/weapons/w_px.mdl")

SWEP.Primary.Ammo = "ProxMine"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", "FinishPlant")
end

function SWEP:Deploy()
	self:SetHoldType("slam")
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	return true
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:SetFinishPlant(CurTime() + self:SequenceDuration())
	self:SetNextPrimaryFire(math.huge)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PlantMine()
	self:TakePrimaryAmmo(1)

	local ply = self:GetOwner()

	ply:SetAnimation(PLAYER_ATTACK1)

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire(CurTime())

	if SERVER then
		local tr = util.TraceLine({
			start = ply:M9K_GetShootPos(),
			endpos = ply:M9K_GetShootPos() + ply:GetAimVector() * 100,
			filter = ply
		})

		tr.HitNormal.z = -tr.HitNormal.z

		local ent = ents.Create("m9k_proxy")
		ent:SetPos(tr.HitPos + tr.HitNormal)
		ent:SetAngles(tr.HitNormal:Angle() - Angle(90, 180, 0))
		ent.ProxyBombOwner = ply
		ent:Spawn()
		ent:Activate()

		if tr.Hit then
			local attach = tr.Entity

			if string.find(attach:GetClass(), "^m9k_ammo_") then
				ent:SetParent(attach)
				attach.Planted = true
			elseif not attach:IsNPC() and not attach:IsPlayer() then
				ent:SetParent(attach)
			end
		else
			ent:SetMoveType(MOVETYPE_VPHYSICS)
		end

		if self:Ammo1() == 0 then
			timer.Simple(0, function()
				if not self:IsValid() or not ply:IsValid() then
					return
				end

				ply:StripWeapon(self:GetClass())
			end)
		end
	end
end

function SWEP:Think()
	local time = self:GetFinishPlant()
	local ct = CurTime()

	if time > 0 and time <= ct then
		self:SetFinishPlant(0)
		self:PlantMine()
	end
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end
