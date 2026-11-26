AddCSLuaFile()

SWEP.m_WeaponDeploySpeed = 10

AddCSLuaFile("cl_sck.lua")

if CLIENT then
	include("cl_sck.lua")
end

function SWEP:Initialize()
	if CLIENT then
		self:InitSCK()
	end
end

function SWEP:OnReloaded()
	if CLIENT then
		self:RemoveCSEnts()
	end

	self:SetWeaponHoldType(self:GetHoldType())
end

function SWEP:OnRemove()
	if CLIENT then
		self:RemoveCSEnts()
	end
end

-- Interpolation code based on https://gitlab.com/cynhole/swcs
local TICK_INTERVAL = engine.TickInterval()
local function TICK_TO_TIME(t)
	return t * TICK_INTERVAL
end

local floor = math.floor
local function TIME_TO_TICK(t)
	return floor(t / TICK_INTERVAL)
end

local function TICK_FRACTION()
	local ct = CurTime()
	local nextTick = TICK_TO_TIME(TIME_TO_TICK(ct) + 1)

	return (nextTick - ct) / TICK_INTERVAL
end

function SWEP:InterpolatedNetworkVar(name)
	-- Non-functional and unnecessary in singleplayer so we just don't
	if game.SinglePlayer() then
		self:NetworkVar("Float", name)
		return
	end

	-- Since we're defining our own getters and settings we need a different name for the actual networkvar
	self:NetworkVar("Float", "NW" .. name)

	-- Cache the getters and setters for more __index savings
	local get = self["GetNW" .. name]
	local set = self["SetNW" .. name]

	if CLIENT then
		-- Defining this in scope means it's never accessible, but we don't need to and doing it saves on __index calls
		local last = 0

		self["Get" .. name] = function()
			local fraction = TICK_FRACTION()
			local inverse = 1 - fraction

			return (last * fraction) + (get(self) * inverse)
		end

		self["Set" .. name] = function(_, value)
			if IsFirstTimePredicted() then
				last = get(self)
			end

			set(self, value)
		end
	else
		-- The server doesn't interact with this system at all
		self["Get" .. name] = get
		self["Set" .. name] = set
	end
end

if CLIENT then
	local cvar_ZoomSensitivityRatio = GetConVar("zoom_sensitivity_ratio")

	function SWEP:AdjustMouseSensitivity(sensitivity, localFOV, defaultFOV)
		if localFOV == defaultFOV then
			return 1
		end

		return (localFOV / defaultFOV) * cvar_ZoomSensitivityRatio:GetFloat()
	end
end
