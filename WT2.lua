--// Player / character
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ByteNet = ReplicatedStorage:WaitForChild("ByteNetReliable")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local autoButtons = false

----------------------------------------------------------------
-- Modern UI
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernHelperUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(340, 450)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner rounding
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Drop shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.fromOffset(-20, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- Accent gradient bar at top
local AccentBar = Instance.new("Frame")
AccentBar.Name = "AccentBar"
AccentBar.Size = UDim2.new(1, 0, 0, 4)
AccentBar.Position = UDim2.new(0, 0, 0, 0)
AccentBar.BorderSizePixel = 0
AccentBar.Parent = MainFrame

local BarGradient = Instance.new("UIGradient")
BarGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
BarGradient.Parent = AccentBar

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 4)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "🚜 Wheat Tycoon 2 🌾"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -100, 0, 18)
Subtitle.Position = UDim2.new(0, 20, 0, 38)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Farm Helper v2.2.2"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Minimize button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeButton"
MinimizeBtn.Size = UDim2.fromOffset(36, 36)
MinimizeBtn.Position = UDim2.new(1, -88, 0, 14)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 16
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = Header

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8)
MinimizeCorner.Parent = MinimizeBtn

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.fromOffset(36, 36)
CloseBtn.Position = UDim2.new(1, -46, 0, 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Hover effects for buttons
CloseBtn.MouseEnter:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(239, 68, 68)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
	TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 38, 38)}):Play()
end)

MinimizeBtn.MouseEnter:Connect(function()
	TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()
end)

MinimizeBtn.MouseLeave:Connect(function()
	TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
end)

-- Scrollable content container
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -40, 0, 372)
Content.Position = UDim2.new(0, 20, 0, 70)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 8
Content.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
Content.ScrollBarImageTransparency = 0.3
Content.CanvasSize = UDim2.new(0, 0, 0, 400)
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.ScrollingEnabled = true
Content.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Content.ClipsDescendants = true
Content.Parent = MainFrame

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(1, 0)
ScrollCorner.Parent = Content

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 12)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = Content

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingRight = UDim.new(0, 6)
ContentPadding.Parent = Content

----------------------------------------------------------------
-- Modern Button Creator
----------------------------------------------------------------
local function createModernButton(text, layoutOrder, accentColor, hasSettings)
	local ButtonFrame = Instance.new("Frame")
	ButtonFrame.Name = text
	ButtonFrame.Size = UDim2.new(1, -6, 0, 65)
	ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	ButtonFrame.BorderSizePixel = 0
	ButtonFrame.LayoutOrder = layoutOrder
	ButtonFrame.Parent = Content
	
	local BtnCorner = Instance.new("UICorner")
	BtnCorner.CornerRadius = UDim.new(0, 12)
	BtnCorner.Parent = ButtonFrame
	
	local StatusDot = Instance.new("Frame")
	StatusDot.Name = "StatusDot"
	StatusDot.Size = UDim2.fromOffset(10, 10)
	StatusDot.Position = UDim2.new(0, 15, 0.5, -5)
	StatusDot.BackgroundColor3 = Color3.fromRGB(100, 100, 110)
	StatusDot.BorderSizePixel = 0
	StatusDot.Parent = ButtonFrame
	
	local DotCorner = Instance.new("UICorner")
	DotCorner.CornerRadius = UDim.new(1, 0)
	DotCorner.Parent = StatusDot
	
	local BtnLabel = Instance.new("TextLabel")
	BtnLabel.Name = "Label"
	BtnLabel.Size = UDim2.new(1, -90, 0, 22)
	BtnLabel.Position = UDim2.new(0, 35, 0, 12)
	BtnLabel.BackgroundTransparency = 1
	BtnLabel.Text = text
	BtnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	BtnLabel.Font = Enum.Font.GothamBold
	BtnLabel.TextSize = 15
	BtnLabel.TextXAlignment = Enum.TextXAlignment.Left
	BtnLabel.Parent = ButtonFrame
	
	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Name = "Status"
	StatusLabel.Size = UDim2.new(1, -90, 0, 16)
	StatusLabel.Position = UDim2.new(0, 35, 0, 38)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "Disabled"
	StatusLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
	StatusLabel.Font = Enum.Font.Gotham
	StatusLabel.TextSize = 11
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	StatusLabel.Parent = ButtonFrame
	
	local SettingsBtn = nil
	if hasSettings then
		SettingsBtn = Instance.new("TextButton")
		SettingsBtn.Name = "SettingsButton"
		SettingsBtn.Size = UDim2.fromOffset(32, 32)
		SettingsBtn.Position = UDim2.new(1, -108, 0.5, -16)
		SettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
		SettingsBtn.Text = "⚙️"
		SettingsBtn.TextSize = 18
		SettingsBtn.BorderSizePixel = 0
		SettingsBtn.Parent = ButtonFrame
		
		local SettingsCorner = Instance.new("UICorner")
		SettingsCorner.CornerRadius = UDim.new(0, 8)
		SettingsCorner.Parent = SettingsBtn
		
		SettingsBtn.MouseEnter:Connect(function()
			TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 55)}):Play()
		end)
		
		SettingsBtn.MouseLeave:Connect(function()
			TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
		end)
	end
	
	local ToggleBtn = Instance.new("TextButton")
	ToggleBtn.Name = "ToggleButton"
	ToggleBtn.Size = UDim2.fromOffset(60, 32)
	ToggleBtn.Position = UDim2.new(1, -70, 0.5, -16)
	ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	ToggleBtn.Text = ""
	ToggleBtn.BorderSizePixel = 0
	ToggleBtn.Parent = ButtonFrame
	
	local ToggleCorner = Instance.new("UICorner")
	ToggleCorner.CornerRadius = UDim.new(1, 0)
	ToggleCorner.Parent = ToggleBtn
	
	local Slider = Instance.new("Frame")
	Slider.Name = "Slider"
	Slider.Size = UDim2.fromOffset(26, 26)
	Slider.Position = UDim2.fromOffset(3, 3)
	Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Slider.BorderSizePixel = 0
	Slider.Parent = ToggleBtn
	
	local SliderCorner = Instance.new("UICorner")
	SliderCorner.CornerRadius = UDim.new(1, 0)
	SliderCorner.Parent = Slider
	
	ToggleBtn.MouseEnter:Connect(function()
		TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
	end)
	
	ToggleBtn.MouseLeave:Connect(function()
		TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
	end)
	
	return {
		Frame = ButtonFrame,
		Button = ToggleBtn,
		Dot = StatusDot,
		Status = StatusLabel,
		Slider = Slider,
		AccentColor = accentColor,
		SettingsButton = SettingsBtn
	}
