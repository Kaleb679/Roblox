

-- GUI Plate Setup Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Character references
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local characterName = humanoid.Parent.Name or "..."

-- 🔧 Scaling factor (1 = original size, 1.5 = 150% bigger, 0.8 = 80% smaller)
local GUISCALE = 0.9

-- Base plate dimensions from exported PNG
local BASE_WIDTH = 320
local BASE_HEIGHT = 116


-- Helper Functions
local function createBar2(parent, size, position, data)
	local bar = Instance.new("Frame")
		bar.Size = UDim2.new(0,160,0,16)
		
end

-- Creates a health/mana/status bar GUI element
-- @param parent Instance: Where to parent the bar (usually a GUI container)
-- @param size table: {w, h} pixel size of the bar
-- @param position table: {x, y} pixel position of the bar
-- @param scale number: GUI scale factor
-- @param barType Enum: Enum string for bar type, e.g. "Health", "Mana"
-- @return Frame: the fill frame of the bar
-- @return TextLabel: the label to update the value
local function createBar(parent, size, position, scale, barType)
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, size[1] * scale, 0, size[2] * scale)
    bar.Position = UDim2.new(0, position[1] * scale, 0, position[2] * scale)
    bar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    bar.BorderSizePixel = 0
    bar.ZIndex = 1
    bar.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(1, 0, 1, 0)

    if barType == "Health" then
        fill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    elseif barType == "Mana" then
        fill.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    else
        fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Default/unknown type
    end

    fill.BorderSizePixel = 0
    fill.ZIndex = 1
    fill.Parent = bar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = fill

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 80))
    }
    gradient.Rotation = 90
    gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(1, 0.2)
    }
    gradient.Parent = fill

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1.6, 0)
	label.Position = UDim2.new(0,0,0,-7)
	--xScale: number? = 0, xOffset: number? = 0, yScale: number? = 0, yOffset: number? = 0
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GrenzeGotisch
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.ZIndex = 2
    label.Text = "100 / 100"
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

-- Name Label
local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "CharacterNameLabel"
	nameLabel.ZIndex = 11
	nameLabel.Size = UDim2.new(0, 200 * GUISCALE, 0, 30 * GUISCALE)
	nameLabel.Position = UDim2.new(0, 115 * GUISCALE, 0, 18 * GUISCALE)
	nameLabel.BackgroundTransparency = 1 -- Make background visible
	nameLabel.TextScaled = true

	nameLabel.Font = Enum.Font.Fondamento
	nameLabel.TextColor3 = Color3.new(1, 0.839215, 0.192156)
	local nameStroke = Instance.new("UIStroke")
		nameStroke.Thickness = 1.5
		nameStroke.Color = Color3.new(0, 0, 0)
		nameStroke.Parent = nameLabel

	nameLabel.TextXAlignment = Enum.TextXAlignment.Center
	nameLabel.TextYAlignment = Enum.TextYAlignment.Center

	nameLabel.Text = characterName
	nameLabel.Parent = plate

-- Add Level Label like the name label
local levelLabel = Instance.new("TextLabel")
	levelLabel.Name = "CharacterLevelLabel"
	levelLabel.ZIndex = 12
	
	levelLabel.Size = UDim2.new(0, 34 * GUISCALE, 0, 34 * GUISCALE)
	levelLabel.Position = UDim2.new(0, 9 * GUISCALE, 0, 84 * GUISCALE)
	
	levelLabel.BackgroundTransparency = 1
	levelLabel.TextScaled = true
	levelLabel.Font = Enum.Font.GrenzeGotisch
	
	levelLabel.TextColor3 = Color3.new(1, 0.839215, 0.192156)
	levelLabel.TextXAlignment = Enum.TextXAlignment.Center
	levelLabel.TextYAlignment = Enum.TextYAlignment.Center
	
	levelLabel.Text = "11"
	levelLabel.Parent = plate

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

-- Assume 'plate' is your main GUI background container
local healthFill, healthLabel = createBar(plate, {202, 18}, {114, 50}, GUISCALE, "Health")
local manaFill, manaLabel = createBar(plate, {202, 18}, {114, 70}, GUISCALE, "Mana")

-- local healthFill, healthText = createBar1(10, Color3.fromRGB(0, 200, 0))

