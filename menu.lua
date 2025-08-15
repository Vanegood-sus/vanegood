local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Кнопка с иконкой (для открытия/закрытия)
local TinyImageGui = Instance.new("ScreenGui")
TinyImageGui.Name = "TinyDraggableImage"
TinyImageGui.Parent = CoreGui
TinyImageGui.ResetOnSpawn = false

local imageSize = 75
local imageFrame = Instance.new("Frame")
imageFrame.Name = "TinyRoundedImage"
imageFrame.Size = UDim2.new(0, imageSize, 0, imageSize)
imageFrame.Position = UDim2.new(0, 20, 0, 20)
imageFrame.BackgroundTransparency = 1
imageFrame.ClipsDescendants = true
imageFrame.Parent = TinyImageGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.25, 0)
uiCorner.Parent = imageFrame

local image = Instance.new("ImageLabel")
image.Name = "Image"
image.Image = "rbxassetid://111084287166716" -- твоя иконка
image.Size = UDim2.new(1, 0, 1, 0)
image.BackgroundTransparency = 1
image.BorderSizePixel = 0
image.Parent = imageFrame

-- Перетаскивание иконки
local touchStartPos, frameStartPos
local isDragging = false

imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        touchStartPos = input.Position
        frameStartPos = imageFrame.Position
    end
end)

imageFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - touchStartPos
        imageFrame.Position = UDim2.new(
            frameStartPos.X.Scale,
            frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale,
            frameStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 2, 1, 2)
Border.Position = UDim2.new(0, -1, 0, -1)
Border.BackgroundTransparency = 1
Border.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 165, 50)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = Border

-- Верхняя Панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

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

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -50)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.CanvasSize = UDim2.new(0,0,7,0)
ContentFrame.Parent = MainFrame
ContentFrame.ScrollBarThickness = 5

-- UI List Layout для удобного размещения элементов
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ContentFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Минимизация
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 30)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        ContentFrame.Visible = true
        MinimizeButton.Text = "—"
    end
end)

-- Закрытие с подтверждением
CloseButton.MouseButton1Click:Connect(function()
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Size = UDim2.new(0, 250, 0, 120)
    MessageFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MessageFrame.Parent = ScreenGui

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 0, 60)
    MessageLabel.Position = UDim2.new(0, 10, 0, 10)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = "Закрыть Vanegood Hub?"
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Font = Enum.Font.GothamBold
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = MessageFrame

    local YesButton = Instance.new("TextButton")
    YesButton.Size = UDim2.new(0, 100, 0, 30)
    YesButton.Position = UDim2.new(0.5, -105, 1, -40)
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
    YesButton.Text = "Да"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.GothamBold
    YesButton.TextSize = 14
    YesButton.Parent = MessageFrame

    local NoButton = Instance.new("TextButton")
    NoButton.Size = UDim2.new(0, 100, 0, 30)
    NoButton.Position = UDim2.new(0.5, 5, 1, -40)
    NoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    NoButton.Text = "Нет"
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.GothamBold
    NoButton.TextSize = 14
    NoButton.Parent = MessageFrame

    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        TinyImageGui:Destroy()
    end)

    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end)

-- Функция для кнопки с картинкой (открыть/закрыть хаб)
local hubVisible = true
imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubVisible = not hubVisible
        ScreenGui.Enabled = hubVisible
        
        -- Анимация
        if hubVisible then
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
        else
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
        end
    end
end)

-- helper function to create switches/buttons easier
local function createLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = ContentFrame
    return label
end

local function createSwitch(text, callback, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = ContentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0.6, 0)
    toggle.Position = UDim2.new(0.75, 0, 0.2, 0)
    toggle.BackgroundColor3 = default and Color3.fromRGB(255, 165, 50) or Color3.fromRGB(80, 80, 90)
    toggle.Text = default and "Вкл" or "Выкл"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 14
    toggle.Parent = frame

    local enabled = default

    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            toggle.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
            toggle.Text = "Вкл"
        else
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
            toggle.Text = "Выкл"
        end
        callback(enabled)
    end)

    return toggle