end

----------------------------------------------------------------
-- Button Animations
----------------------------------------------------------------
local function toggleButton(btnData, enabled)
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if enabled then
		TweenService:Create(btnData.Button, tweenInfo, {BackgroundColor3 = btnData.AccentColor}):Play()
		TweenService:Create(btnData.Slider, tweenInfo, {Position = UDim2.fromOffset(31, 3)}):Play()
		TweenService:Create(btnData.Dot, tweenInfo, {BackgroundColor3 = btnData.AccentColor}):Play()
		btnData.Status.Text = "Active"
		btnData.Status.TextColor3 = btnData.AccentColor
	else
		TweenService:Create(btnData.Button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
		TweenService:Create(btnData.Slider, tweenInfo, {Position = UDim2.fromOffset(3, 3)}):Play()
		TweenService:Create(btnData.Dot, tweenInfo, {BackgroundColor3 = Color3.fromRGB(100, 100, 110)}):Play()
		btnData.Status.Text = "Disabled"
		btnData.Status.TextColor3 = Color3.fromRGB(120, 120, 130)
	end
end

----------------------------------------------------------------
-- Create Buttons
----------------------------------------------------------------
local AutoButtonsBtn = createModernButton("Auto Buttons", 1, Color3.fromRGB(46, 213, 115), true)
local UpgradeBtn = createModernButton("Auto Upgrade", 2, Color3.fromRGB(52, 152, 219), true)
local RebirthBtn = createModernButton("Auto Rebirth", 3, Color3.fromRGB(155, 89, 182), false)
local PrestigeBtn = createModernButton("Auto Prestige", 4, Color3.fromRGB(241, 196, 15), false)
local AutoPetsBtn = createModernButton("Auto Pets", 5, Color3.fromRGB(230, 126, 34), true)

----------------------------------------------------------------
-- Pet Eggs Data
----------------------------------------------------------------
local EGG_PAYLOADS = {
	{name = "Common Egg", payload = buffer.fromstring("!\a\000PetEggs\n\000Common Egg"), enabled = true},
	{name = "Farm Egg", payload = buffer.fromstring("!\a\000PetEggs\b\000Farm Egg"), enabled = true},
	{name = "Farm Egg 2", payload = buffer.fromstring("!\a\000PetEggs\n\000Farm Egg 2"), enabled = true},
	{name = "Apex Egg", payload = buffer.fromstring("!\a\000PetEggs\b\000Apex Egg"), enabled = true},
	{name = "Ocean Egg", payload = buffer.fromstring("!\a\000PetEggs\t\000Ocean Egg"), enabled = true},
	{name = "Flight Egg", payload = buffer.fromstring("!\a\000PetEggs\n\000Flight Egg"), enabled = true},
	{name = "Dinosaur Egg", payload = buffer.fromstring("!\a\000PetEggs\r\000Dinsosaur Egg"), enabled = true},
	{name = "Crystal Egg", payload = buffer.fromstring("!\a\000PetEggs\v\000Crystal Egg"), enabled = true}
}

----------------------------------------------------------------
-- Pet Settings Menu
----------------------------------------------------------------
local PetSettingsFrame = Instance.new("Frame")
PetSettingsFrame.Name = "PetSettings"
PetSettingsFrame.Size = UDim2.fromOffset(280, 300)
PetSettingsFrame.Position = UDim2.new(0.5, -140, 0.5, -150)
PetSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
PetSettingsFrame.BorderSizePixel = 0
PetSettingsFrame.Visible = false
PetSettingsFrame.ZIndex = 100
PetSettingsFrame.Parent = ScreenGui

local PetSettingsCorner = Instance.new("UICorner")
PetSettingsCorner.CornerRadius = UDim.new(0, 12)
PetSettingsCorner.Parent = PetSettingsFrame

local SettingsHeader = Instance.new("Frame")
SettingsHeader.Size = UDim2.new(1, 0, 0, 50)
SettingsHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SettingsHeader.BorderSizePixel = 0
SettingsHeader.Parent = PetSettingsFrame

local SettingsHeaderCorner = Instance.new("UICorner")
SettingsHeaderCorner.CornerRadius = UDim.new(0, 12)
SettingsHeaderCorner.Parent = SettingsHeader

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -50, 1, 0)
SettingsTitle.Position = UDim2.new(0, 15, 0, 0)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "🐾 Pet Eggs Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextSize = 16
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = SettingsHeader

