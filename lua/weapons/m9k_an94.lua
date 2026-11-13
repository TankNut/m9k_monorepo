AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_an94")
end

-- Base info
SWEP.PrintName = "AN-94"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Assault Rifles"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2
SWEP.SlotPos = 25

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 55

SWEP.ViewModel = Model("models/weapons/v_rif_an_94.mdl")
SWEP.WorldModel = Model("models/weapons/w_rif_an_94.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 600 -- Rounds Per Minute
SWEP.Primary.NumShots = 1 -- Bullets fired per shot
SWEP.Primary.Damage = 31 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.015 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.005 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum side recoil (koolaid)

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = true -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( 4.552, 0, 2.95 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0.93, -0.5, 0 )

SWEP.RunSightsPos = Vector( -5.277, -8.584, 2.598 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -12.954, -52.088, 0 )

function SWEP:ToggleFiremode()
	local automatic = not self:GetAutomatic()
	self:SetAutomatic(automatic)

	if SERVER then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, automatic and "Automatic selected." or "Burst selected.")
	end

	self:SetNextAction(CurTime() + 0.2)
	self:EmitSound("Weapon_AR2.Empty")
end

function SWEP:TakeAmmo()
	self:TakePrimaryAmmo(self:GetAutomatic() and 1 or 2)
end

function SWEP:FireEffects()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)

	self:EmitSound(self:GetAutomatic() and "an94.Single" or "an94.Double")
	self:SetWeaponAnim(ACT_VM_PRIMARYATTACK)
end

function SWEP:ModifyBullet(bullet)
	bullet.Num = self:GetAutomatic() and 1 or 2
end
