-- Not actually SCK, an approximation since basically fuck-all is used

function SWEP:RemoveFakeEntities()
	SafeRemoveEntity(self.FakeViewEntity)
	SafeRemoveEntity(self.FakeWorldEntity)
end

local function createEntity(tab)
	local ent = ClientsideModel(tab.Model)
	ent:SetNoDraw(true)

	local matrix = Matrix()
	matrix:Scale(tab.Scale)

	ent:EnableMatrix("RenderMultiply", matrix)

	return ent
end

local vector_one = Vector(1, 1, 1)

function SWEP:RenderFakeEntity(parent, ent, tab, flags)
	local bone = parent:LookupBone(tab.Bone)

	if not bone then
		return
	end

	local matrix = parent:GetBoneMatrix(bone)
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

	ent:DrawModel(flags)
end

function SWEP:BuildBoneCache(vm)
	self.BoneCache = {}

	vm:SetupBones()

	for i = 0, vm:GetBoneCount() - 1 do
		self.BoneCache[i] = {
			parent = vm:GetBoneParent(i)
		}
	end
end

function SWEP:GetBoneScale(vm, index)
	local bone = self.BoneCache[index]

	if bone.frame == FrameNumber() then
		return bone.scale
	end

	bone.frame = FrameNumber()

	local mod = self.ViewModelBoneMods[vm:GetBoneName(index)]

	bone.scale = mod and Vector(mod.scale) or Vector(1, 1, 1)

	if bone.scale != nan and bone.parent != -1 then
		bone.scale:Mul(self:GetBoneScale(vm, bone.parent))
	end

	return bone.scale
end

function SWEP:ApplyBoneMods(vm)
	for i = 0, vm:GetBoneCount() - 1 do
		local mod = self.ViewModelBoneMods[vm:GetBoneName(i)]
		local scale = self:GetBoneScale(vm, i)

		if scale != vector_one then
			vm:ManipulateBoneScale(i, scale)
		end

		if mod then
			if mod.angle != angle_zero then
				vm:ManipulateBoneAngles(i, mod.angle)
			end

			if mod.pos != vector_origin then
				vm:ManipulateBonePosition(i, mod.pos)
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
	if self.FakeViewModel then
		if not IsValid(self.FakeViewEntity) then
			self.FakeViewEntity = createEntity(self.FakeViewModel)
		end

		self:RenderFakeEntity(vm, self.FakeViewEntity, self.FakeViewModel, flags)
	end

	if self.ViewModelBoneMods then
		self:ResetBoneMods(vm)
	end
end

function SWEP:DrawWorldModel(flags)
	if self.FakeWorldModel then
		if not IsValid(self.FakeWorldEntity) then
			self.FakeWorldEntity = createEntity(self.FakeWorldModel)
		end

		local ent = self:GetOwner()
		if not ent:IsValid() then ent = self end

		self:RenderFakeEntity(ent, self.FakeWorldEntity, self.FakeWorldModel, flags)
	else
		self:DrawModel(flags)
	end
end
