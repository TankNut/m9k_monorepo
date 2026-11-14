AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

SWEP.Spawnable = true

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_rem870tactical.mdl")
SWEP.WorldModel = Model("models/weapons/w_remington_870_tact.mdl")

SWEP.HoldType = "shotgun"

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 30

SWEP.Primary.RPM = 70
SWEP.Primary.NumShots = 9
SWEP.Primary.Damage = 10

SWEP.Primary.SpreadHip = 0.035
SWEP.Primary.SpreadIronSights = 0.035

SWEP.Primary.KickUp = 1.25 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.8 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum side recoil (koolaid)

SWEP.KickUpMultiplier = 2
SWEP.RecoilKickSpeed = 40

SWEP.Primary.Sound = "WepRem870.Single"

SWEP.Secondary.IronFOV = 60 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better
SWEP.Secondary.ScopeZoom = 0 -- Overrides SWEP.Secondary.IronFOV when set

SWEP.SelectiveFire = false
SWEP.CanBeSilenced = false
SWEP.ShellTime = 0 -- Overrides the time it takes to reload a shell

SWEP.IronSightTime = 0.15
SWEP.ViewModelCorrection = 0 -- How much correction to apply to SWEP.ViewModelFOV when zooming, range [0-1]

SWEP.CustomIdlePos = Vector(0, 0, -1)
SWEP.CustomIdleAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-2.014, 0.1, 1.2)
SWEP.SightsAng = Vector(0.551, 0.028, 0)
SWEP.RunSightsPos = Vector(6.534, -4.646, 1.654)
SWEP.RunSightsAng = Vector(-19.567, 68.622, 0)

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", "FirstReload")
	self:NetworkVar("Bool", "LastReload")
end

function SWEP:SetWeaponAnim(act)
	local finish = BaseClass.SetWeaponAnim(self, act)

	if act == ACT_VM_RELOAD and self.ShellTime != 0 then
		return CurTime() + self.ShellTime
	end

	return finish
end

function SWEP:PrimaryAttack()
	if self:IsReloading() and not self:GetLastReload() then
		self:SetFinishReload(self:SetWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH))
		self:SetLastReload(true)

		return
	end

	BaseClass.PrimaryAttack(self)
end

function SWEP:StartReload()
	if not self:CanReload() then return end

	self:GetOwner():SetAnimation(PLAYER_RELOAD)

	self:SetFinishReload(self:SetWeaponAnim(ACT_SHOTGUN_RELOAD_START))
	self:SetFirstReload(true)
end

function SWEP:FinishReload()
	self:SetFinishReload(0)

	local last = self:GetLastReload()

	if not self:GetFirstReload() and not last then
		local amount = math.min(self:Ammo1(), 1) -- Can make this a var at a later point

		self:GetOwner():RemoveAmmo(amount, self:GetPrimaryAmmoType())
		self:SetClip1(self:Clip1() + amount)
	end

	self:SetFirstReload(false)
	self:SetLastReload(false)

	if not last then
		local should = (self:Clip1() < self:GetMaxClip1()) and self:Ammo1() > 0

		self:SetFinishReload(self:SetWeaponAnim(should and ACT_VM_RELOAD or ACT_SHOTGUN_RELOAD_FINISH))

		if not should then
			self:SetLastReload(true)
		end
	end
end

function SWEP:AbortReload()
	self:SetFirstReload(false)
	self:SetLastReload(false)

	BaseClass.AbortReload(self)
end
