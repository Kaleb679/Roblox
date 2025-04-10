-- BarFactory.lua
-- Module to create health or resource bars

local module = {}

-- Shared colors for types
local COLORS = {
	Health = Color3.fromRGB(0, 200, 0),
	Resource = Color3.fromRGB(0, 122, 255), -- default if type not provided
}

-- Create a bar with type: "Health" or "Resource"
-- @param parent - the parent GUI (ScreenGui or Frame)
-- @param position - UDim2 for bar position
-- @param size - UDim2 for bar size
-- @param type - string: "Health" or "Resource"
-- @param zIndex - optional, defaults to 1
function module.createBar(parent, position, size, type, zIndex)
	local barType = type or "Resource"
	local barColor = COLORS[barType] or COLORS.Resource
	local layer = zIndex or 1

	-- Container frame (with border/background)
	local bar = Instance.new("Frame")
	bar.Name = barType .. "Bar"
	bar.Position = position
	bar.Size = size
	bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	bar.BorderColor3 = Color3.fromRGB(90, 90, 90)
	bar.BorderSizePixel = 1
	bar.ZIndex = layer
	bar.Parent = parent

	-- Fill
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.Position = UDim2.new(0, 0, 0, 0)
	fill.BackgroundColor3 = barColor
	fill.BorderSizePixel = 0
	fill.ZIndex = layer + 1
	fill.Parent = bar

	-- Label
	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.SourceSansBold
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.ZIndex = layer + 2
	label.Text = "-- / --"
	label.Parent = bar

	return bar, fill, label
end

return module
