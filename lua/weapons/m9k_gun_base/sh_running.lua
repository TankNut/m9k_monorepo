AddCSLuaFile()

local SPRINT_MASK = bit.bor(IN_MOVELEFT, IN_MOVERIGHT, IN_FORWARD, IN_BACK)

local function isRunning(self)
	local ply = self:GetOwner()

	-- Also acts as a NULL check
	if not ply:IsPlayer() then return false end

	return ply:IsSprinting() and ply:KeyDown(SPRINT_MASK)
end

function SWEP:UpdateRunning()
	local running = isRunning(self)

	if running != self:GetRunning() then
		self[running and "StartRunning" or "StopRunning"](self)
	end

	self:SetRunning(running)
end

function SWEP:StartRunning()
end

function SWEP:StopRunning()
	if not self.CanShootWhileRunning then
		self:SetNextPrimaryFire(CurTime() + 0.2)
	end
end
