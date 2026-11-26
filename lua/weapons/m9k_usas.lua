AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_usas")
end

-- Base info
SWEP.PrintName = "USAS"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Shotguns"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_usas12_shot.mdl")
SWEP.WorldModel = Model("models/weapons/w_usas_12.mdl")

SWEP.HoldType = "ar2"

-- Stats
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 260 -- Rounds Per Minute
SWEP.Primary.NumShots = 10 -- Bullets fired per shot
SWEP.Primary.Damage = 7 -- Damage per single bullet

-- Spread
SWEP.Primary.SpreadHip = 0.048 -- Spread when hipfiring
SWEP.Primary.SpreadIronSights = 0.048 -- Spread when fully zoomed in

-- Recoil
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.7 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "Weapon_usas.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, -1) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(2, 0, 0) -- Applied while aiming
SWEP.SightsAng = Vector()

SWEP.RunSightsPos = Vector( -3.0328, 0, 1.888 ) -- Applied while sprinting
SWEP.RunSightsAng =  Vector( -24.2146, -36.522, 10 )

-- What a mess of a model
function SWEP:SetWeaponAnim(act)
	if self:IsReloading() and act == ACT_VM_IDLE then
		act = ACT_SHOTGUN_RELOAD_FINISH
	end

	if act == ACT_VM_RELOAD then
		BaseClass.SetWeaponAnim(self, ACT_SHOTGUN_RELOAD_START)
		self:SetNextIdle(CurTime() + 0.8)

		return CurTime() + 0.9
	end

	return BaseClass.SetWeaponAnim(self, act)
end
