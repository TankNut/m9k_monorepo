AddCSLuaFile()

function SWEP:AddRecoil()
	local pitch = math.Rand(-self.Primary.KickDown, -self.Primary.KickUp * self.KickUpMultiplier)
	local yaw = math.Rand(-self.Primary.KickHorizontal, self.Primary.KickHorizontal)

	-- Ironsight code here

	self:SetActiveRecoil(self:GetActiveRecoil() + Angle(pitch, yaw, 0))
end

function SWEP:UpdateRecoil()
	local decay = math.exp(-self.RecoilKickSpeed * FrameTime())
	local oldRecoil = self:GetActiveRecoil()
	oldRecoil:Normalize()

	local newRecoil = oldRecoil * decay

	self:SetActiveRecoil(newRecoil)

	oldRecoil:Sub(newRecoil)

	if (CLIENT or game.SinglePlayer()) and IsFirstTimePredicted() then
		local ply = self:GetOwner()
		local ang = ply:EyeAngles()
		ang:Add(oldRecoil)

		ply:SetEyeAngles(ang)
	end
end
