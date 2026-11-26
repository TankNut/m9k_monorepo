AddCSLuaFile()
DEFINE_BASECLASS("m9k_shotty_base")

SWEP.Base = "m9k_shotty_base"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_ex41")
end

-- Base info
SWEP.PrintName = "Milkor Mk1"
SWEP.Author = "TankNut"

SWEP.Category = "M9K Specialties"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Models
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_milkor_mgl1.mdl")
SWEP.WorldModel = Model("models/weapons/w_milkor_mgl1.mdl")

SWEP.HoldType = "shotgun"

-- Stats
SWEP.Primary.Ammo = "40mmGrenade"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Primary.RPM = 250 -- Rounds Per Minute

-- Recoil
SWEP.Primary.KickUp = 1.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum side recoil (koolaid)

-- Sounds
SWEP.Primary.Sound = "40mmGrenade.Single" -- Sound played when firing

-- Aiming
SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better

-- Extra modes
SWEP.SelectiveFire = false -- If set, E+R switches between semi and full-auto
SWEP.CanBeSilenced = false -- If set, E+RMB attaches a suppressor
SWEP.ShellTime = 0.5 -- Overrides the time it takes to reload a shell

-- Viewmodel offsets
SWEP.CustomIdlePos = Vector(0, 0, 0) -- Applied when the weapon is idle
SWEP.CustomIdleAng = Vector(0, 0, 0)

SWEP.SightsPos = Vector(0, 0, 1.2) -- Applied while aiming
SWEP.SightsAng = Vector(0, 0, 0)

SWEP.RunSightsPos = Vector( -3.444, -3.77, -0.329 ) -- Applied while sprinting
SWEP.RunSightsAng = Vector( -5.738, -37.869, 0 )

function SWEP:FireWeapon()
	if SERVER then
		local owner = self:GetOwner()
		local ang = owner:GetAimVector():Angle()

		local ent = ents.Create("m9k_milkor_nade")

		ent:SetPos(LocalToWorld(Vector(0, -6, -5), angle_zero, self:GetShootPos(), ang))
		ent:SetAngles(ang + Angle(90, 0, 0))
		ent:SetOwner(owner)
		ent:Spawn()
		ent:Activate()
	end

	self:AddRecoil()
end