end

-- === Функции хуков ===
-- (анти-АФК и прочее, смотри ниже, полностью как ты присылал)

local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-АФК активирован")
    end)
end

setupAntiAFK() -- сразу включаем

local autoWinBrawl = false
local autoJoinBrawl = false

local whitelist = {} -- добавляй айдишники если хочешь

local function equipPunch()
    if not autoWinBrawl then return end
    local character = player.Character
    if not character then return false end
    if character:FindFirstChild("Punch") then return true end
    local backpack = player.Backpack
    if not backpack then return false end
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == "Punch" then
            tool.Parent = character
            return true
        end
    end
    return false
end

local function isValidTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then return false end
    if targetPlayer == player then return false end
    if whitelist[targetPlayer.UserId] then return false end
    local char = targetPlayer.Character
    if not char or not char.Parent then return false end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart or not rootPart.Parent then return false end
    return true
end

local function isLocalPlayerReady()
    local char = player.Character
    if not char or not char.Parent then return false end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local leftHand = char:FindFirstChild("LeftHand")
    local rightHand = char:FindFirstChild("RightHand")
    return (leftHand ~= nil or rightHand ~= nil)
end

local function safeTouchInterest(targetPart, localPart)
    if not targetPart or not targetPart.Parent then return false end
    if not localPart or not localPart.Parent then return false end
    local success, err = pcall(function()
        firetouchinterest(targetPart, localPart, 0)
        task.wait(0.01)
        firetouchinterest(targetPart, localPart, 1)
    end)
    return success
end

local autobrawlLoops = {}

local function startAutoWinBrawl()
    autobrawlLoops.joinLoop = task.spawn(function()
        while autoWinBrawl do
            if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                pcall(function()
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end)
            end
            task.wait(0.5)
        end
    end)
    autobrawlLoops.equipLoop = task.spawn(function()
        while autoWinBrawl do
            equipPunch()
            task.wait(0.5)
        end
    end)
    autobrawlLoops.punchLoop = task.spawn(function()
        while autoWinBrawl do
            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
            end
            task.wait(0.1)
        end
    end)
    autobrawlLoops.killLoop = task.spawn(function()
        while autoWinBrawl do
            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                local char = player.Character
                local leftHand = char and char:FindFirstChild("LeftHand")
                local rightHand = char and char:FindFirstChild("RightHand")
                for _, plr in pairs(Players:GetPlayers()) do
                    if not autoWinBrawl then break end
                    pcall(function()
                        if isValidTarget(plr) then
                            local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            if root then
                                if leftHand then safeTouchInterest(root, leftHand) end
                                if rightHand then safeTouchInterest(root, rightHand) end
                            end
                        end
                    end)
                    task.wait(0.01)
                end
            end
            task.wait(0.05)
        end
    end)
end

local function stopAutoWinBrawl()
    for _, v in pairs(autobrawlLoops) do
        if v and v.Disconnect then pcall(v.Disconnect, v) end
    end
    autobrawlLoops = {}
end

local autoJoinLoop
local function startAutoJoinBrawl()
    if autoJoinLoop then autoJoinLoop:Disconnect() end
    autoJoinLoop = RunService.Heartbeat:Connect(function()
        if autoJoinBrawl and player and player.PlayerGui and player.PlayerGui.gameGui then
            if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                pcall(function()
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end)
            end
        end
    end)
end

local function stopAutoJoinBrawl()
    if autoJoinLoop then
        autoJoinLoop:Disconnect()
        autoJoinLoop = nil
    end
end

local antiKnockbackActive = false
local bodyVelocityInstance

