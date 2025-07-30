-- vanegood.lua - Roblox Hub Script
-- For GitHub repository: https://github.com/Vanegood-sus/vanegood.git

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main screen GUI
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "VanegoodHub"
hubGui.Parent = playerGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = hubGui

-- Corner rounding
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0.5, -5, 0.5, -5)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = -1
shadow.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "VANEGOOD HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Content frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0.5, 0, 0.5, 10)
contentFrame.AnchorPoint = Vector2.new(0.5, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Tab buttons
local tabButtons = Instance.new("Frame")
tabButtons.Name = "TabButtons"
tabButtons.Size = UDim2.new(1, 0, 0, 40)
tabButtons.BackgroundTransparency = 1
tabButtons.Parent = contentFrame

local homeTab = Instance.new("TextButton")
homeTab.Name = "HomeTab"
homeTab.Size = UDim2.new(0.5, -5, 1, 0)
homeTab.Position = UDim2.new(0, 0, 0, 0)
homeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
homeTab.Text = "HOME"
homeTab.TextColor3 = Color3.fromRGB(255, 255, 255)
homeTab.TextSize = 14
homeTab.Font = Enum.Font.GothamBold
homeTab.Parent = tabButtons

local homeTabCorner = Instance.new("UICorner")
homeTabCorner.CornerRadius = UDim.new(0, 8)
homeTabCorner.Parent = homeTab

local gamesTab = Instance.new("TextButton")
gamesTab.Name = "GamesTab"
gamesTab.Size = UDim2.new(0.5, -5, 1, 0)
gamesTab.Position = UDim2.new(0.5, 5, 0, 0)
gamesTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
gamesTab.Text = "GAMES"
gamesTab.TextColor3 = Color3.fromRGB(255, 255, 255)
gamesTab.TextSize = 14
gamesTab.Font = Enum.Font.GothamBold
gamesTab.Parent = tabButtons

local gamesTabCorner = Instance.new("UICorner")
gamesTabCorner.CornerRadius = UDim.new(0, 8)
gamesTabCorner.Parent = gamesTab

-- Tab content
local tabContent = Instance.new("Frame")
tabContent.Name = "TabContent"
tabContent.Size = UDim2.new(1, 0, 1, -50)
tabContent.Position = UDim2.new(0, 0, 0, 50)
tabContent.BackgroundTransparency = 1
tabContent.Parent = contentFrame

-- Home tab content
local homeContent = Instance.new("ScrollingFrame")
homeContent.Name = "HomeContent"
homeContent.Size = UDim2.new(1, 0, 1, 0)
homeContent.BackgroundTransparency = 1
homeContent.ScrollBarThickness = 5
homeContent.Visible = true
homeContent.Parent = tabContent

local homeListLayout = Instance.new("UIListLayout")
homeListLayout.Padding = UDim.new(0, 10)
homeListLayout.Parent = homeContent

-- Welcome message
local welcomeFrame = Instance.new("Frame")
welcomeFrame.Name = "WelcomeFrame"
welcomeFrame.Size = UDim2.new(1, -20, 0, 100)
welcomeFrame.Position = UDim2.new(0.5, 0, 0, 10)
welcomeFrame.AnchorPoint = Vector2.new(0.5, 0)
welcomeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
welcomeFrame.Parent = homeContent

local welcomeCorner = Instance.new("UICorner")
welcomeCorner.CornerRadius = UDim.new(0, 8)
welcomeCorner.Parent = welcomeFrame

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Name = "WelcomeTitle"
welcomeTitle.Size = UDim2.new(1, -20, 0, 30)
welcomeTitle.Position = UDim2.new(0.5, 0, 0, 10)
welcomeTitle.AnchorPoint = Vector2.new(0.5, 0)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "WELCOME"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 18
welcomeTitle.Font = Enum.Font.GothamBold
welcomeTitle.Parent = welcomeFrame

local welcomeText = Instance.new("TextLabel")
welcomeText.Name = "WelcomeText"
welcomeText.Size = UDim2.new(1, -20, 0, 50)
welcomeText.Position = UDim2.new(0.5, 0, 0, 40)
welcomeText.AnchorPoint = Vector2.new(0.5, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "Welcome to Vanegood Hub!\nSelect a tab to get started."
welcomeText.TextColor3 = Color3.fromRGB(200, 200, 200)
welcomeText.TextSize = 14
welcomeText.Font = Enum.Font.Gotham
welcomeText.Parent = welcomeFrame

-- Games tab content
local gamesContent = Instance.new("ScrollingFrame")
gamesContent.Name = "GamesContent"
gamesContent.Size = UDim2.new(1, 0, 1, 0)
gamesContent.BackgroundTransparency = 1
gamesContent.ScrollBarThickness = 5
gamesContent.Visible = false
gamesContent.Parent = tabContent

local gamesGridLayout = Instance.new("UIGridLayout")
gamesGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gamesGridLayout.CellSize = UDim2.new(0, 100, 0, 120)
gamesGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
gamesGridLayout.Parent = gamesContent

-- Sample game icons (you can add more)
local game1 = Instance.new("TextButton")
game1.Name = "Game1"
game1.Size = UDim2.new(0, 100, 0, 120)
game1.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
game1.Text = ""
game1.Parent = gamesContent

local game1Corner = Instance.new("UICorner")
game1Corner.CornerRadius = UDim.new(0, 8)
game1Corner.Parent = game1

local game1Icon = Instance.new("ImageLabel")
game1Icon.Name = "Icon"
game1Icon.Size = UDim2.new(0.8, 0, 0.5, 0)
game1Icon.Position = UDim2.new(0.5, 0, 0.2, 0)
game1Icon.AnchorPoint = Vector2.new(0.5, 0)
game1Icon.BackgroundTransparency = 1
game1Icon.Image = "rbxassetid://7072718362" -- Default game icon
game1Icon.Parent = game1

local game1Title = Instance.new("TextLabel")
game1Title.Name = "Title"
game1Title.Size = UDim2.new(0.9, 0, 0.3, 0)
game1Title.Position = UDim2.new(0.5, 0, 0.7, 0)
game1Title.AnchorPoint = Vector2.new(0.5, 0)
game1Title.BackgroundTransparency = 1
game1Title.Text = "Game 1"
game1Title.TextColor3 = Color3.fromRGB(255, 255, 255)
game1Title.TextSize = 14
game1Title.Font = Enum.Font.GothamBold
game1Title.Parent = game1

-- Add more games as needed...

-- Tab switching functionality
homeTab.MouseButton1Click:Connect(function()
    homeContent.Visible = true
    gamesContent.Visible = false
    homeTab.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    gamesTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
end)

gamesTab.MouseButton1Click:Connect(function()
    homeContent.Visible = false
    gamesContent.Visible = true
    homeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    gamesTab.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    hubGui:Destroy()
end)

-- Initial state
homeTab.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
gamesTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
