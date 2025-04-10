

-- GUI Plate Setup Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Character references
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local characterName = humanoid.Parent.Name or "..."

-- 🔧 Scaling factor (1 = original size, 1.5 = 150% bigger, 0.8 = 80% smaller)
local GUISCALE = 1

-- Base plate dimensions from exported PNG
local BASE_WIDTH = 320
local BASE_HEIGHT = 116


-- Helper Functions
local function createBar2(parent, size, position, data)
	local bar = Instance.new("Frame")
		bar.Size = UDim2.new(0,160,0,16)
		
end

local function createBar1(yOffset, color)
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 160, 0, 16)
	bar.Position = UDim2.new(0, 34, 0, yOffset)
	bar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	bar.BorderColor3 = Color3.fromRGB(70, 70, 70)
	bar.BorderSizePixel = 1
	-- bar.Parent = bg

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = color
	fill.BorderSizePixel = 0
	fill.ZIndex = 2
	fill.Parent = bar

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 220, 220)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
	}
	gradient.Rotation = 90
	gradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.05),
		NumberSequenceKeypoint.new(1, 0.2)
	}
	gradient.Parent = fill

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.Font = Enum.Font.SourceSansBold
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.ZIndex = 3
	label.Parent = bar

	return fill, label
end



-- Create the main HUD container
local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "OverlayHUD"
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

-- Insert the Main GUI Design Plate
local plate = Instance.new("ImageLabel")
	plate.ZIndex = 10
	plate.Name = "HUDPlate"
	plate.Image = "rbxassetid://79783219795743" -- ✅ Your PNG asset ID
	plate.Size = UDim2.new(0, BASE_WIDTH * GUISCALE, 0, BASE_HEIGHT * GUISCALE)
	plate.Position = UDim2.new(0, 20 * GUISCALE, 0, 60 * GUISCALE)
	plate.BackgroundTransparency = 1
	plate.BorderSizePixel = 0
	plate.Parent = screenGui

-- Character Name
-- local nameLabel = Instance.new("TextLabel")
-- nameLabel.ZIndex = 12
-- nameLabel.Size = UDim2.new(0, 100, 0, 100) -- Adjust size as needed

-- nameLabel.outline
-- nameLabel.AnchorPoint = Vector2.new(1, 1)
-- nameLabel.Position = UDim2.new(1, 50, 1, 25)
-- nameLabel.BackgroundTransparency = 1
-- nameLabel.TextScaled = true
-- nameLabel.Font = Enum.Font.SourceSansBold
-- nameLabel.TextColor3 = Color3.new(1, 1, 1)
-- -- nameLabel.TextXAlignment = Enum.TextXAlignment.Center
-- -- nameLabel.TextYAlignment = Enum.TextYAlignment.Center
-- nameLabel.Text = characterName
-- nameLabel.Parent = plate

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "CharacterNameLabel"
-- nameLabel.Font = Enum.Font.Bodoni

nameLabel.ZIndex = 11
nameLabel.Size = UDim2.new(0, 200 * GUISCALE, 0, 30 * GUISCALE)
nameLabel.Position = UDim2.new(0, 115 * GUISCALE, 0, 18 * GUISCALE)
nameLabel.BackgroundTransparency = 1 -- Make background visible
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.TextColor3 = Color3.new(1, 0.819607, 0.090196)
nameLabel.TextXAlignment = Enum.TextXAlignment.Center
nameLabel.TextYAlignment = Enum.TextYAlignment.Center
nameLabel.Text = characterName
nameLabel.Parent = plate


-- Insert Avatar Image
local avatarImage = Instance.new("ImageLabel")
	avatarImage.ZIndex = 1
	local size = 96
	avatarImage.Size = UDim2.new(0, size *GUISCALE, 0, size*GUISCALE)
	avatarImage.Position = UDim2.new(0, 29*GUISCALE, 0, 68*GUISCALE)
	avatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	
	
	-- Avatar circle crop
	local round = Instance.new("UICorner")
	round.CornerRadius = UDim.new(1, 0)
	round.Parent = avatarImage
	
	-- Border?
	avatarImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	avatarImage.BorderSizePixel = 2
	avatarImage.Image = ""
	
	avatarImage.Parent = screenGui


	local success, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(LocalPlayer.Name)
	end)

	if success and userId then
		local thumb = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
		avatarImage.Image = thumb
	end



-- local healthFill, healthText = createBar1(10, Color3.fromRGB(0, 200, 0))