local function setAntiKnockback(enable)
    local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    if enable then
        if bodyVelocityInstance and bodyVelocityInstance.Parent then bodyVelocityInstance:Destroy() end
        bodyVelocityInstance = Instance.new("BodyVelocity")
        bodyVelocityInstance.MaxForce = Vector3.new(100000, 0, 100000)
        bodyVelocityInstance.Velocity = Vector3.new(0, 0, 0)
        bodyVelocityInstance.P = 1250
        bodyVelocityInstance.Parent = rootPart
        antiKnockbackActive = true
    else
        if bodyVelocityInstance and bodyVelocityInstance.Parent then
            bodyVelocityInstance:Destroy()
        end
        antiKnockbackActive = false
    end
end

local positionLockConnection = nil

local function lockPlayerPosition(position)
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
    positionLockConnection = RunService.Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = position
        end
    end)
end

local function unlockPlayerPosition()
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
end

local function setHideIndicators(enable)
    local repStorage = game:GetService("ReplicatedStorage")
    for _, obj in pairs(repStorage:GetChildren()) do
        if obj.Name:find("Frame$") and typeof(obj.Visible) == "boolean" then
            obj.Visible = not enable
        end
    end
end

local speedGrindActive = false
local speedGrindTasks = {}

local function unequipAllPets()
    -- Сделай по необходимости
end

local function equipUniquePet(name)
    -- Сделай по необходимости
end

local function setSpeedGrind(enable)
    if enable then
        speedGrindActive = true
        equipUniquePet("Swift Samurai")
        for i=1,14 do
            speedGrindTasks[i] = task.spawn(function()
                while speedGrindActive do
                    pcall(function()
                        player.muscleEvent:FireServer("rep")
                    end)
                    task.wait()
                end
            end)
        end
    else
        speedGrindActive = false
        unequipAllPets()
        for _, t in pairs(speedGrindTasks) do
            if t then task.cancel(t) end
        end
        speedGrindTasks = {}
    end
end

-- === Создаем переключатели меню ===

createLabel("Добро Пожаловать!")

createSwitch("Анти-АФК", function(value)
    if value then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
    end
end, true)

createLabel("Авто бой:")

createSwitch("Авто выйгрыш", function(value)
    autoWinBrawl = value
    if value then
        startAutoWinBrawl()
    else
        stopAutoWinBrawl()
    end
end, false)

createSwitch("Автоматически вступать в бой", function(value)
    autoJoinBrawl = value
    if value then
        startAutoJoinBrawl()
    else
        stopAutoJoinBrawl()
    end
end, false)

createLabel("Остальное:")

createSwitch("Анти отбрасывание", function(value)
    setAntiKnockback(value)
end, false)

createSwitch("Стоять на месте", function(value)
    if value then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            lockPlayerPosition(player.Character.HumanoidRootPart.CFrame)
        end
    else
        unlockPlayerPosition()
    end
end, false)

createSwitch("Скрывать UI метки", function(value)
    setHideIndicators(value)
end, false)

createSwitch("Быстрая сила", function(value)
    setSpeedGrind(value)
end, false)

-- ========== Вот тут начинается вкладка Фарм и статистика ===========

local window = {
    AddTab = function(_, name)
        local tab = {AddFolder = function(_, folderName)
            local folder = {}
            
            function folder:AddSwitch(name, callback)
                -- создаём переключатель (условно)
                -- В реале здесь код создания переключателя, который добавит элементы в ContentFrame
                -- Чтобы не дублировать, мы, например, можем просто возвращать объект-заглушку.
                return {}
            end
            
            function folder:AddTextBox(name, callback)
                -- Аналогично для текстбокса
                return {}
            end
            
            function folder:AddButton(name, callback)
                return {}
            end
            
            return folder
        end}
        return tab
    end
}

-- Здесь создаём вкладку Фарм
local farmPlusTab = window:AddTab("Фарм")

-- ================ ВАШ ДАЛЬНЕЙШИЙ КОД c папками и свитчами =================

local autoRockFolder = farmPlusTab:AddFolder("Бить камень")

