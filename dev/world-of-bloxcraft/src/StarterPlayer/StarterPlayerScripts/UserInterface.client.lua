-- -- -- Services
-- -- local Players = game:GetService("Players")
-- -- local RunService = game:GetService("RunService")
-- -- local LocalPlayer = Players.LocalPlayer

-- -- -- Character references
-- -- local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
-- -- local GUISCALE
-- -- local humanoid = character:WaitForChild("Humanoid")
-- -- local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- -- -- Optional stats
-- -- local resource = character:FindFirstChild("Resource")
-- -- local resourceMax = character:FindFirstChild("ResourceMax")
-- -- local classValue = character:FindFirstChild("ClassName")
-- -- local levelValue = character:FindFirstChild("Level")
-- -- local factionValue = character:FindFirstChild("Faction")
-- -- print(character)

-- -- -- Create HUD container GUI
-- -- local gui = Instance.new("ScreenGui")
-- -- gui.Name = "PlayerHUD"
-- -- gui.ResetOnSpawn = false
-- -- gui.IgnoreGuiInset = true
-- -- gui.Parent = playerGui

-- -- -- Outer container for layout control (useful for animations/padding later)
-- -- local container = Instance.new("Frame")
-- -- container.Size = UDim2.new(0, 200, 0, 70)
-- -- container.Position = UDim2.new(0, 40, 0, 60)
-- -- container.BackgroundTransparency = 1
-- -- container.BorderSizePixel = 0
-- -- container.Parent = gui

-- -- -- Determine background color by faction
-- -- local bgColor = Color3.fromRGB(25, 25, 25)
-- -- if factionValue then
-- -- 	if factionValue.Value == "Alliance" then
-- -- 		bgColor = Color3.fromRGB(70, 130, 180) -- Steel Blue
-- -- 	elseif factionValue.Value == "The Shadow" then
-- -- 		bgColor = Color3.fromRGB(139, 0, 0) -- Blood Red
-- -- 	end
-- -- end

-- -- -- Background panel inside the container
-- -- local bg = Instance.new("Frame")
-- -- bg.Size = UDim2.new(1, 0, 1, -10)
-- -- bg.Position = UDim2.new(0, 20, 0, 5)
-- -- bg.BackgroundColor3 = bgColor
-- -- bg.Transparency = 1
-- -- bg.BorderSizePixel = 2
-- -- bg.Parent = container

-- -- -- -- Avatar image
-- local avatarImage = Instance.new("ImageLabel")
-- avatarImage.Size = UDim2.new(0, 78, 0, 78)
-- avatarImage.Position = UDim2.new(0, -43, 0, 1)
-- avatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- --avatarImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
-- --avatarImage.BorderSizePixel = 2
-- avatarImage.Image = ""
-- avatarImage.Parent = bg

-- -- Avatar circle crop
-- local round = Instance.new("UICorner")
-- round.CornerRadius = UDim.new(1, 0)
-- round.Parent = avatarImage
   
-- --Avatar outline
-- local outline = Instance.new("UIStroke")
-- outline.Thickness = 0
-- outline.Color = Color3.fromRGB(0, 0, 0)
-- --outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
-- outline.Parent = avatarImage

-- local outline = Instance.new("UIStroke")
-- outline.Thickness = 4
-- outline.Color = Color3.fromRGB(0, 0, 0)
-- outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
-- outline.Parent = avatarImage





-- -- -- Level bubble overlay
-- -- local levelBubble = Instance.new("TextLabel")
-- -- levelBubble.Size = UDim2.new(0, 24, 0, 24)
-- -- levelBubble.Position = UDim2.new(0, -7, 1, 2)
-- -- levelBubble.AnchorPoint = Vector2.new(0, 1)
-- -- levelBubble.BackgroundColor3 = Color3.fromRGB(207, 216, 216)
-- -- levelBubble.TextColor3 = Color3.new(1, 1, 1)
-- -- levelBubble.Font = Enum.Font.SourceSansBold
-- -- levelBubble.TextScaled = true
-- -- levelBubble.TextXAlignment = Enum.TextXAlignment.Center
-- -- levelBubble.TextYAlignment = Enum.TextYAlignment.Center
-- -- levelBubble.BorderSizePixel = 0
-- -- levelBubble.Text = levelValue and tostring(levelValue.Value) or "1"
-- -- levelBubble.Parent = avatarImage

-- -- local levelCorner = Instance.new("UICorner")
-- -- levelCorner.CornerRadius = UDim.new(1, 0)
-- -- levelCorner.Parent = levelBubble

