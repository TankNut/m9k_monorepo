-- Stripped down/minimal version of an SCK-esque implementation since it's barely used

function SWEP:InitSCK()
	self.CSEnts = {}
end

function SWEP:RemoveCSEnts()
	for _, ent in pairs(self.CSEnts) do
		ent:Remove()
	end

	self.CSEnts = {}
end

function SWEP:CreateCSEnt(tab)
	local ent = ClientsideModel(tab.Model)
	ent:SetNoDraw(true)

	local matrix = Matrix()
	matrix:Scale(tab.Scale)

	ent:EnableMatrix("RenderMultiply", matrix)

	tab.Entity = ent
	table.insert(self.CSEnts, ent)

	return ent
end

local vector_one = Vector(1, 1, 1)
local matrix = Matrix()

function SWEP:DrawCSEnt(parent, tab, flags)
	local bone = parent:LookupBone(tab.Bone)
	if not bone then return end

	local ent = tab.Entity

	if not IsValid(ent) then
		ent = self:CreateCSEnt(tab)
	end

	parent:CopyBoneMatrix(bone, matrix)

	matrix:SetScale(vector_one)
	matrix:Translate(tab.Pos)
	matrix:Rotate(tab.Ang)

	local pos = matrix:GetTranslation()
	local ang = matrix:GetAngles()

	if parent:GetClass() == "viewmodel" and self.ViewModelFlip then
		ang.r = -ang.r
	end

	ent:SetPos(pos)
	ent:SetAngles(ang)

	if tab.Material then
		render.MaterialOverride(tab.Material)
	end

	ent:SetupBones()
	ent:DrawModel(flags)

	render.MaterialOverride(nil)
end

function SWEP:BuildBoneCache(vm)
	self.BoneCache = {}

	vm:SetupBones()

	for i = 0, vm:GetBoneCount() - 1 do
		self.BoneCache[i] = {
			Parent = vm:GetBoneParent(i)
		}
	end
end

function SWEP:GetBoneScale(vm, index)
	local bone = self.BoneCache[index]

	if bone.Frame == FrameNumber() then
		return bone.Scale
	end

	bone.Frame = FrameNumber()

	local mod = self.ViewModelBoneMods[vm:GetBoneName(index)]

	bone.Scale = mod and Vector(mod.Scale) or Vector(1, 1, 1)

	if bone.Scale != nan and bone.Parent != -1 then
		bone.Scale:Mul(self:GetBoneScale(vm, bone.Parent))
	end

	return bone.Scale
end

function SWEP:ApplyBoneMods(vm)
	for i = 0, vm:GetBoneCount() - 1 do
		local mod = self.ViewModelBoneMods[vm:GetBoneName(i)]
		local scale = self:GetBoneScale(vm, i)

		if scale != vector_one then
			vm:ManipulateBoneScale(i, scale)
		end

		if mod then
			if mod.Ang != angle_zero then
				vm:ManipulateBoneAngles(i, mod.Ang)
			end

			if mod.Pos != vector_origin then
				vm:ManipulateBonePosition(i, mod.Pos)
			end
		end
	end
end

function SWEP:ResetBoneMods(vm)
	for i = 0, vm:GetBoneCount() - 1 do
		local scale = self:GetBoneScale(vm, i)

		if scale != vector_one then
			vm:ManipulateBoneScale(i, vector_one)
		end

		if vm:GetManipulateBoneAngles(i) != angle_zero then
			vm:ManipulateBoneAngles(i, angle_zero)
		end

		if vm:GetManipulateBonePosition(i) != vector_origin then
			vm:ManipulateBonePosition(i, vector_origin)
		end
	end
end

function SWEP:PreDrawViewModel(vm, _, ply, flags)
	if self.ViewModelBoneMods then
		if not self.BoneCache then
			self:BuildBoneCache(vm)
		end

		self:ApplyBoneMods(vm)
		vm:SetupBones()
	end
end

function SWEP:PostDrawViewModel(vm, _, ply, flags)
	if self.VElements then
		for _, tab in ipairs(self.VElements) do
			self:DrawCSEnt(vm, tab, flags)
		end
	end

	if self.ViewModelBoneMods then
		self:ResetBoneMods(vm)
	end
end

function SWEP:DrawWorldModel(flags)
	if not self.HideWorldModel then
		self:DrawModel(flags)
	end

	if self.WElements then
		local ent = self:GetOwner()
		if not ent:IsValid() then ent = self end

		for _, tab in ipairs(self.WElements) do
			self:DrawCSEnt(ent, tab, flags)
		end
	end
end
