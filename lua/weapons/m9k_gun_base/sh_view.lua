AddCSLuaFile()

local cvar_ZoomSensitivityRatio = GetConVar("zoom_sensitivity_ratio")

-- mathlib.h
local function simpleSplineRemapValClamped(value, a, b, c, d)
	if a == b then return value >= b and d or c end

	value = math.Clamp((value - a) / (b - a), 0, 1)
	local valueSquared = value * value

	return c + (d - c) * (3 * valueSquared - 2 * valueSquared * value)
end

function SWEP:GetZoom()
	local zoom = self.Secondary.ScopeZoom

	if zoom == 0 then
		-- Uses a static reference FOV so everyone gets the same relative zoom amount
		zoom = 90 / self.Secondary.IronFOV
	end

	return simpleSplineRemapValClamped(self:GetAimState(), 0, 1, 1, zoom)
end

function SWEP:TranslateFOV(fov)
	local ply = self:GetOwner()

	if ply:GetViewEntity() != ply then
		return
	end

	local target = fov / self:GetZoom()

	if CLIENT then
		self.ViewModelFOV = self.BaseViewModelFOV + (fov - target) * self.ViewModelCorrection
	end

	return target
end

if SERVER then
	return
end

function SWEP:AdjustMouseSensitivity(sensitivity, localFOV, defaultFOV)
	if localFOV == defaultFOV then
		return 1
	end

	return (localFOV / defaultFOV) * cvar_ZoomSensitivityRatio:GetFloat()
end

function SWEP:AddViewModelOffset(fraction, pos, ang, offsetPos, offsetAng)
	local x, y, z = offsetAng:Unpack()

	ang:RotateAroundAxis(ang:Right(), x * fraction)
	ang:RotateAroundAxis(ang:Up(), y * fraction)
	ang:RotateAroundAxis(ang:Forward(), z * fraction)

	x, y, z = offsetPos:Unpack()

	local right = ang:Right()
	right:Mul(fraction)
	right:Mul(x)

	local forward = ang:Forward()
	forward:Mul(fraction)
	forward:Mul(y)

	local up = ang:Up()
	up:Mul(fraction)
	up:Mul(z)

	pos:Add(right)
	pos:Add(forward)
	pos:Add(up)
end

function SWEP:GetViewModelPosition(pos, ang)
	local aim, run = self:GetAimState(), self:GetRunState()

	-- Done this way so that sight and sprint offsets are separate rather than additive
	local idle = 1 - math.min(aim + run, 1)

	self:AddViewModelOffset(aim, pos, ang, self.SightsPos, self.SightsAng)
	self:AddViewModelOffset(run, pos, ang, self.RunSightsPos, self.RunSightsAng)
	self:AddViewModelOffset(idle, pos, ang, self.CustomIdlePos, self.CustomIdleAng)

	return pos, ang
end

function SWEP:DoDrawCrosshair()
	if self:IsReloading() or self:GetRunning() then
		return true
	end
end