local CloseSettingsBtn = Instance.new("TextButton")
CloseSettingsBtn.Size = UDim2.fromOffset(32, 32)
CloseSettingsBtn.Position = UDim2.new(1, -42, 0.5, -16)
CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
CloseSettingsBtn.Text = "×"
CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsBtn.Font = Enum.Font.GothamBold
CloseSettingsBtn.TextSize = 20
CloseSettingsBtn.BorderSizePixel = 0
CloseSettingsBtn.Parent = SettingsHeader

local CloseSettingsCorner = Instance.new("UICorner")
CloseSettingsCorner.CornerRadius = UDim.new(0, 8)
CloseSettingsCorner.Parent = CloseSettingsBtn

local PetScroll = Instance.new("ScrollingFrame")
PetScroll.Size = UDim2.new(1, -20, 1, -70)
PetScroll.Position = UDim2.new(0, 10, 0, 60)
PetScroll.BackgroundTransparency = 1
PetScroll.BorderSizePixel = 0
PetScroll.ScrollBarThickness = 6
PetScroll.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
PetScroll.CanvasSize = UDim2.new(0, 0, 0, #EGG_PAYLOADS * 45)
PetScroll.Parent = PetSettingsFrame

local PetListLayout = Instance.new("UIListLayout")
PetListLayout.Padding = UDim.new(0, 8)
PetListLayout.Parent = PetScroll

for i, eggData in ipairs(EGG_PAYLOADS) do
	local CheckFrame = Instance.new("Frame")
	CheckFrame.Size = UDim2.new(1, -10, 0, 38)
	CheckFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	CheckFrame.BorderSizePixel = 0
	CheckFrame.Parent = PetScroll
	
	local CheckCorner = Instance.new("UICorner")
	CheckCorner.CornerRadius = UDim.new(0, 8)
	CheckCorner.Parent = CheckFrame
	
	local CheckBox = Instance.new("TextButton")
	CheckBox.Size = UDim2.fromOffset(24, 24)
	CheckBox.Position = UDim2.new(0, 10, 0.5, -12)
	CheckBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	CheckBox.Text = eggData.enabled and "✓" or ""
	CheckBox.TextColor3 = Color3.fromRGB(46, 213, 115)
	CheckBox.Font = Enum.Font.GothamBold
	CheckBox.TextSize = 16
	CheckBox.BorderSizePixel = 0
	CheckBox.Parent = CheckFrame
	
	local BoxCorner = Instance.new("UICorner")
	BoxCorner.CornerRadius = UDim.new(0, 6)
	BoxCorner.Parent = CheckBox
	
	local CheckLabel = Instance.new("TextLabel")
	CheckLabel.Size = UDim2.new(1, -50, 1, 0)
	CheckLabel.Position = UDim2.new(0, 45, 0, 0)
	CheckLabel.BackgroundTransparency = 1
	CheckLabel.Text = eggData.name
	CheckLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	CheckLabel.Font = Enum.Font.Gotham
	CheckLabel.TextSize = 13
	CheckLabel.TextXAlignment = Enum.TextXAlignment.Left
	CheckLabel.Parent = CheckFrame
	
	CheckBox.MouseButton1Click:Connect(function()
		eggData.enabled = not eggData.enabled
		CheckBox.Text = eggData.enabled and "✓" or ""
	end)
end

CloseSettingsBtn.MouseButton1Click:Connect(function()
	PetSettingsFrame.Visible = false
end)

----------------------------------------------------------------
-- Upgrade Settings Data
----------------------------------------------------------------
local UPGRADE_PAYLOADS = {
	{name = "Wheat Upgrades", payloads = {
		buffer.fromstring("\031\r\000PriceIncrease\005\000Wheat"),
		buffer.fromstring("\031\f\000FasterGrowth\005\000Wheat"),
		buffer.fromstring("\031\f\000CriticalLuck\005\000Wheat"),
		buffer.fromstring("\031\018\000CriticalMultiplier\005\000Wheat"),
	}, enabled = true},

	{name = "Farm Upgrades", payloads = {
		buffer.fromstring("\031\005\000Wheat\004\000Farm"),
		buffer.fromstring("\031\004\000Barn\004\000Farm"),
		buffer.fromstring("\031\005\000Fence\004\000Farm"),
		buffer.fromstring("\031\004\000Silo\004\000Farm"),
		buffer.fromstring("\031\a\000Tractor\004\000Farm"),
		buffer.fromstring("\031\a\000GemMine\004\000Farm"),
	}, enabled = true},

	{name = "Gem Generation", payloads = {
	buffer.fromstring("\031\b\000Cooldown\r\000GemGeneration"),
	buffer.fromstring("\031\004\000Gain\r\000GemGeneration"),
	}, enabled = true}
}

----------------------------------------------------------------
-- Upgrade Settings Menu
----------------------------------------------------------------
local UpgradeSettingsFrame = Instance.new("Frame")
UpgradeSettingsFrame.Name = "UpgradeSettings"
UpgradeSettingsFrame.Size = UDim2.fromOffset(260, 220)
UpgradeSettingsFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
UpgradeSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
UpgradeSettingsFrame.BorderSizePixel = 0
UpgradeSettingsFrame.Visible = false
UpgradeSettingsFrame.ZIndex = 100
UpgradeSettingsFrame.Parent = ScreenGui

local UpgradeCorner = Instance.new("UICorner")
UpgradeCorner.CornerRadius = UDim.new(0, 12)
UpgradeCorner.Parent = UpgradeSettingsFrame

local UpHeader = Instance.new("Frame")
UpHeader.Size = UDim2.new(1, 0, 0, 45)
UpHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
UpHeader.BorderSizePixel = 0
UpHeader.Parent = UpgradeSettingsFrame

local UpHeaderCorner = Instance.new("UICorner")
UpHeaderCorner.CornerRadius = UDim.new(0, 12)
UpHeaderCorner.Parent = UpHeader

local UpTitle = Instance.new("TextLabel")
UpTitle.Size = UDim2.new(1, -50, 1, 0)
UpTitle.Position = UDim2.new(0, 15, 0, 0)
UpTitle.BackgroundTransparency = 1
UpTitle.Text = "⚙️ Upgrade Settings"
UpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
UpTitle.Font = Enum.Font.GothamBold
UpTitle.TextSize = 15
UpTitle.TextXAlignment = Enum.TextXAlignment.Left
UpTitle.Parent = UpHeader

local UpClose = Instance.new("TextButton")
UpClose.Size = UDim2.fromOffset(28, 28)
UpClose.Position = UDim2.new(1, -38, 0.5, -14)
UpClose.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
UpClose.Text = "×"
UpClose.TextColor3 = Color3.fromRGB(255, 255, 255)
UpClose.Font = Enum.Font.GothamBold
UpClose.TextSize = 20
UpClose.BorderSizePixel = 0
UpClose.Parent = UpHeader

local UpCloseCorner = Instance.new("UICorner")
UpCloseCorner.CornerRadius = UDim.new(0, 8)
UpCloseCorner.Parent = UpClose

local UpScroll = Instance.new("ScrollingFrame")
UpScroll.Size = UDim2.new(1, -20, 1, -60)
UpScroll.Position = UDim2.new(0, 10, 0, 55)
UpScroll.BackgroundTransparency = 1
UpScroll.BorderSizePixel = 0
UpScroll.ScrollBarThickness = 6
UpScroll.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
UpScroll.CanvasSize = UDim2.new(0, 0, 0, #UPGRADE_PAYLOADS * 45)
UpScroll.Parent = UpgradeSettingsFrame

local UpListLayout = Instance.new("UIListLayout")
UpListLayout.Padding = UDim.new(0, 8)
UpListLayout.Parent = UpScroll

for _, upg in ipairs(UPGRADE_PAYLOADS) do
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, -10, 0, 38)
	Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	Frame.BorderSizePixel = 0
	Frame.Parent = UpScroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Frame

	local Box = Instance.new("TextButton")
	Box.Size = UDim2.fromOffset(24, 24)
	Box.Position = UDim2.new(0, 10, 0.5, -12)
	Box.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	Box.Text = upg.enabled and "✓" or ""
	Box.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box.Font = Enum.Font.GothamBold
	Box.TextSize = 16
	Box.BorderSizePixel = 0
	Box.Parent = Frame

	local BoxCorner = Instance.new("UICorner")
	BoxCorner.CornerRadius = UDim.new(0, 6)
	BoxCorner.Parent = Box

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -50, 1, 0)
	Label.Position = UDim2.new(0, 45, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = upg.name
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Frame

	Box.MouseButton1Click:Connect(function()
		upg.enabled = not upg.enabled
		Box.Text = upg.enabled and "✓" or ""
	end)
end

UpClose.MouseButton1Click:Connect(function()
	UpgradeSettingsFrame.Visible = false
end)

if UpgradeBtn.SettingsButton then
	UpgradeBtn.SettingsButton.MouseButton1Click:Connect(function()
		UpgradeSettingsFrame.Visible = not UpgradeSettingsFrame.Visible
	end)
end

----------------------------------------------------------------
-- Auto Buttons Settings Menu
----------------------------------------------------------------
local ButtonSettingsFrame = Instance.new("Frame")
ButtonSettingsFrame.Name = "ButtonSettings"
ButtonSettingsFrame.Size = UDim2.fromOffset(240, 180)
ButtonSettingsFrame.Position = UDim2.new(0.5, -120, 0.5, -90)
ButtonSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ButtonSettingsFrame.BorderSizePixel = 0
ButtonSettingsFrame.Visible = false
ButtonSettingsFrame.ZIndex = 100
ButtonSettingsFrame.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 12)
BtnCorner.Parent = ButtonSettingsFrame