function gettool()
    for i, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Punch" and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(v)
        end
    end
    player.muscleEvent:FireServer("punch", "leftHand")
    player.muscleEvent:FireServer("punch", "rightHand")
end

local function createAutoFarmSwitch(name, durabilityNeeded, rockName)
    autoRockFolder:AddSwitch(name, function(value)
        selectrock = rockName
        getgenv().autoFarm = value

        task.spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if not getgenv().autoFarm then break end

                local plr = player
                if plr.Durability.Value >= durabilityNeeded then
                    for _, v in pairs(game.Workspace.machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == durabilityNeeded and plr.Character:FindFirstChild("LeftHand") and plr.Character:FindFirstChild("RightHand") then
                            firetouchinterest(v.Parent.Rock, plr.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, plr.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, plr.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, plr.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end)
end

createAutoFarmSwitch("Маленький камень - 0", 0, "Tiny Island Rock")
createAutoFarmSwitch("Средний камень - 100", 100, "Starter Island Rock")
createAutoFarmSwitch("Золотой камень - 5000", 5000, "Legend Beach Rock")
createAutoFarmSwitch("Ледяной камень - 150000", 150000, "Frost Gym Rock")
createAutoFarmSwitch("Мифический камень - 400000", 400000, "Mythical Gym Rock")
createAutoFarmSwitch("Адский камень - 750000", 750000, "Eternal Gym Rock")
createAutoFarmSwitch("Легендарный камень - 1000000", 1000000, "Legend Gym Rock")
createAutoFarmSwitch("Королевский камень - 5000000", 5000000, "Muscle King Gym Rock")
createAutoFarmSwitch("Камень в Джунглях 10000000", 10000000, "Ancient Jungle Rock")

local rebirthsFolder = farmPlusTab:AddFolder("Перерождения")

local targetRebirthValue = 0
local targetSwitch, infiniteSwitch

rebirthsFolder:AddTextBox("Сколько нужно?", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет " .. targetRebirthValue .. " перерождений",
            Duration = 3
        })
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Всё",
            Text = "Остановил как и обещал",
            Duration = 3
        })
    end
end)

targetSwitch = rebirthsFolder:AddSwitch("Начать перерождется по твоему количеству", function(bool)
    _G.targetRebirthActive = bool

    if bool then
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end

        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = player.leaderstats.Rebirths.Value

                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Ооо",
                        Text = "Пошло дело пошло",
                        Duration = 5
                    })
                    break
                end

                game.ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

infiniteSwitch = rebirthsFolder:AddSwitch("Перерождатся бесконечно", function(bool)
    _G.infiniteRebirthActive = bool

    if bool then
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end

        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game.ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

rebirthsFolder:AddSwitch("Всегда рост 1", function(bool)
    _G.autoSizeActive = bool

    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)
    end
end)

rebirthsFolder:AddSwitch("Телепортироватся в короля", function(bool)
    _G.teleportActive = bool

    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if player.Character then
                    player.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end)

local autoEquipToolsFolder = farmPlusTab:AddFolder("Автоматически качатся")

autoEquipToolsFolder:AddButton("Автолифт", function()
    local gamepassFolder = game.ReplicatedStorage.gamepassIds
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
end)

local function autoEquipTool(toolName, toggleValue)
    _G["Auto"..toolName] = toggleValue
    
    if toggleValue then
        local tool = player.Backpack:FindFirstChild(toolName)
        if tool then
            player.Character.Humanoid:EquipTool(tool)
        end
    else
        local equipped = player.Character:FindFirstChild(toolName)
        if equipped then
            equipped.Parent = player.Backpack
        end
    end
    
    task.spawn(function()
        while _G["Auto"..toolName] do
            if not _G["Auto"..toolName] then break end
            player.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end

autoEquipToolsFolder:AddSwitch("Авто гантеля", function(value)
    autoEquipTool("Weight", value)
end)

autoEquipToolsFolder:AddSwitch("Авто отжимания", function(value)
    autoEquipTool("Pushups", value)
end)

autoEquipToolsFolder:AddSwitch("Авто отжимания стоя на руках", function(value)
    autoEquipTool("Handstands", value)
end)

autoEquipToolsFolder:AddSwitch("Авто пресс", function(value)
    autoEquipTool("Situps", value)
end)

autoEquipToolsFolder:AddSwitch("Авто удары", function(Value)
    _G.fastHitActive = Value

    if Value then
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end

                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)

        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end

                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")

                local punchTool = player.Character and player.Character:FindFirstChild("Punch")
                if punchTool then
                    punchTool:Activate()
                end
                task.wait(0)
            end
        end)
    else
        local equipped = player.Character and player.Character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = player.Backpack
        end
    end
