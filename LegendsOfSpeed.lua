-- Vanegood Hub 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Основное окно хаба
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "VANEGOOD HUB"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Автофарм секция
local AutoFarmTitle = Instance.new("TextLabel")
AutoFarmTitle.Size = UDim2.new(1, 0, 0, 30)
AutoFarmTitle.Text = "АВТОФАРМ"
AutoFarmTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoFarmTitle.Font = Enum.Font.GothamBold
AutoFarmTitle.TextSize = 16
AutoFarmTitle.BackgroundTransparency = 1
AutoFarmTitle.TextXAlignment = Enum.TextXAlignment.Left
AutoFarmTitle.Parent = ContentFrame

-- Жесткий автофарм
local HardFarmButton = Instance.new("TextButton")
HardFarmButton.Size = UDim2.new(1, 0, 0, 30)
HardFarmButton.Position = UDim2.new(0, 0, 0, 35)
HardFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HardFarmButton.Text = "Жесткий автофарм"
HardFarmButton.TextColor3 = Color3.fromRGB(220, 220, 220)
HardFarmButton.Font = Enum.Font.Gotham
HardFarmButton.TextSize = 14
HardFarmButton.Parent = ContentFrame

local HardFarmCorner = Instance.new("UICorner")
HardFarmCorner.CornerRadius = UDim.new(0, 6)
HardFarmCorner.Parent = HardFarmButton

-- Средний автофарм
local MediumFarmButton = Instance.new("TextButton")
MediumFarmButton.Size = UDim2.new(1, 0, 0, 30)
MediumFarmButton.Position = UDim2.new(0, 0, 0, 70)
MediumFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MediumFarmButton.Text = "Средний автофарм"
MediumFarmButton.TextColor3 = Color3.fromRGB(220, 220, 220)
MediumFarmButton.Font = Enum.Font.Gotham
MediumFarmButton.TextSize = 14
MediumFarmButton.Parent = ContentFrame

local MediumFarmCorner = Instance.new("UICorner")
MediumFarmCorner.CornerRadius = UDim.new(0, 6)
MediumFarmCorner.Parent = MediumFarmButton

-- Питомцы секция
local PetsTitle = Instance.new("TextLabel")
PetsTitle.Size = UDim2.new(1, 0, 0, 30)
PetsTitle.Position = UDim2.new(0, 0, 0, 115)
PetsTitle.Text = "ПИТОМЦЫ"
PetsTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
PetsTitle.Font = Enum.Font.GothamBold
PetsTitle.TextSize = 16
PetsTitle.BackgroundTransparency = 1
PetsTitle.TextXAlignment = Enum.TextXAlignment.Left
PetsTitle.Parent = ContentFrame

-- Кнопка выбора питомца
local PetsDropdown = Instance.new("TextButton")
PetsDropdown.Size = UDim2.new(1, 0, 0, 30)
PetsDropdown.Position = UDim2.new(0, 0, 0, 150)
PetsDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
PetsDropdown.Text = "Выбрать питомца ▼"
PetsDropdown.TextColor3 = Color3.fromRGB(220, 220, 220)
PetsDropdown.Font = Enum.Font.Gotham
PetsDropdown.TextSize = 14
PetsDropdown.Parent = ContentFrame

local PetsDropdownCorner = Instance.new("UICorner")
PetsDropdownCorner.CornerRadius = UDim.new(0, 6)
PetsDropdownCorner.Parent = PetsDropdown

-- Список питомцев
local petsList = {
    "Golden Viking", 
    "Speedy Sensei", 
    "Swift Samurai", 
    "Soul Fusion Dog",
    "Hupersonic Pegasus", 
    "Dark Birdie", 
    "Eternal Nebula Dragon", 
    "Shadows Edge Kitty",
    "Utimate Overdrive Bunny"
}

local PetsListFrame = Instance.new("Frame")
PetsListFrame.Size = UDim2.new(1, 0, 0, 0)
PetsListFrame.Position = UDim2.new(0, 0, 0, 185)
PetsListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PetsListFrame.ClipsDescendants = true
PetsListFrame.Visible = false
PetsListFrame.Parent = ContentFrame

local PetsListCorner = Instance.new("UICorner")
PetsListCorner.CornerRadius = UDim.new(0, 6)
PetsListCorner.Parent = PetsListFrame

local PetsListLayout = Instance.new("UIListLayout")
PetsListLayout.Parent = PetsListFrame

-- Создаем кнопки для каждого питомца
for i, petName in ipairs(petsList) do
    local PetButton = Instance.new("TextButton")
    PetButton.Size = UDim2.new(1, 0, 0, 30)
    PetButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    PetButton.Text = petName
    PetButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    PetButton.Font = Enum.Font.Gotham
    PetButton.TextSize = 14
    PetButton.Parent = PetsListFrame
    
    local PetButtonCorner = Instance.new("UICorner")
    PetButtonCorner.CornerRadius = UDim.new(0, 6)
    PetButtonCorner.Parent = PetButton
    
    PetButton.MouseButton1Click:Connect(function()
        selectedPet = petName
        PetsDropdown.Text = "Выбрать питомца ▼"
        togglePetsList()
    end)
