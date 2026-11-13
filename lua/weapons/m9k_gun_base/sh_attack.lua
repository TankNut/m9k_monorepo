AddCSLuaFile()

local cvar_DamageMultiplier = GetConVar("M9KDamageMultiplier")
local cvar_EngineSpread = GetConVar("m9k_enginespread") -- Created in bobs_gun_base

function SWEP:FireEffects()
	local silenced = self:GetSilencer()

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)

	self:EmitSound(silenced and self.Primary.SilencedSound or self.Primary.Sound)
	self:SetWeaponAnim(silenced and ACT_VM_PRIMARYATTACK_SILENCED or ACT_VM_PRIMARYATTACK)
end

function SWEP:GetDamage()
	return self.Primary.Damage * cvar_DamageMultiplier:GetFloat() * util.SharedRandom("m9k_damage", 0.95, 1.05)
end

local shotBiasMin = GetConVar( "ai_shot_bias_min" ):GetFloat()
local shotBiasMax = GetConVar( "ai_shot_bias_max" ):GetFloat()

local function getSpread(gun, dir, aimcone)
	local owner = gun:GetOwner()

	local dirAng = dir:Angle()
	local right = dirAng:Right()
	local up = dirAng:Up()

	local x, y, z
	local bias = 1

	local shotBias = ((shotBiasMax - shotBiasMin) * bias) + shotBiasMin
	local flatness = math.abs(bias) * 0.5

	local cmd = owner:GetCurrentCommand()
	local seed = "m9k_spread_" .. util.CRC(gun:GetCreationID() .. gun:EntIndex() .. CurTime() .. owner:GetUserGroup() .. cmd:CommandNumber() .. cmd:TickCount())
	local seedNum = 0

	local function getRnd()
		seedNum = seedNum + 1

		return util.SharedRandom(seed, -1, 1, seedNum)
	end

	for _ = 1, 1000 do -- Not infinite, just in case
		x = getRnd() * flatness + getRnd() * (1 - flatness)
		y = getRnd() * flatness + getRnd() * (1 - flatness)

		if shotBias < 0 then
			x = x >= 0 and 1 - x or -1 - x
			y = y >= 0 and 1 - y or -1 - y
		end

		z = x * x + y * y

		if z <= 1 then
			break
		end
	end

	up:Mul(y * aimcone)
	right:Mul(x * aimcone)
	right:Add(up)
	right:Add(dir)
	right:Normalize()

	return right
end

function SWEP:GetSpread()
	local owner = self:GetOwner()
	local aimcone = Lerp(self:GetAimState(), self.Primary.SpreadHip, self.Primary.SpreadIronSights)

	if owner:IsNPC() then
		-- NPC's handle spread through WEAPON:GetNPCBulletSpread()
		return owner:GetAimVector(), vector_origin
	end

	local dir = (owner:GetAimVector():Angle() + owner:GetViewPunchAngles()):Forward()

	if cvar_EngineSpread:GetBool() then
		return dir, Vector(aimcone, aimcone)
	else
		return getSpread(self, dir, aimcone), vector_origin
	end
end

function SWEP:GetShootPos()
	local owner = self:GetOwner()
	return owner:IsPlayer() and owner:M9K_GetShootPos() or owner:GetShootPos()
end

function SWEP:FireWeapon()
	local dir, spread = self:GetSpread()
	local damage = self:GetDamage()
	local owner = self:GetOwner()

	owner:FireBullets({
		Inflictor = self,
		Num = self.Primary.NumShots,
		Src = self:GetShootPos(),
		Dir = dir,
		Spread = spread,
		Tracer = 3,
		TracerName = self.Tracer or "Tracer",
		Force = damage * 0.25, -- There's better ways to calc this
		Damage = damage,
		Callback = function(attacker, tr, dmg)
			self:QueueBulletCallback(0, attacker, tr, dmg)
		end
	})

	-- Queue-based callback handler to prevent issues with NumShots > 1
	local callbacks = self.PendingBulletCallbacks
	local i = 0

	while i < #callbacks do
		i = i + 1

		local callback = callbacks[i]
		self:HandleBulletCallback(callback[1], callback[2], callback[3], callback[4])
	end

	self.PendingBulletCallbacks = {}
	self:AddRecoil()
end