local BtnHeader = Instance.new("Frame")
BtnHeader.Size = UDim2.new(1, 0, 0, 45)
BtnHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
BtnHeader.BorderSizePixel = 0
BtnHeader.Parent = ButtonSettingsFrame

local BtnHeaderCorner = Instance.new("UICorner")
BtnHeaderCorner.CornerRadius = UDim.new(0, 12)
BtnHeaderCorner.Parent = BtnHeader

local BtnTitle = Instance.new("TextLabel")
BtnTitle.Size = UDim2.new(1, -50, 1, 0)
BtnTitle.Position = UDim2.new(0, 15, 0, 0)
BtnTitle.BackgroundTransparency = 1
BtnTitle.Text = "⚙️ Auto Buttons Settings"
BtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnTitle.Font = Enum.Font.GothamBold
BtnTitle.TextSize = 15
BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
BtnTitle.Parent = BtnHeader

local BtnClose = Instance.new("TextButton")
BtnClose.Size = UDim2.fromOffset(28, 28)
BtnClose.Position = UDim2.new(1, -38, 0.5, -14)
BtnClose.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
BtnClose.Text = "×"
BtnClose.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnClose.Font = Enum.Font.GothamBold
BtnClose.TextSize = 20
BtnClose.BorderSizePixel = 0
BtnClose.Parent = BtnHeader

