-- [[ vanegood - Icon Systems Showcase ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 1. Создание базового экрана
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "vanegood_IconTest"
ScreenGui.ResetOnSpawn = false
local parentTarget = (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui")) or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Parent = parentTarget

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 360, 0, 260)
Frame.Position = UDim2.new(0.5, -180, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(45, 45, 55)
Stroke.Thickness = 1
Stroke.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Text = "vanegood // Icon Tests"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Position = UDim2.new(0, 16, 0, 12)
Title.Size = UDim2.new(1, -32, 0, 20)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Frame

local Container = Instance.new("Frame")
Container.Position = UDim2.new(0, 16, 0, 42)
Container.Size = UDim2.new(1, -32, 1, -54)
Container.BackgroundTransparency = 1
Container.Parent = Frame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.Parent = Container

-- Хелпер для создания строки в меню
local function CreateRow(titleText)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 48)
    Row.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Row.Parent = Container

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 6)
    RowCorner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Text = titleText
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(200, 200, 210)
    Label.Position = UDim2.new(0, 48, 0, 0)
    Label.Size = UDim2.new(1, -52, 1, 0)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Row

    return Row
end

-- =========================================================
-- ВАРИАНТ 1: Кастомная внешняя иконка (Web / getcustomasset)
-- =========================================================
local function GetCustomIcon(name, url)
    local folder = "vanegood_assets"
    local path = folder .. "/" .. name .. ".png"
    
    -- Проверяем наличие функций эксплойта
    if writefile and readfile and isfile and getcustomasset then
        if not isfolder or not isfolder(folder) then
            if makefolder then makefolder(folder) end
        end
        if not isfile(path) then
            local success, data = pcall(function() return game:HttpGet(url) end)
            if success then
                writefile(path, data)
            end
        end
        return getcustomasset(path)
    end
    -- Фоллбек, если среда исполнения не поддерживает getcustomasset
    return "rbxassetid://10723415903" 
end

local Row1 = CreateRow("1. Внешний URL / getcustomasset (Lucide)")
local Icon1 = Instance.new("ImageLabel")
Icon1.Size = UDim2.new(0, 24, 0, 24)
Icon1.Position = UDim2.new(0, 12, 0.5, -12)
Icon1.BackgroundTransparency = 1
-- Пример ссылки на открытый PNG ассет Lucide (Sword/Shield/Home и т.д.)
Icon1.Image = GetCustomIcon("shield", "https://raw.githubusercontent.com/lucide-icons/lucide/main/icons/shield.png")
Icon1.ImageColor3 = Color3.fromRGB(0, 170, 255)
Icon1.Parent = Row1

-- =========================================================
-- ВАРИАНТ 2: Спрайтшит (Нарезка по сетке через ImageRect)
-- =========================================================
-- Сетка иконок: берем координаты конкретной иконки из общего полотна
local SpritesheetGrid = {
    Size = Vector2.new(36, 36),
    Icons = {
        ["cursor"] = Vector2.new(0, 0),
        ["crosshair"] = Vector2.new(36, 0),
        ["flame"] = Vector2.new(72, 0)
    }
}

local Row2 = CreateRow("2. Спрайтшит (Spritesheet Coordinates)")
local Icon2 = Instance.new("ImageLabel")
Icon2.Size = UDim2.new(0, 24, 0, 24)
Icon2.Position = UDim2.new(0, 12, 0.5, -12)
Icon2.BackgroundTransparency = 1
-- Используем готовое полотно со спрайтами
Icon2.Image = "rbxassetid://6031075931" 
Icon2.ImageRectSize = SpritesheetGrid.Size
Icon2.ImageRectOffset = SpritesheetGrid.Icons["crosshair"]
Icon2.ImageColor3 = Color3.fromRGB(255, 180, 50)
Icon2.Parent = Row2

-- =========================================================
-- ВАРИАНТ 3: Юникод / Символы (Без текстур и загрузок)
-- =========================================================
local Row3 = CreateRow("3. Юникод / Символы (Zero Download)")
local Icon3 = Instance.new("TextLabel")
Icon3.Size = UDim2.new(0, 24, 0, 24)
Icon3.Position = UDim2.new(0, 12, 0.5, -12)
Icon3.BackgroundTransparency = 1
Icon3.Text = "⚡" -- Любой спецсимвол: ⚙, ⚡, 🛡, 🎯, ✦, ≡
Icon3.TextSize = 18
Icon3.Font = Enum.Font.GothamBold
Icon3.TextColor3 = Color3.fromRGB(255, 80, 80)
Icon3.Parent = Row3
