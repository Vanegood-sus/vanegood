local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local parentObj = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")

if parentObj:FindFirstChild("vanegood_UI") then
    parentObj.vanegood_UI:Destroy()
end

-- База иконок (Lucide / Fluent Style)
local Icons = {
    ["menu"] = "rbxassetid://10723407389",
    ["home"] = "rbxassetid://10723407389",
    ["settings"] = "rbxassetid://10734975486",
    ["gear"] = "rbxassetid://10734975486",
    ["visuals"] = "rbxassetid://10723415174",
    ["player"] = "rbxassetid://10747373176",
    ["combat"] = "rbxassetid://10734950309",
    ["misc"] = "rbxassetid://10734976528"
}

local function ResolveIcon(icon)
    if not icon then return "" end
    local lower = string.lower(icon)
    if Icons[lower] then return Icons[lower] end
    if string.find(icon, "rbxassetid://") then return icon end
    if tonumber(icon) then return "rbxassetid://" .. icon end
    return "rbxassetid://10723407389"
end

-- Библиотека vanegood
local Library = {}

function Library:CreateWindow(config)
    config = config or {}
    local TitleText = config.Name or "vanegood"

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vanegood_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = parentObj

    -- Внешняя рамка с неоном
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

    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(45, 48, 55)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(20, 20, 25)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(45, 48, 55))
    })
    MainGradient.Rotation = 0
    MainGradient.Parent = OutlineFrame

    local rotSpeed = 90
    RunService.RenderStepped:Connect(function(dt)
        MainGradient.Rotation = (MainGradient.Rotation + (rotSpeed * dt)) % 360
    end)

    -- Внутренний контейнер
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

    -- Шапка
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, 42)
    Topbar.BackgroundTransparency = 1
    Topbar.ZIndex = 5
    Topbar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 16, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = TitleText
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 6
    Title.Parent = Topbar

    local TopbarDivider = Instance.new("Frame")
    TopbarDivider.Size = UDim2.new(1, 0, 0, 1)
    TopbarDivider.Position = UDim2.new(0, 0, 1, -1)
    TopbarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    TopbarDivider.BorderSizePixel = 0
    TopbarDivider.Parent = Topbar

    -- Боковая панель
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 160, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.CanvasPosition = Vector2.new(0, 0)
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Sidebar.ZIndex = 3
    Sidebar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 6)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.Parent = Sidebar

    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.PaddingLeft = UDim.new(0, 8)
    SidebarPadding.PaddingRight = UDim.new(0, 8)
    SidebarPadding.PaddingBottom = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar

    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.Position = UDim2.new(1, -1, 0, 0)
    SidebarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.ZIndex = 4
    SidebarDivider.Parent = Sidebar

    -- Контейнер контента
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -160, 1, -42)
    ContentContainer.Position = UDim2.new(0, 160, 0, 42)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 3
    ContentContainer.Parent = MainFrame

    -- Перетаскивание
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

    local Window = {}
    local Tabs = {}
    local activeTab = nil
    local tabCount = 0

    function Window:CreateTab(tabConfig)
        tabCount = tabCount + 1
        local currentOrder = tabCount
        local TabName = tabConfig.Name or "Tab"
        local TabIcon = tabConfig.Icon or "menu"

        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName .. "_TabBtn"
        TabButton.LayoutOrder = currentOrder
        TabButton.Size = UDim2.new(1, 0, 0, 34)
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
        TabButton.AutoButtonColor = false
        TabButton.Text = ""
        TabButton.ZIndex = 4
        TabButton.Parent = Sidebar

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton

        -- Иконка вкладки
        local IconImg = Instance.new("ImageLabel")
        IconImg.Name = "Icon"
        IconImg.Size = UDim2.new(0, 16, 0, 16)
        IconImg.Position = UDim2.new(0, 10, 0.5, -8)
        IconImg.BackgroundTransparency = 1
        IconImg.Image = ResolveIcon(TabIcon)
        IconImg.ImageColor3 = Color3.fromRGB(140, 140, 155)
        IconImg.ZIndex = 5
        IconImg.Parent = TabButton

        -- Текст вкладки
        local TitleLbl = Instance.new("TextLabel")
        TitleLbl.Name = "Label"
        TitleLbl.Size = UDim2.new(1, -38, 1, 0)
        TitleLbl.Position = UDim2.new(0, 34, 0, 0)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Font = Enum.Font.GothamMedium
        TitleLbl.Text = TabName
        TitleLbl.TextColor3 = Color3.fromRGB(140, 140, 155)
        TitleLbl.TextSize = 13
        TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        TitleLbl.ZIndex = 5
        TitleLbl.Parent = TabButton

        -- Неоновая полоска снизу выбранной вкладки
        local BottomGlow = Instance.new("Frame")
        BottomGlow.Name = "BottomGlow"
        BottomGlow.Size = UDim2.new(0.85, 0, 0, 2)
        BottomGlow.Position = UDim2.new(0.5, 0, 1, -2)
        BottomGlow.AnchorPoint = Vector2.new(0.5, 0)
        BottomGlow.BorderSizePixel = 0
        BottomGlow.BackgroundTransparency = 1
        BottomGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BottomGlow.ZIndex = 6
        BottomGlow.Parent = TabButton

        local GlowCorner = Instance.new("UICorner")
        GlowCorner.CornerRadius = UDim.new(1, 0)
        GlowCorner.Parent = BottomGlow

        local GlowGradient = Instance.new("UIGradient")
        GlowGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(130, 135, 145)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(130, 135, 145))
        })
        GlowGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0.0, 0.6),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1.0, 0.6)
        })
        GlowGradient.Parent = BottomGlow

        -- Страница содержимого
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = TabName .. "_Page"
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 85)
        TabPage.CanvasPosition = Vector2.new(0, 0)
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabPage.Visible = false
        TabPage.ZIndex = 4
        TabPage.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Parent = TabPage

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 12)
        PagePadding.PaddingLeft = UDim.new(0, 12)
        PagePadding.PaddingRight = UDim.new(0, 12)
        PagePadding.PaddingBottom = UDim.new(0, 12)
        PagePadding.Parent = TabPage

        local function SetActive(state)
            if state then
                TweenService:Create(TabButton, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(28, 31, 39)
                }):Play()
                TweenService:Create(TitleLbl, TweenInfo.new(0.25), {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                TweenService:Create(IconImg, TweenInfo.new(0.25), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                TweenService:Create(BottomGlow, TweenInfo.new(0.25), {
                    BackgroundTransparency = 0
                }):Play()
                TabPage.Visible = true
            else
                TweenService:Create(TabButton, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(20, 22, 28)
                }):Play()
                TweenService:Create(TitleLbl, TweenInfo.new(0.25), {
                    TextColor3 = Color3.fromRGB(140, 140, 155)
                }):Play()
                TweenService:Create(IconImg, TweenInfo.new(0.25), {
                    ImageColor3 = Color3.fromRGB(140, 140, 155)
                }):Play()
                TweenService:Create(BottomGlow, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1
                }):Play()
                TabPage.Visible = false
            end
        end

        TabButton.MouseButton1Click:Connect(function()
            if activeTab == TabName then return end
            for _, data in pairs(Tabs) do
                data.SetActive(false)
            end
            activeTab = TabName
            SetActive(true)
        end)

        Tabs[TabName] = {
            Button = TabButton,
            Page = TabPage,
            SetActive = SetActive
        }

        if activeTab == nil then
            activeTab = TabName
            SetActive(true)
        end

        local Elements = {}
        Elements.Page = TabPage
        return Elements
    end

    return Window
end

-- Инициализация окна и создание вкладок
local Window = Library:CreateWindow({
    Name = "vanegood"
})

local MainTab = Window:CreateTab({
    Name = "Меню",
    Icon = "menu"
})

local SettingsTab = Window:CreateTab({
    Name = "Настройки",
    Icon = "settings"
})
