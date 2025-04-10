-- HandleFocus: Client-side focus & selection logic

local HighlightAsset = game:GetService("ReplicatedStorage"):WaitForChild("Auras"):FindFirstChild("Highlighter"):Clone()

local module = {}

local function loopEmitter(emitter:ParticleEmitter, ctx)
	-- Manage the warm particle that is attached when a client has selected an entity
	task.spawn(function()
		while emitter do
			task.wait(19)
			emitter:Clear()
			--task.wait()
			if ctx.Selection then
				emitter:Emit(1)
			end
		end
	end)
end


function module.init(ctx)
	local currentAuraw
	local Mouse = ctx.Mouse
	local LocalPlayer = ctx.LocalPlayer	
	local currentAura = HighlightAsset

	currentAura.Name = "Highlight2"
	currentAura.Lifetime = NumberRange.new(20)
	currentAura:Emit(1)
	
	-- When context.Selection changes, update the aura
	ctx:onChange("Selection", function(newTarget)
		if not ctx.Selection then
			currentAura:Clear()
			return
		end

		-- New target logic
		if newTarget and newTarget:IsA("Model") then
			currentAura:Clear()
			currentAura:Emit(1)
			loopEmitter(currentAura, ctx)
			local mount = newTarget:FindFirstChild("HumanoidRootPart"):FindFirstChild("HighlightMount")
			if mount then
				ctx.Highlight = currentAura
				currentAura.Parent = mount
				
			end
		end
	end)

	print("✅ HandleFocus initialized")
end

return module