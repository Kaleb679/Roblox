-- Basic click-to-select using raycast

local module = {}

function module.init(ctx)
	local UserInputService = game:GetService("UserInputService")
	local Camera = workspace.CurrentCamera
	local Mouse = ctx.LocalPlayer:GetMouse()
	
	--local Camera = workspace.CurrentCamera
	--local head = character:FindFirstChild("Head")

	

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		
		if ctx:isFirstPerson() then
			local target = ctx.Mouse.Target:FindFirstAncestorOfClass("Model")
			print(target)
			
			if target and target ~= ctx.Selection then
				ctx.Selection = target
				
			end
			if not target then
				ctx.Selection = nil
			end
			return
		end

		local mousePos = UserInputService:GetMouseLocation()
		local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
		
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude
		rayParams.FilterDescendantsInstances = {}
		rayParams.IgnoreWater = true
		
		local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, rayParams)
		
		if result then
			local part = result.Instance
			local targetModel = part:FindFirstAncestorOfClass("Model")

			if not targetModel then
				ctx.Selection = nil
				return
			end
			if targetModel and targetModel ~= ctx.Selection then
				ctx.Selection = targetModel
				return
			end
			
		end
	end)

	print("✅ HandleFocus (basic raycast) initialized.")
end

return module