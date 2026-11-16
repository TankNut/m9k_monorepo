AddCSLuaFile()
DEFINE_BASECLASS("m9k_scoped_base")

SWEP.Base = "m9k_scoped_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_matador")
end

-- Base info
SWEP.PrintName = "Matador"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Redux: Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_MAT.mdl")
SWEP.WorldModel = Model("models/weapons/w_GDCW_MATADOR_RL.mdl")

SWEP.HoldType = "rpg"

-- Stats
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 4

SWEP.Primary.RPM = 60 -- Rounds Per Minute

-- Recoil
SWEP.Primary.KickUp = 2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "MATADORF.single" -- Sound played when firing

-- Aiming
SWEP.Secondary.ScopeZoom = 4 -- Overrides SWEP.Secondary.IronFOV when set
SWEP.Secondary.UseMatador = true

SWEP.ScopeScale = 1
SWEP.ReticleScale = 0.5

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.BoltAction = false -- Forces unscoping between shots

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector( -3.0556, -8.6664, 1.4751 ) -- Applied while aiming
SWEP.SightsAng = Vector( 0, 0, 0 )

SWEP.RunSightsPos = Vector( 2.4946, -1.5644, 1.699 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -20.1104, 35.1164, -12.959 )

function SWEP:FireWeapon()
	if SERVER then
		local owner = self:GetOwner()
		local ang = owner:GetAimVector():Angle()

		local ent = ents.Create("m9k_gdcwa_matador_90mm")

		ent:SetPos(LocalToWorld(Vector(0, -9, 1), angle_zero, self:GetShootPos(), ang))
		ent:SetAngles(ang + Angle(90, 0, 0))
		ent:SetOwner(owner)
		ent:Spawn()
		ent:Activate()
	end

	self:AddRecoil()
end