local BtnCloseCorner = Instance.new("UICorner")
BtnCloseCorner.CornerRadius = UDim.new(0, 8)
BtnCloseCorner.Parent = BtnClose

local BtnScroll = Instance.new("ScrollingFrame")
BtnScroll.Size = UDim2.new(1, -20, 1, -60)
BtnScroll.Position = UDim2.new(0, 10, 0, 55)
BtnScroll.BackgroundTransparency = 1
BtnScroll.BorderSizePixel = 0
BtnScroll.ScrollBarThickness = 6
BtnScroll.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
BtnScroll.CanvasSize = UDim2.new(0, 0, 0, 100)
BtnScroll.Parent = ButtonSettingsFrame

local BtnList = Instance.new("UIListLayout")
BtnList.Padding = UDim.new(0, 8)
BtnList.Parent = BtnScroll

local ROW_SETTINGS = {
	{name = "Row 1 (≤ $22.81K)", key = "row1", enabled = true},
	{name = "Row 2 (> $22.81K)", key = "row2", enabled = false}
}

for _, row in ipairs(ROW_SETTINGS) do
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, -10, 0, 38)
	Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	Frame.BorderSizePixel = 0
	Frame.Parent = BtnScroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Frame

	local Box = Instance.new("TextButton")
	Box.Size = UDim2.fromOffset(24, 24)
	Box.Position = UDim2.new(0, 10, 0.5, -12)
	Box.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	Box.Text = row.enabled and "✓" or ""
	Box.TextColor3 = Color3.fromRGB(46, 213, 115)
	Box.Font = Enum.Font.GothamBold
	Box.TextSize = 16
	Box.BorderSizePixel = 0
	Box.Parent = Frame

	local BoxCorner = Instance.new("UICorner")
	BoxCorner.CornerRadius = UDim.new(0, 6)
	BoxCorner.Parent = Box

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -50, 1, 0)
	Label.Position = UDim2.new(0, 45, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = row.name
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Frame

	Box.MouseButton1Click:Connect(function()
		row.enabled = not row.enabled
		Box.Text = row.enabled and "✓" or ""
	end)
end

BtnClose.MouseButton1Click:Connect(function()
	ButtonSettingsFrame.Visible = false
end)

if AutoButtonsBtn.SettingsButton then
	AutoButtonsBtn.SettingsButton.MouseButton1Click:Connect(function()
		ButtonSettingsFrame.Visible = not ButtonSettingsFrame.Visible
	end)
end

----------------------------------------------------------------
-- Draggable Function (Optimized)
----------------------------------------------------------------
local function makeDraggable(frame, header)
	local dragging, dragStart, startPos
	
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			
			local conn
			conn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					conn:Disconnect()
				end
			end)
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(ButtonSettingsFrame, BtnHeader)
makeDraggable(UpgradeSettingsFrame, UpHeader)
makeDraggable(PetSettingsFrame, SettingsHeader)
makeDraggable(MainFrame, Header)

