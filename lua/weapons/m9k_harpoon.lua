AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_harpoon")
end

SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.PrintName = "Harpoon"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 40
SWEP.ViewModel = Model("models/weapons/v_pistol.mdl")
SWEP.WorldModel = Model("models/weapons/w_harpooner.mdl")

SWEP.Primary.Ammo = "Harpoon"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0

function SWEP:Initialize()
	self:SetHoldType("grenade")
end

function SWEP:Deploy()
	self:SetHoldType("grenade")

	return true
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local dir = ply:GetAimVector()
	local pos = ply:M9K_GetShootPos()

	local tr = util.TraceLine({
		start = pos,
		endpos = pos + dir * 40,
		filter = ply
	})

	if tr.Hit then
		return
	end

	self:TakePrimaryAmmo(1)

	ply:SetAnimation(PLAYER_ATTACK1)

	if SERVER then
		local ent = ents.Create("m9k_thrown_harpoon")
		ent:SetAngles(dir:Angle())
		ent:SetPos(pos)
		ent:SetOwner(ply)
		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		phys:SetVelocity(dir * 2000)

		if self:Ammo1() == 0 then
			timer.Simple(0, function()
				if not ply:IsPlayer() or not self:IsValid() then return end

				ply:StripWeapon(self:GetClass())
			end)
		end
	end

	if game.SinglePlayer() or (CLIENT and IsFirstTimePredicted()) then
		ply:ViewPunch(Angle(3, 5, 0))
	end

	self:SetNextPrimaryFire(CurTime() + 1.5)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:OnReloaded()
	self:SetWeaponHoldType(self:GetHoldType())
end

if CLIENT then
	local null = Material("null")
	local harpoon

	local function createHarpoon()
		harpoon = ClientsideModel("models/props_junk/harpoon002a.mdl")
		harpoon:SetNoDraw(true)

		local matrix = Matrix()
		matrix:Scale(Vector(0.9, 0.5, 0.5))

		harpoon:EnableMatrix("RenderMultiply", matrix)
	end

	function SWEP:PreDrawViewModel(vm, _, ply, flags)
		render.MaterialOverride(null)
	end

	function SWEP:PostDrawViewModel(vm, _, ply, flags)
		render.MaterialOverride(nil)

		if self:GetNextPrimaryFire() > CurTime() then
			return
		end

		if not IsValid(harpoon) then
			createHarpoon()
		end

		local bone = vm:LookupBone("ValveBiped.square")

		if not bone then
			return
		end

		local matrix = vm:GetBoneMatrix(bone)
		matrix:SetScale(Vector(1, 1, 1))

		matrix:Translate(Vector(-2, 7, 12))
		matrix:Rotate(Angle(-90, 10, 10))

		harpoon:SetPos(matrix:GetTranslation())
		harpoon:SetAngles(matrix:GetAngles())

		harpoon:DrawModel()
	end

	function SWEP:DrawWorldModel(flags)
		if self:GetNextPrimaryFire() > CurTime() then
			return
		end

		self:DrawModel(flags)
	end
end
