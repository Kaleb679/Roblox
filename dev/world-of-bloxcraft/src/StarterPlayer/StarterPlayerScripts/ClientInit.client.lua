-- ClientInit: Bootstraps all client systems with dynamic module loading

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Internal backing data and listeners
local data = {}
local listeners = {}

-- Reactive context proxy
local context = {}
setmetatable(context, {
	__index = data,
	__newindex = function(_, key, value)
		data[key] = value
		if listeners[key] then
			for _, callback in ipairs(listeners[key]) do
				callback(value)
			end
		end
	end
})

-- Change listener registration
function context:onChange(key, callback)
	listeners[key] = listeners[key] or {}
	table.insert(listeners[key], callback)
end

-- First-person view check (callable from any module)
function context:isFirstPerson()
	local camera = workspace.CurrentCamera
	local head = self.Character and self.Character:FindFirstChild("Head")
	if not head then return false end
	local distance = (camera.Focus.Position - camera.CFrame.Position).Magnitude
	return distance < 1
end

-- Initial context values
context.LocalPlayer = LocalPlayer
context.Mouse = Mouse
context.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
context.ReplicatedStorage = ReplicatedStorage
context.RunService = RunService

context.Selection = nil
context.Highlight = nil
context.Config = {
	DevMode = true,
	Faction = "Alliance",
}

-- Load modules dynamically from /Modules folders
local modulesFolder = script.Parent:WaitForChild("Modules")

for _, folder in ipairs(modulesFolder:GetChildren()) do
	if folder:IsA("Folder") then
		for _, moduleScript in ipairs(folder:GetChildren()) do
			if moduleScript:IsA("ModuleScript") then
				local success, result = pcall(function()
					require(moduleScript).init(context)
				end)

				if success then
					print("✅ Initialized module:", moduleScript:GetFullName())
				else
					warn("❌ Failed to initialize module:", moduleScript:GetFullName(), "\n", result)
				end
			end
		end
	end
end

print("🎮 Client systems initialized dynamically.")