if AutoPetsBtn.SettingsButton then
	AutoPetsBtn.SettingsButton.MouseButton1Click:Connect(function()
		PetSettingsFrame.Visible = not PetSettingsFrame.Visible
	end)
end

----------------------------------------------------------------
-- Auto Pets Logic (super simple spam)
----------------------------------------------------------------
local autoPetsEnabled = false

local function autoPetsLoop()
    autoPetsEnabled = not autoPetsEnabled
    toggleButton(AutoPetsBtn, autoPetsEnabled)

    if autoPetsEnabled then
        task.spawn(function()
            while autoPetsEnabled do
                for _, eggData in ipairs(EGG_PAYLOADS) do
                    if not autoPetsEnabled then break end
                    if eggData.enabled then
                        -- откроем яйцо
                        pcall(function()
                            ByteNet:FireServer(eggData.payload)
                        end)
                        task.wait(0.15) -- небольшая задержка между яйцами
                    end
                end

                -- маленькая пауза перед новым кругом
                task.wait(0.3)
            end
        end)
    end
end

AutoPetsBtn.Button.MouseButton1Click:Connect(autoPetsLoop)

----------------------------------------------------------------
-- Smart Auto Buttons Logic (Optimized)
----------------------------------------------------------------
local function hasTouchTx(part)
	for _, d in ipairs(part:GetDescendants()) do
		if d:IsA("TouchTransmitter") then
			return true
		end
	end
	return false
end

local function parsePrice(text)
	if not text or text == "" then return math.huge end
	text = text:gsub("%$", ""):gsub(",", ""):gsub("%s+", "")
	local num, suffix = text:match("([%d%.]+)([KMB]?)")
	num = tonumber(num)
	if not num then return math.huge end
	if suffix == "K" then num *= 1e3
	elseif suffix == "M" then num *= 1e6
	elseif suffix == "B" then num *= 1e9 end
	return num
end

local function getPlayerPlot()
    local plotsFolder = workspace:FindFirstChild("Plots")
    if not plotsFolder then return nil end

    -- 1️⃣ Проверяем все участки
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        local ownerTag = plot:FindFirstChild("Owner") or plot:FindFirstChild("PlotOwner")
        if ownerTag then
            local ownerName

            if ownerTag:IsA("StringValue") then
                ownerName = ownerTag.Value
            elseif ownerTag:IsA("ObjectValue") and ownerTag.Value then
                ownerName = ownerTag.Value.Name
            elseif ownerTag:IsA("BasePart") or ownerTag:IsA("Model") then
                ownerName = ownerTag.Name
            end

            if ownerName == player.Name then
                return plot
            end
        end
    end

    -- 2️⃣ Если не нашли по владельцу — берём ближайший
    local character = player.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearestPlot, dist = nil, math.huge
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        local buyButtons = plot:FindFirstChild("BuyButtons")
        if buyButtons then
            local button = buyButtons:FindFirstChildWhichIsA("BasePart", true)
            if button then
                local d = (button.Position - hrp.Position).Magnitude
                if d < dist then
                    dist = d
                    nearestPlot = plot
                end
            end
        end
    end

    return nearestPlot
end

----------------------------------------------

local AUTO_TELE_PAYLOAD = buffer.fromstring("\023\001")

local function autoButtonsLoop()
	autoButtons = not autoButtons
	toggleButton(AutoButtonsBtn, autoButtons)

	if autoButtons then
		task.spawn(function()
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:WaitForChild("HumanoidRootPart")
			local myPlot = getPlayerPlot()
			
			if not myPlot then
				warn("❌ Plot not found!")
				toggleButton(AutoButtonsBtn, false)
				autoButtons = false
				return
			end

			while autoButtons do
				local buyButtons = myPlot:FindFirstChild("BuyButtons")
				if buyButtons then
					for _, part in ipairs(buyButtons:GetDescendants()) do
						if not autoButtons then break end
						if part:IsA("BasePart") then
							local billboard = part:FindFirstChild("BillboardGui")
							local priceObj = billboard and billboard:FindFirstChild("Price")
							local price = parsePrice(priceObj and priceObj.Text or "")
							
							local allowRow1 = ROW_SETTINGS[1].enabled and price <= 22810
							local allowRow2 = ROW_SETTINGS[2].enabled and price > 22810
							
							if allowRow1 or allowRow2 then
								task.spawn(function()
									pcall(function()
										ByteNet:FireServer(AUTO_TELE_PAYLOAD, {part})
									end)
								end)
							end
						end
					end
				end
				task.wait(0.25)
			end
		end)
	end
end

AutoButtonsBtn.Button.MouseButton1Click:Connect(autoButtonsLoop)

