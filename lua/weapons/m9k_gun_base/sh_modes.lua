AddCSLuaFile()

function SWEP:ToggleFiremode()
	local automatic = not self:GetAutomatic()
	self:SetAutomatic(automatic)

	self:GetOwner():PrintMessage(HUD_PRINTTALK, automatic and "Automatic selected." or "Semi-automatic selected.")

	self:SetNextAction(CurTime() + 0.2)
	self:EmitSound("Weapon_AR2.Empty")
end

function SWEP:UpdateModes()
	if self:GetNextAction() > CurTime() then return end

	local ply = self:GetOwner()

	if ply:KeyDown(IN_USE) then
		if self.SelectiveFire and ply:KeyPressed(IN_RELOAD) then
			self:ToggleFiremode()
		end

		if self.CanBeSilenced and ply:KeyPressed(IN_ATTACK2) then
			print("self:ToggleSilencer()")
		end
	end
end
