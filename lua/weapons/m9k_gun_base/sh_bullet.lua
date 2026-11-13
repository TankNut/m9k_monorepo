AddCSLuaFile()

local cvar_DisablePenetration = GetConVar("M9KDisablePenetration")
local cvar_DisableRicochet = GetConVar("M9KDisableRicochet")

-- Applies to both penetration and ricochets
local maxIterations = {
	["SniperPenetratedRound"] = 10,
	["pistol"] = 2,
	["357"] = 5,
	["smg1"] = 4,
	["ar2"] = 5,
	["buckshot"] = 1,
	["slam"] = 1,
	["AirboatGun"] = 8
}

-- Depth doesn't change as rounds penetrate
local penetrationDepth = {
	["SniperPenetratedRound"] = 20,
	["pistol"] = 9,
	["357"] = 12,
	["smg1"] = 14,
	["ar2"] = 16,
	["buckshot"] = 5,
	["slam"] = 5,
	["AirboatGun"] = 17
}

-- Damage multiplier after penetration
local penetrationDamageMult = {
	[MAT_CONCRETE] = 0.3,
	[MAT_METAL] = 0.3,
	[MAT_WOOD] = 0.8,
	[MAT_PLASTIC] = 0.8,
	[MAT_GLASS] = 0.8,
	[MAT_FLESH] = 0.9,
	[MAT_ALIENFLESH] = 0.9
}

-- Doubles penetration depth on these materials
local easyPenMaterials = {
	[MAT_GLASS] = true,
	[MAT_PLASTIC] = true,
	[MAT_WOOD] = true,
	[MAT_FLESH] = true,
	[MAT_ALIENFLESH] = true
}

function SWEP:BulletPenetration(iteration, attacker, tr, damage)
	-- func_breakable already has this built-in, prevents bullets from doubling up
	if tr.Entity:GetClass() == "func_breakable" then
		return false
	end

	local depth = penetrationDepth[self:GetPrimaryAmmoType()] or 5

	if easyPenMaterials[tr.MatType] then
		depth = depth * 2
	end

	local start = tr.HitPos + tr.Normal * depth

	-- Not quite util.IsInWorld but works on both realms
	if util.PointContents(tr.HitPos) == CONTENTS_SOLID then
		return false
	end

	local backTrace = util.TraceLine({
		start = start,
		endpos = tr.HitPos,
		mask = MASK_SHOT,
		filter = {tr.Entity},
		whitelist = true
	})

	if backTrace.AllSolid or backTrace.Entity != tr.Entity then return false end -- Bugfix, can penetrate world now
	if not backTrace.Hit then return false end
	if backTrace.Fraction >= 0.99 or backTrace.Fraction <= 0.01 then return false end

	damage = damage * (penetrationDamageMult[tr.MatType] or 0.5) -- Use the same material for both depth and damage

	attacker:FireBullets({
		Inflictor = self,
		Num = 1,
		Src = backTrace.HitPos,
		Dir = tr.Normal,
		Spread = vector_origin,
		Tracer = 1,
		TracerName = "m9k_effect_penetration",
		Force = damage * 0.25, -- Same force calc as normal bullets
		Damage = damage,
		IgnoreEntity = tr.Entity:IsPlayer() and tr.Entity or nil,
		Callback = function(attacker_, tr_, dmg_)
			self:QueueBulletCallback(iteration, attacker_, tr_, dmg_)
		end
	})

	return true
end

-- Properly spatialized sound
sound.Add({
	name = "m9k_ricochet_miss",
	channel = CHAN_STATIC,
	level = 75,
	volume = 1.0,
	pitch = {75, 150},
	sound = {
		"^weapons/fx/nearmiss/bulletLtoR03.wav",
		"^weapons/fx/nearmiss/bulletLtoR04.wav",
		"^weapons/fx/nearmiss/bulletLtoR06.wav",
		"^weapons/fx/nearmiss/bulletLtoR07.wav",
		"^weapons/fx/nearmiss/bulletLtoR09.wav",
		"^weapons/fx/nearmiss/bulletLtoR10.wav",
		"^weapons/fx/nearmiss/bulletLtoR13.wav",
		"^weapons/fx/nearmiss/bulletLtoR14.wav"
	}
})

local ricochetAmmo = {
	["pistol"] = true,
	["buckshot"] = true,
	["slam"] = true,
	["SniperPenetratedRound"] = true
}

local function sharedRandomInt(name, min, max, seed)
	return math.Round(util.SharedRandom(name, min, max, seed))
end

	if not ricochetAmmo[self:GetPrimaryAmmoType()] then return false end
	if sharedRandomInt("m9k_ricochet", 1, 4, iteration) != 1 then return false end
function SWEP:BulletRicochet(iteration, attacker, tr, damage)

	if tr.MatType != MAT_METAL then
		-- None of this other code makes sense so I'm just leaving it
		EmitSound("m9k_ricochet_miss", tr.HitPos, 0)

		return false
	end

	local dot = tr.HitNormal:Dot(tr.Normal * -1)

	-- No minimum angle for deflection? Alright
	local dir = ((2 * tr.HitNormal * dot) + tr.Normal) + VectorRand() * 0.05
	damage = damage * 0.5

	attacker:FireBullets({
		Inflictor = self,
		Num = 1,
		Src = tr.HitPos + tr.HitNormal,
		Dir = dir,
		Spread = vector_origin,
		Tracer = 1,
		TracerName = "m9k_effect_ricochet",
		Force = damage * 0.25, -- Same force calc as normal bullets
		Damage = damage,
		IgnoreEntity = tr.Entity,
		Callback = function(attacker_, tr_, dmg_)
			self:QueueBulletCallback(iteration, attacker_, tr_, dmg_)
		end
	})

	return true
end

function SWEP:HandleBulletCallback(iteration, attacker, tr, damage)
	iteration = iteration + 1

	if iteration > (maxIterations[self:GetPrimaryAmmoType()] or 14) then
		return
	end

	if not cvar_DisablePenetration:GetBool() and self:BulletPenetration(iteration, attacker, tr, damage) then
		return
	end

	if not cvar_DisableRicochet:GetBool() then
		self:BulletRicochet(iteration, attacker, tr, damage)
	end
end

function SWEP:QueueBulletCallback(iteration, attacker, tr, dmg)
	table.insert(self.PendingBulletCallbacks, {iteration, attacker, tr, dmg:GetDamage()})
end
