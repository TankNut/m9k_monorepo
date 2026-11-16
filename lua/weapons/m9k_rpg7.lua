AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_rpg7")
end

-- Base info
SWEP.PrintName = "RPG-7"
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
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 4

SWEP.Primary.RPM = 60 -- Rounds Per Minute

-- Recoil
SWEP.Primary.KickUp = 3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "RPGF.single" -- Sound played when firing

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -3.7384, -5.7481, -0.2713 ) -- Applied while aiming
SWEP.SightsAng = Vector( 1.1426, 0.0675, 0 )

SWEP.RunSightsPos = Vector( 2.4946, -1.5644, 1.699 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -20.1104, 35.1164, -12.959 )

function SWEP:SetWeaponAnim(act)
	if act == ACT_VM_IDLE then return end

	return BaseClass.SetWeaponAnim(self, act)
end

function SWEP:FireWeapon()
	if SERVER then
		local owner = self:GetOwner()
		local ang = owner:GetAimVector():Angle()

		local ent = ents.Create("m9k_gdcwa_rpg_heat")

		ent:SetPos(LocalToWorld(Vector(0, -6, -5), angle_zero, self:GetShootPos(), ang))
		ent:SetAngles(ang)
		ent:SetOwner(owner)
		ent:Spawn()
		ent:Activate()
	end

	self:AddRecoil()
end