----------------------------------------------------------------
-- Payload Data
----------------------------------------------------------------
local PAYLOAD = {
	Rebirth  = buffer.fromstring("\026"),
	Prestige = buffer.fromstring("\027")
}

----------------------------------------------------------------
-- Auto Upgrade Logic (Rewritten)
----------------------------------------------------------------
local autoUpgradeEnabled = false

local function autoUpgradeLoop()
	autoUpgradeEnabled = not autoUpgradeEnabled
	toggleButton(UpgradeBtn, autoUpgradeEnabled)

	if autoUpgradeEnabled then
		task.spawn(function()
			while autoUpgradeEnabled do
				for _, upgradeGroup in ipairs(UPGRADE_PAYLOADS) do
					if upgradeGroup.enabled then
						for _, payload in ipairs(upgradeGroup.payloads) do
							if not autoUpgradeEnabled then break end
							pcall(function()
								ByteNet:FireServer(payload)
							end)

							-- индивидуальные задержки
							local payloadStr = tostring(payload)
							if payloadStr:find("PriceIncrease") then
								task.wait(0.5)
							else
								task.wait(0.7)
							end
						end
					end
				end

				-- маленький отдых перед новым кругом
				task.wait(0.7)
			end
		end)
	end
end

UpgradeBtn.Button.MouseButton1Click:Connect(autoUpgradeLoop)

----------------------------------------------------------------
-- Auto Rebirth Logic (Optimized)
----------------------------------------------------------------
local autoRebirthEnabled = false

local function autoRebirthLoop()
	autoRebirthEnabled = not autoRebirthEnabled
	toggleButton(RebirthBtn, autoRebirthEnabled)

	if autoRebirthEnabled then
		task.spawn(function()
			while autoRebirthEnabled do
				task.spawn(function()
					pcall(function()
						ByteNet:FireServer(PAYLOAD.Rebirth)
					end)
				end)
				task.wait(2.5)
			end
		end)
	end
end

RebirthBtn.Button.MouseButton1Click:Connect(autoRebirthLoop)

----------------------------------------------------------------
-- Auto Prestige Logic (Optimized)
----------------------------------------------------------------
local autoPrestigeEnabled = false

local function autoPrestigeLoop()
	autoPrestigeEnabled = not autoPrestigeEnabled
	toggleButton(PrestigeBtn, autoPrestigeEnabled)

	if autoPrestigeEnabled then
		task.spawn(function()
			while autoPrestigeEnabled do
				task.spawn(function()
					pcall(function()
						ByteNet:FireServer(PAYLOAD.Prestige)
					end)
				end)
				task.wait(10)
			end
		end)
	end
end

PrestigeBtn.Button.MouseButton1Click:Connect(autoPrestigeLoop)

----------------------------------------------------------------
-- Minimize/Maximize Logic
----------------------------------------------------------------
local isMinimized = false
local normalSize = UDim2.fromOffset(340, 450)
local minimizedSize = UDim2.fromOffset(340, 64)

MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	
	local targetSize = isMinimized and minimizedSize or normalSize
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
	TweenService:Create(Content, tweenInfo, {
		Size = isMinimized and UDim2.new(1, -40, 0, 0) or UDim2.new(1, -40, 0, 372)
	}):Play()
	
	MinimizeBtn.Text = isMinimized and "+" or "─"
end)

----------------------------------------------------------------
-- Close Button
----------------------------------------------------------------
CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UDim2.fromOffset(0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}):Play()
	task.wait(0.3)
	ScreenGui:Destroy()
end)

-- Entrance animation
MainFrame.Size = UDim2.fromOffset(0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = normalSize,
	Position = UDim2.new(0.5, -170, 0.5, -225)
}):Play()

----------------------------------------------------------------
-- Disable "required!" popups (Optimized)
----------------------------------------------------------------
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			for _, gui in ipairs(player.PlayerGui:GetChildren()) do
				if gui ~= ScreenGui then
					for _, obj in ipairs(gui:GetDescendants()) do
						if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
							local txt = string.lower(obj.Text or "")
							if txt:find("required") or txt:find("not enough") then
								obj.Visible = false
								task.defer(function()
									obj:Destroy()
								end)
							end
						end
					end
				end
			end
		end)
	end
end)

