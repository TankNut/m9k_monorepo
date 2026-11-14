AddCSLuaFile()

function SWEP:ToggleFiremode()
	local automatic = not self:GetAutomatic()
	self:SetAutomatic(automatic)

	if SERVER then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, automatic and "Automatic selected." or "Semi-automatic selected.")
	end

	self:SetNextAction(CurTime() + 0.2)
	self:EmitSound("Weapon_AR2.Empty")
end

function SWEP:ToggleSilencer()
	local silenced = not self:GetSilencer()
	self:SetSilencer(silenced)
	self:SetNextAction(self:SetWeaponAnim(silenced and ACT_VM_ATTACH_SILENCER or ACT_VM_DETACH_SILENCER))
end

function SWEP:UpdateModes()
	if self:GetNextAction() > CurTime() then return end

	local ply = self:GetOwner()

	if ply:KeyDown(IN_USE) then
		if self.SelectiveFire and ply:KeyPressed(IN_RELOAD) then
			self:ToggleFiremode()
		end

		if self.CanBeSilenced and ply:KeyPressed(IN_ATTACK2) then
			self:ToggleSilencer()
		end
	end
end