end)

autoEquipToolsFolder:AddSwitch("Быстрые предметы", function(Value)
    _G.FastTools = Value

    local defaultSpeeds = {
        {"Punch", "attackTime", Value and 0 or 0.35},
        {"Ground Slam", "attackTime", Value and 0 or 6},
        {"Stomp", "attackTime", Value and 0 or 7},
        {"Handstands", "repTime", Value and 0 or 2},
        {"Situps", "repTime", Value and 0 or 2.5},
        {"Pushups", "repTime", Value and 0 or 2.5},
        {"Weight", "repTime", Value and 0 or 3}
    }

    for _, toolData in pairs(defaultSpeeds) do
        local toolName, property, speed = unpack(toolData)

        local backpackTool = player.Backpack:FindFirstChild(toolName)
        if backpackTool and backpackTool:FindFirstChild(property) then
            backpackTool[property].Value = speed
        end

        local equippedTool = player.Character and player.Character:FindFirstChild(toolName)
        if equippedTool and equippedTool:FindFirstChild(property) then
            equippedTool[property].Value = speed
        end
    end
end)

autoEquipToolsFolder:AddSwitch("Анти лаг", function(Value)
    _G.AntiLag = Value

    if Value then
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 9e9

        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end
    end
end)

local sessionStartTime = os.time()
local sessionStartStrength = 0
local sessionStartDurability = 0
local sessionStartKills = 0
local sessionStartRebirths = 0
local sessionStartBrawls = 0
local hasStartedTracking = false

local statsFolder = farmPlusTab:AddFolder("Статистика")

statsFolder:AddLabel("Сила")
local strengthStatsLabel = statsFolder:AddLabel("Статы...")
local strengthGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Долговечность")
local durabilityStatsLabel = statsFolder:AddLabel("Статы...")
local durabilityGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Перерождения")
local rebirthsStatsLabel = statsFolder:AddLabel("Статы...")
local rebirthsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Убийства")
local killsStatsLabel = statsFolder:AddLabel("Статы...")
local killsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Поединки")
local brawlsStatsLabel = statsFolder:AddLabel("Статы...")
local brawlsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Время")
local sessionTimeLabel = statsFolder:AddLabel("Время: 00:00:00")

local function formatNumber(number)
    if number >= 1e15 then return string.format("%.2fQ", number/1e15)
    elseif number >= 1e12 then return string.format("%.2fT", number/1e12)
    elseif number >= 1e9 then return string.format("%.2fB", number/1e9)
    elseif number >= 1e6 then return string.format("%.2fM", number/1e6)
    elseif number >= 1e3 then return string.format("%.2fK", number/1e3)
    end
    return tostring(math.floor(number))
end

local function formatNumberWithCommas(number)
    local formatted = tostring(math.floor(number))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    if days > 0 then
        return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
end

local function startTracking()
    if not hasStartedTracking then
        local plr = player
        sessionStartStrength = plr.leaderstats.Strength.Value
        sessionStartDurability = plr.Durability.Value
        sessionStartKills = plr.leaderstats.Kills.Value
        sessionStartRebirths = plr.leaderstats.Rebirths.Value
        sessionStartBrawls = plr.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end
end

