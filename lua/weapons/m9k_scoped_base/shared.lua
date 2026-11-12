AddCSLuaFile()
DEFINE_BASECLASS("m9k_gun_base")

SWEP.Base = "m9k_gun_base"

SWEP.Spawnable = true

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/m9k_m98b")
end

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70

SWEP.ViewModel = Model("models/weapons/v_m98bravo.mdl")
SWEP.WorldModel = Model("models/weapons/w_barrett_m98b.mdl")

SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 60

SWEP.Primary.RPM = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Damage = 90

SWEP.Primary.SpreadHip = 0.001
SWEP.Primary.SpreadIronSights = 0.0001

SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum side recoil (koolaid)

SWEP.KickUpMultiplier = 2
SWEP.RecoilKickSpeed = 40

SWEP.Primary.Sound = "M98.Single"

SWEP.Secondary.IronFOV = 55 -- This sucks, it'll work but SWEP.Secondary.ScopeZoom is better
SWEP.Secondary.ScopeZoom = 9 -- Overrides SWEP.Secondary.IronFOV when set

-- Complete ass, but backwards compat
SWEP.Secondary.UseACOG = false
SWEP.Secondary.UseMilDot = false
SWEP.Secondary.UseSVD = false
SWEP.Secondary.UseParabolic = true
SWEP.Secondary.UseElcan = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint = false
SWEP.Secondary.UseMatador = false

SWEP.SelectiveFire = false
SWEP.CanBeSilenced = false
SWEP.BoltAction = true

SWEP.IronSightTime = 0.15
SWEP.ViewModelCorrection = 0.5 -- How much correction to apply to SWEP.ViewModelFOV when zooming, range [0-1]

SWEP.CustomIdlePos = Vector(0, 0, 0)
SWEP.CustomIdleAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-2.196, -2, 1)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(3.714, -3.714, 0.286)
SWEP.RunSightsAng = Vector(-7, 43, 0)

SWEP.ScopeScale = 0.7
SWEP.ReticleScale = 0.5

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", "LastFire")
end

function SWEP:Deploy()
	self:SetLastFire(0)

	BaseClass.Deploy(self)
end

function SWEP:FireWeapon()
	BaseClass.FireWeapon(self)

	self:SetLastFire(CurTime())
end

function SWEP:IsBolting()
	if not self.BoltAction then return false end

	local timeSince = CurTime() - self:GetLastFire()
	local delay = 1 / (self.Primary.RPM / 60)

	-- You'll be able to fire 0.05 seconds after finishing scoping back in
	return timeSince > 0.2 and timeSince < delay - (self.IronSightTime + 0.05)
end

function SWEP:ShouldAimState()
	if self:IsBolting() then return false end
	if self:IsReloading() then return false end

	return BaseClass.ShouldAimState(self)
end

if SERVER then
	return
end

function SWEP:InScope()
	return self:ShouldAimState()
end

function SWEP:PreDrawViewModel()
	if self:InScope() then
		return true
	end
end

function SWEP:DrawScope(texture)
	local scrW = ScrW()
	local scrH = ScrH()

	local size = (scrH + 1) * self.ScopeScale

	surface.SetTexture(texture)
	surface.DrawTexturedRect(scrW * 0.5 - size, scrH * 0.5 - size, size * 2, size * 2)
end

function SWEP:DrawReticle(texture1, texture2)
	local scrW = ScrW()
	local scrH = ScrH()

	-- No idea what this magic number is
	local divider = 1.7579 / self.ReticleScale
	local size = scrH / divider / 2
	local x = (scrW * 0.5) - size
	local y = (scrH * 0.5) - size

	surface.SetTexture(texture1)
	surface.DrawTexturedRect(x, y, size * 2, size * 2)

	if texture2 then
		surface.SetTexture(texture2)
		surface.DrawTexturedRect(x, y, size * 2, size * 2)
	end
end

local gdcw_closedsight = surface.GetTextureID("scope/gdcw_closedsight")
local gdcw_acogchevron = surface.GetTextureID("scope/gdcw_acogchevron")
local gdcw_acogcross = surface.GetTextureID("scope/gdcw_acogcross")
local gdcw_scopesight = surface.GetTextureID("scope/gdcw_scopesight")
local gdcw_svdsight = surface.GetTextureID("scope/gdcw_svdsight")
local gdcw_parabolicsight = surface.GetTextureID("scope/gdcw_parabolicsight")
local gdcw_elcanreticle = surface.GetTextureID("scope/gdcw_elcanreticle")
local gdcw_elcansight = surface.GetTextureID("scope/gdcw_elcansight")
local gdcw_nvgilluminatedduplex = surface.GetTextureID("scope/gdcw_nvgilluminatedduplex")
local aimpoint = surface.GetTextureID("scope/aimpoint")
local rocketscope = surface.GetTextureID("scope/rocketscope")

function SWEP:DrawHUD()
	if not self:InScope() then
		return
	end

	-- Everyone uses the same draw color
	surface.SetDrawColor(0, 0, 0, 255)

	local secondary = self.Secondary

	if secondary.UseACOG then
		self:DrawScope(gdcw_closedsight)
		self:DrawReticle(gdcw_acogchevron, gdcw_acogcross)
	elseif secondary.UseMilDot then
		self:DrawScope(gdcw_scopesight)
	elseif secondary.UseSVD then
		self:DrawScope(gdcw_svdsight)
	elseif secondary.UseParabolic then
		self:DrawScope(gdcw_parabolicsight)
	elseif secondary.UseElcan then
		self:DrawReticle(gdcw_elcanreticle)
		self:DrawScope(gdcw_elcansight)
	elseif secondary.UseGreenDuplex then
		self:DrawReticle(gdcw_nvgilluminatedduplex)
		self:DrawScope(gdcw_closedsight)
	elseif secondary.UseAimpoint then
		self:DrawReticle(aimpoint)
		self:DrawScope(gdcw_closedsight)
	elseif secondary.UseMatador then
		self:DrawScope(rocketscope)
	end
end

function SWEP:DoDrawCrosshair(x, y)
	return true
end
