AddCSLuaFile()

local cvar_WeaponStrip = GetConVar("M9KWeaponStrip")

function SWEP:IsReloading()
	return self:GetFinishReload() != 0
end

function SWEP:CheckAmmo()
	if self:Clip1() > 0 then return end

	if self:Ammo1() > 0 then
		self:StartReload()
		return
	end

	-- No ammo
	if cvar_WeaponStrip:GetBool() and SERVER then
		local ply = self:GetOwner()

		-- Doesn't always run on the next tick, but does here
		timer.Simple(0, function()
			if not ply:IsPlayer() or not self:IsValid() then return end

			ply:StripWeapon(self:GetClass())
		end)
	end
end

function SWEP:CanReload()
	if self:IsReloading() then return false end
	if self:Clip1() >= self:GetMaxClip1() then return false end
	if self:Ammo1() <= 0 then return false end

	return true
end

function SWEP:StartReload()
	if not self:CanReload() then return end

	local silenced = self:GetSilencer()

	self:GetOwner():SetAnimation(PLAYER_RELOAD)

	self:SendWeaponAnim(silenced and ACT_VM_RELOAD_SILENCED or ACT_VM_RELOAD)
	self:SetFinishReload(CurTime() + self:SequenceDuration())
end

function SWEP:FinishReload()
	self:SetFinishReload(0)

	local clip = self:Clip1()
	local amount = math.min(self:GetMaxClip1() - clip, self:Ammo1())

	self:GetOwner():RemoveAmmo(amount, self:GetPrimaryAmmoType())

	self:SetClip1(clip + amount)
end

function SWEP:UpdateReload()
	local finish = self:GetFinishReload()

	if finish > 0 and finish <= CurTime() then
		self:FinishReload()
	end
end

-- Since this has input checks, use StartReload if you want to reload from code
function SWEP:Reload()
	local ply = self:GetOwner()

	-- Don't reload if holding the modifier and only trigger on reload press, not hold
	if ply:KeyDown(IN_USE) or not ply:KeyPressed(IN_RELOAD) then
		return
	end

	self:StartReload()
end