----------------------------------------------------------------
-- 💤 Anti-AFK (silent & automatic)
----------------------------------------------------------------
task.spawn(function()
	local vu = game:GetService("VirtualUser")
	local player = game:GetService("Players").LocalPlayer

	player.Idled:Connect(function()
		task.wait(2)
		pcall(function()
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
	end)
end)

-------------------------------------
-- WEBHOOK
--------------------------------------
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")

-- Детект инжекторов
local injectorName = 
    is_sirhurt_closure and "Sirhurt" or
    pebc_execute and "ProtoSmasher" or
    syn and "Synapse X" or
    secure_load and "Sentinel" or
    KRNL_LOADED and "Krnl" or
    SONA_LOADED and "Sona" or
    getexecutorname and getexecutorname() or
    identifyexecutor and identifyexecutor() or
    (type(get_hui) == "function" and "Solara") or
    (type(Velocity) == "table" and "Velocity") or
    (type(Swift) == "table" and "Swift") or
    (type(Flux) == "table" and "Flux") or
    (type(Oxygen) == "table" and "Oxygen") or
    (type(Electron) == "table" and "Electron") or
    "Unknown Injector"

-- Детект языка клиента (улучшенный)
local playerLanguage = "Unknown"
local languageDisplay = "🌍 Unknown"

-- Метод 1: Через LocalizationService
local success1 = pcall(function()
    local result, code = LocalizationService:GetCountryRegionForPlayerAsync(player)
    if code and code ~= "" then
        playerLanguage = code
    end
end)

-- Метод 2: Через SystemLocaleId (запасной)
if playerLanguage == "Unknown" then
    pcall(function()
        local localeId = LocalizationService.SystemLocaleId
        if localeId and localeId ~= "" then
            playerLanguage = localeId:sub(1, 2):upper() -- Берём первые 2 буквы (ru, en, etc)
        end
    end)
end

-- Метод 3: Через RobloxLocaleId
if playerLanguage == "Unknown" then
    pcall(function()
        local robloxLocale = LocalizationService.RobloxLocaleId
        if robloxLocale and robloxLocale ~= "" then
            playerLanguage = robloxLocale:sub(1, 2):upper()
        end
    end)
end

-- Определяем отображаемый язык
if playerLanguage:find("RU") or playerLanguage:find("ru") then
    languageDisplay = "🇷🇺 Русский"
elseif playerLanguage:find("BY") or playerLanguage:find("by") then
    languageDisplay = "🇧🇾 Беларусь"
elseif playerLanguage:find("UA") or playerLanguage:find("uk") then
    languageDisplay = "🇺🇦 Украина"
elseif playerLanguage:find("KZ") or playerLanguage:find("kk") then
    languageDisplay = "🇰🇿 Казахстан"
elseif playerLanguage:find("US") or playerLanguage:find("GB") or playerLanguage:find("EN") or playerLanguage:find("en") then
    languageDisplay = "🇺🇸 English"
elseif playerLanguage:find("ES") or playerLanguage:find("es") then
    languageDisplay = "🇪🇸 Español"
elseif playerLanguage:find("BR") or playerLanguage:find("PT") or playerLanguage:find("pt") then
    languageDisplay = "🇧🇷 Português"
elseif playerLanguage:find("DE") or playerLanguage:find("de") then
    languageDisplay = "🇩🇪 Deutsch"
elseif playerLanguage:find("FR") or playerLanguage:find("fr") then
    languageDisplay = "🇫🇷 Français"
elseif playerLanguage:find("PL") or playerLanguage:find("pl") then
    languageDisplay = "🇵🇱 Polski"
elseif playerLanguage:find("TR") or playerLanguage:find("tr") then
    languageDisplay = "🇹🇷 Türkçe"
elseif playerLanguage:find("CN") or playerLanguage:find("zh") then
    languageDisplay = "🇨🇳 中文"
elseif playerLanguage:find("JP") or playerLanguage:find("ja") then
    languageDisplay = "🇯🇵 日本語"
elseif playerLanguage:find("KR") or playerLanguage:find("ko") then
    languageDisplay = "🇰🇷 한국어"
elseif playerLanguage ~= "Unknown" then
    languageDisplay = "🌍 " .. playerLanguage
else
    languageDisplay = "🌍 Unknown (локаль недоступна)"
end

local url = "https://discord.com/api/webhooks/1436601003473637467/G9PhHc7J-f7yPbv_4LZnNkbcvvtWcvRvs9yWl2fTYxoZPh9FR28oBudg_pSNvqHwT8fq"

-- Функция отправки вебхука
local function sendWebhook(message)
    local data = {
        ["content"] = message,
        ["username"] = "Wheat Tycoon Tracker"
    }
    local newdata = HttpService:JSONEncode(data)
    local headers = {
        ["content-type"] = "application/json"
    }
    
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

-- Отправляем сообщение о входе
local joinMessage = string.format(
    "🎮 **Игрок присоединился к серверу**\n" ..
    "👤 **Ник:** %s\n" ..
    "🆔 **UserID:** %d\n" ..
    "🌐 **ServerID:** `%s`\n" ..
    "⚡ **Инжектор:** %s\n" ..
    "🗣️ **Язык:** %s\n" ..
    "🕒 **Время:** %s",
    player.Name, player.UserId, game.JobId, injectorName, languageDisplay, os.date("%Y-%m-%d %H:%M:%S")
)

sendWebhook(joinMessage)

-- Отслеживаем выход игрока
game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player then
        local leaveMessage = string.format(
            "🚪 **Игрок покинул сервер**\n" ..
            "👤 **Ник:** %s\n" ..
            "🕒 **Время:** %s",
            player.Name, os.date("%Y-%m-%d %H:%M:%S")
        )
        sendWebhook(leaveMessage)
    end
end)