end

-- Функция для сворачивания/разворачивания списка питомцев
local function togglePetsList()
    if PetsListFrame.Visible then
        PetsListFrame.Visible = false
        PetsDropdown.Text = "Выбрать питомца ▼"
        TweenService:Create(PetsListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
    else
        PetsListFrame.Visible = true
        PetsDropdown.Text = "Выбрать питомца ▲"
        local height = math.min(#petsList * 35, 150)
        TweenService:Create(PetsListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, height)}):Play()
    end
end

PetsDropdown.MouseButton1Click:Connect(togglePetsList)

-- Автопокупка питомцев
local PetFarmToggle = Instance.new("Frame")
PetFarmToggle.Size = UDim2.new(1, 0, 0, 25)
PetFarmToggle.Position = UDim2.new(0, 0, 0, 190 + PetsListFrame.AbsoluteSize.Y)
PetFarmToggle.BackgroundTransparency = 1
PetFarmToggle.Parent = ContentFrame

local PetFarmLabel = Instance.new("TextLabel")
PetFarmLabel.Size = UDim2.new(0.7, 0, 1, 0)
PetFarmLabel.Text = "Автопокупка"
PetFarmLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
PetFarmLabel.Font = Enum.Font.Gotham
PetFarmLabel.TextSize = 14
PetFarmLabel.BackgroundTransparency = 1
PetFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
PetFarmLabel.Parent = PetFarmToggle

local PetFarmToggleFrame = Instance.new("Frame")
PetFarmToggleFrame.Name = "ToggleFrame"
PetFarmToggleFrame.Size = UDim2.new(0, 50, 0, 25)
PetFarmToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
PetFarmToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
PetFarmToggleFrame.Parent = PetFarmToggle

local PetFarmToggleCorner = Instance.new("UICorner")
PetFarmToggleCorner.CornerRadius = UDim.new(1, 0)
PetFarmToggleCorner.Parent = PetFarmToggleFrame

local PetFarmToggleButton = Instance.new("TextButton")
PetFarmToggleButton.Name = "ToggleButton"
PetFarmToggleButton.Size = UDim2.new(0, 21, 0, 21)
PetFarmToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
PetFarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
PetFarmToggleButton.Text = ""
PetFarmToggleButton.Parent = PetFarmToggleFrame

local PetFarmButtonCorner = Instance.new("UICorner")
PetFarmButtonCorner.CornerRadius = UDim.new(1, 0)
PetFarmButtonCorner.Parent = PetFarmToggleButton

-- Логика жесткого автофарма
local function startHardFarm()
    spawn(function()
        while true do
            pcall(function()
                -- Сбор орбов
                for i = 1, 50 do
                    local args = {[1] = "collectOrb", [2] = "Red Orb", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Blue Orb", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                end
                
                -- Сбор кристаллов
                for i = 1, 30 do
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Desert"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Magma City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                end
                
                -- Перерождение
                local args = {[1] = "rebirthRequest"}
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
                local args = {[1] = "rebirthRequest"}
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
            end)
            wait(0.1)
        end
    end)
end

-- Логика среднего автофарма
local function startMediumFarm()
    spawn(function()
        while true do
            pcall(function()
                -- Сбор орбов
                for i = 1, 20 do
                    local args = {[1] = "collectOrb", [2] = "Red Orb", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Blue Orb", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                end
                
                -- Сбор кристаллов
                for i = 1, 10 do
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Desert"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Magma City"}
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                end
                
                -- Перерождение
                local args = {[1] = "rebirthRequest"}
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
            end)
            wait(1)
        end
    end)
end

-- Логика автопокупки питомцев
local PetFarmEnabled = false

local function TogglePetFarm()
    PetFarmEnabled = not PetFarmEnabled
    if PetFarmEnabled then
        TweenService:Create(PetFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(PetFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while PetFarmEnabled and task.wait(0.5) do
                pcall(function()
                    local cPetShopFolder = ReplicatedStorage:WaitForChild("cPetShopFolder")
                    local cPetShopRemote = ReplicatedStorage:WaitForChild("cPetShopRemote")
                    
                    local petToOpen = cPetShopFolder:FindFirstChild(selectedPet)
                    if petToOpen then
                        cPetShopRemote:InvokeServer(petToOpen)
                    end
                end)
            end
        end)
    else
        TweenService:Create(PetFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(PetFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

PetFarmToggleButton.MouseButton1Click:Connect(TogglePetFarm)

-- Обработчики кнопок
HardFarmButton.MouseButton1Click:Connect(startHardFarm)
MediumFarmButton.MouseButton1Click:Connect(startMediumFarm)

-- Функция минимизации
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 300, 0, 30)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 350)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Функция закрытия
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Анти-афк
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
