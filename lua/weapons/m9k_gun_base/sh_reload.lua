AddCSLuaFile()

function SWEP:IsReloading()
	return self:GetFinishReload() != 0
end
