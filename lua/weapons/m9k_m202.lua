AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m202")
end

-- Base info
SWEP.PrintName = "M202"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_M202.mdl")
SWEP.WorldModel = Model("models/weapons/w_m202.mdl")

SWEP.HoldType = "rpg"

-- Stats
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4

SWEP.Primary.RPM = 300 -- Rounds Per Minute

-- Recoil
SWEP.Primary.KickUp = 3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "M202F.single" -- Sound played when firing

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -4.7089, 1.2661, -0.3572 ) -- Applied while aiming
SWEP.SightsAng = Vector( -0.1801, 0.985, 0 )

SWEP.RunSightsPos = Vector( 7.3256, 6.8881, -4.8875 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -15.596, 53.0059, -11.98 )

function SWEP:SetWeaponAnim(act)
	if act == ACT_VM_RELOAD then
		act = ACT_VM_DRAW
	end

	return BaseClass.SetWeaponAnim(self, act)
end

function SWEP:FireWeapon()
	if SERVER then
		local owner = self:GetOwner()
		local ang = owner:GetAimVector():Angle()

		local ent = ents.Create("m9k_m202_rocket")

		ent:SetPos(LocalToWorld(Vector(0, -5, 0.5), angle_zero, self:GetShootPos(), ang))
		ent:SetAngles(ang)
		ent:SetOwner(owner)
		ent:Spawn()
		ent:Activate()
	end

	self:AddRecoil()
end
