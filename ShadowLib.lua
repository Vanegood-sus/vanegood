-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Parent Resolver
local parentObj = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")

-- Clean up old instance
if parentObj:FindFirstChild("vanegood_UI") then
    parentObj.vanegood_UI:Destroy()
end

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "vanegood_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentObj

-- Outline Holder (Glow Border)
local OutlineFrame = Instance.new("Frame")
OutlineFrame.Name = "OutlineFrame"
OutlineFrame.Size = UDim2.new(0, 620, 0, 420)
OutlineFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
OutlineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OutlineFrame.BorderSizePixel = 0
OutlineFrame.Parent = ScreenGui

local OutlineCorner = Instance.new("UICorner")
OutlineCorner.CornerRadius = UDim.new(0, 14)
OutlineCorner.Parent = OutlineFrame

-- Rotating Neon Gradient (Dark Neon Grey & Neon White)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(45, 48, 55)),    -- темный неоновый серый
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(20, 20, 25)),    -- фоновый переход
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),  -- яркий белый неон
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(45, 48, 55))
})
UIGradient.Rotation = 0
UIGradient.Parent = OutlineFrame

-- Neon Border Rotation Loop
local rotSpeed = 90 -- градусов в секунду
RunService.RenderStepped:Connect(function(dt)
    UIGradient.Rotation = (UIGradient.Rotation + (rotSpeed * dt)) % 360
end)

-- Main Background Frame (Fluent / Rayfield Hybrid Style)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -4, 1, -4)
MainFrame.Position = UDim2.new(0, 2, 0, 2)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = OutlineFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 42)
Topbar.BackgroundTransparency = 1
Topbar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "vanegood"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

local TopbarDivider = Instance.new("Frame")
TopbarDivider.Size = UDim2.new(1, 0, 0, 1)
TopbarDivider.Position = UDim2.new(0, 0, 1, -1)
TopbarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
TopbarDivider.BorderSizePixel = 0
TopbarDivider.Parent = Topbar

-- Sidebar (Tabs Selection)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 10)
SidebarPadding.PaddingRight = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

local SidebarDivider = Instance.new("Frame")
SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
SidebarDivider.Position = UDim2.new(1, -1, 0, 0)
SidebarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
SidebarDivider.BorderSizePixel = 0
SidebarDivider.Parent = Sidebar

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -150, 1, -42)
ContentContainer.Position = UDim2.new(0, 150, 0, 42)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Tab System Logic
local Tabs = {}
local activeTab = nil

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "_TabBtn"
    TabButton.Size = UDim2.new(1, 0, 0, 34)
    TabButton.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    TabButton.AutoButtonColor = false
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.Text = "  " .. name
    TabButton.TextColor3 = Color3.fromRGB(160, 160, 175)
    TabButton.TextSize = 13
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = Sidebar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton

    local TabStroke = Instance.new("UIStroke")
    TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    TabStroke.Color = Color3.fromRGB(255, 255, 255)
    TabStroke.Thickness = 1.2
    TabStroke.Transparency = 1 -- выключен по умолчанию
    TabStroke.Parent = TabButton

    -- Container for elements inside the tab
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = name .. "_Page"
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 2
    TabPage.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
    TabPage.Visible = false
    TabPage.Parent = ContentContainer

    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingTop = UDim.new(0, 12)
    PagePadding.PaddingLeft = UDim.new(0, 12)
    PagePadding.PaddingRight = UDim.new(0, 12)
    PagePadding.Parent = TabPage

    local function SetActive(state)
        if state then
            TweenService:Create(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 34, 42),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TweenService:Create(TabStroke, TweenInfo.new(0.2), {
                Transparency = 0.2 -- Неоновая обводка активной вкладки
            }):Play()
            TabPage.Visible = true
        else
            TweenService:Create(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(22, 24, 30),
                TextColor3 = Color3.fromRGB(160, 160, 175)
            }):Play()
            TweenService:Create(TabStroke, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play()
            TabPage.Visible = false
        end
    end

    TabButton.MouseButton1Click:Connect(function()
        if activeTab == name then return end
        for tabName, tabData in pairs(Tabs) do
            tabData.SetActive(false)
        end
        activeTab = name
        SetActive(true)
    end)

    Tabs[name] = {
        Button = TabButton,
        Page = TabPage,
        SetActive = SetActive
    }

    -- Set first created tab as active
    if activeTab == nil then
        activeTab = name
        SetActive(true)
    end

    return TabPage
end

-- Dragging Functionality
local dragging, dragInput, dragStart, startPos

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OutlineFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        OutlineFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Демо-вкладки для проверки
CreateTab("Main")
CreateTab("Settings")
CreateTab("Visuals")