-- -- -- Name label
-- -- local nameLabel = Instance.new("TextLabel")
-- -- nameLabel.Size = UDim2.new(0, 120, 0, 18)
-- -- nameLabel.Position = UDim2.new(0, 34, 0, 1)
-- -- nameLabel.BackgroundTransparency = 1
-- -- nameLabel.TextScaled = true
-- -- nameLabel.Font = Enum.Font.SourceSansBold
-- -- nameLabel.TextColor3 = Color3.new(1, 1, 1)
-- -- nameLabel.TextXAlignment = Enum.TextXAlignment.Left
-- -- nameLabel.Text = LocalPlayer.Name
-- -- nameLabel.Parent = bg

-- -- -- Load avatar thumbnail
-- -- local success, userId = pcall(function()
-- -- 	return Players:GetUserIdFromNameAsync(LocalPlayer.Name)
-- -- end)

-- -- if success and userId then
-- -- 	local thumb = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60)
-- -- 	avatarImage.Image = thumb
-- -- end

-- -- -- Bar creation utility
-- -- local function createBar(yOffset, color)
-- -- 	local bar = Instance.new("Frame")
-- -- 	bar.Size = UDim2.new(0, 160, 0, 16)
-- -- 	bar.Position = UDim2.new(0, 34, 0, yOffset)
-- -- 	bar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
-- -- 	bar.BorderColor3 = Color3.fromRGB(70, 70, 70)
-- -- 	bar.BorderSizePixel = 1
-- -- 	bar.Parent = bg

-- -- 	local fill = Instance.new("Frame")
-- -- 	fill.Size = UDim2.new(1, 0, 1, 0)
-- -- 	fill.BackgroundColor3 = color
-- -- 	fill.BorderSizePixel = 0
-- -- 	fill.ZIndex = 2
-- -- 	fill.Parent = bar

-- -- 	local gradient = Instance.new("UIGradient")
-- -- 	gradient.Color = ColorSequence.new{
-- -- 		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
-- -- 		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 220, 220)),
-- -- 		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
-- -- 	}
-- -- 	gradient.Rotation = 90
-- -- 	gradient.Transparency = NumberSequence.new{
-- -- 		NumberSequenceKeypoint.new(0, 0.05),
-- -- 		NumberSequenceKeypoint.new(1, 0.2)
-- -- 	}
-- -- 	gradient.Parent = fill

-- -- 	local label = Instance.new("TextLabel")
-- -- 	label.Size = UDim2.new(1, 0, 1, 0)
-- -- 	label.BackgroundTransparency = 1
-- -- 	label.TextScaled = true
-- -- 	label.Font = Enum.Font.SourceSansBold
-- -- 	label.TextColor3 = Color3.new(1, 1, 1)
-- -- 	label.TextXAlignment = Enum.TextXAlignment.Center
-- -- 	label.ZIndex = 3
-- -- 	label.Parent = bar

-- -- 	return fill, label
-- -- end

-- -- -- Class-based color helper
-- -- local function getResourceColor(className)
-- -- 	local map = {
-- -- 		Mage = Color3.fromRGB(0, 122, 255),
-- -- 		Warrior = Color3.fromRGB(200, 0, 0),
-- -- 		Rogue = Color3.fromRGB(255, 255, 0),
-- -- 		Druid = Color3.fromRGB(255, 125, 10),
-- -- 	}
-- -- 	return map[className] or Color3.fromRGB(128, 128, 128)
-- -- end

-- -- -- Init resource color
-- -- local classType = classValue and classValue.Value or ""
-- -- local resourceColor = getResourceColor(classType)

-- -- -- Create bars
-- -- local healthFill, healthText = createBar(20, Color3.fromRGB(0, 200, 0))
-- -- local resourceFill, resourceText = createBar(40, resourceColor)

-- -- -- Update loop
-- -- RunService.RenderStepped:Connect(function()
-- -- 	local maxHealth = math.max(humanoid.MaxHealth, 1)
-- -- 	local hpPercent = humanoid.Health / maxHealth
-- -- 	healthFill.Size = UDim2.new(hpPercent, 0, 1, 0)
-- -- 	healthText.Text = string.format("%d / %d", humanoid.Health, humanoid.MaxHealth)

-- -- 	if resource and resourceMax and resource.Value and resourceMax.Value > 0 then
-- -- 		local r = resource.Value / resourceMax.Value
-- -- 		resourceFill.Size = UDim2.new(r, 0, 1, 0)
-- -- 		resourceText.Text = string.format("%d / %d", resource.Value, resourceMax.Value)
-- -- 	else
-- -- 		resourceFill.Size = UDim2.new(0, 0, 1, 0)
-- -- 		resourceText.Text = "-- / --"
-- -- 	end
-- -- end)