function updateStats()
    local plr = player
    if not hasStartedTracking then startTracking() end
    
    local currentStrength = plr.leaderstats.Strength.Value
    local currentDurability = plr.Durability.Value
    local currentKills = plr.leaderstats.Kills.Value
    local currentRebirths = plr.leaderstats.Rebirths.Value
    local currentBrawls = plr.leaderstats.Brawls.Value
    
    local strengthGain = currentStrength - sessionStartStrength
    local durabilityGain = currentDurability - sessionStartDurability
    local killsGain = currentKills - sessionStartKills
    local rebirthsGain = currentRebirths - sessionStartRebirths
    local brawlsGain = currentBrawls - sessionStartBrawls
    
    strengthStatsLabel.Text = string.format("Actual: %s", formatNumber(currentStrength))
    durabilityStatsLabel.Text = string.format("Actual: %s", formatNumber(currentDurability))
    rebirthsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentRebirths))
    killsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentKills))
    brawlsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentBrawls))
    
    strengthGainLabel.Text = string.format("Gained: %s", formatNumber(strengthGain))
    durabilityGainLabel.Text = string.format("Gained: %s", formatNumber(durabilityGain))
    rebirthsGainLabel.Text = string.format("Gained: %s", formatNumber(rebirthsGain))
    killsGainLabel.Text = string.format("Gained: %s", formatNumber(killsGain))
    brawlsGainLabel.Text = string.format("Gained: %s", formatNumber(brawlsGain))
    
    local elapsedTime = os.time() - sessionStartTime
    local timeString = formatTime(elapsedTime)
    sessionTimeLabel.Text = string.format("Time: %s", timeString)
end

updateStats()

spawn(function()
    while wait(2) do
        updateStats()
    end
end)

statsFolder:AddButton("Очистить статистику", function()
    local plr = player
    sessionStartStrength = plr.leaderstats.Strength.Value
    sessionStartDurability = plr.Durability.Value
    sessionStartKills = plr.leaderstats.Kills.Value
    sessionStartRebirths = plr.leaderstats.Rebirths.Value
    sessionStartBrawls = plr.leaderstats.Brawls.Value
    sessionStartTime = os.time()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Готово",
        Text = "Ты очистил",
        Duration = 3
    })
end)

statsFolder:AddButton("Скопировать", function()
    local plr = player
    local statsText = "Muscle Legends:\n\n"
    
    statsText = statsText .. "Сила: " .. formatNumberWithCommas(plr.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Долговечность: " .. formatNumberWithCommas(plr.Durability.Value) .. "\n"
    statsText = statsText .. "Перерождения: " .. formatNumberWithCommas(plr.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Убийства: " .. formatNumberWithCommas(plr.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Поединки: " .. formatNumberWithCommas(plr.leaderstats.Brawls.Value) .. "\n\n"
    
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        local strengthGain = plr.leaderstats.Strength.Value - sessionStartStrength
        local durabilityGain = plr.Durability.Value - sessionStartDurability
        local killsGain = plr.leaderstats.Kills.Value - sessionStartKills
        local rebirthsGain = plr.leaderstats.Rebirths.Value - sessionStartRebirths
        local brawlsGain = plr.leaderstats.Brawls.Value - sessionStartBrawls
        
        statsText = statsText .. "--- Estadísticas de Sesión ---\n"
        statsText = statsText .. "Time Of Session: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Strength Gained: " .. formatNumberWithCommas(strengthGain) .. "\n"
        statsText = statsText .. "Durability Gained: " .. formatNumberWithCommas(durabilityGain) .. "\n"
        statsText = statsText .. "Rebirths Gained: " .. formatNumberWithCommas(rebirthsGain) .. "\n"
        statsText = statsText .. "Kills Gained: " .. formatNumberWithCommas(killsGain) .. "\n"
        statsText = statsText .. "Brawls Gained: " .. formatNumberWithCommas(brawlsGain) .. "\n"
    end
    
    setclipboard(statsText)
end)
