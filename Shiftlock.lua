local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local States = {
    Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
    On = "rbxasset://textures/ui/mouseLock_on@2x.png",
    Lock = "rbxasset://textures/MouseLockedCursor.png"
}

local MaxLength = 900000
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)
local Active

-- Создаем GUI
local ShiftLockScreenGui = Instance.new("ScreenGui")
ShiftLockScreenGui.Name = "Shiftlock (CoreGui)"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false

-- Кнопка шифтлока (уменьшенный размер и смещена к центру справа)
local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Name = "ShiftLockButton"
ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.BackgroundTransparency = 1.000
ShiftLockButton.Position = UDim2.new(0.92, 0, 0.55, 0)  -- Смещено правее и к центру
ShiftLockButton.Size = UDim2.new(0.05, 0, 0.05, 0)       -- Уменьшенный размер
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.Image = States.Off
ShiftLockButton.ZIndex = 10

-- Курсор для шифтлока
local ShiftlockCursor = Instance.new("ImageLabel")
ShiftlockCursor.Name = "ShiftlockCursor"
ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = States.Lock
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ShiftlockCursor.Visible = false
ShiftlockCursor.ZIndex = 11

-- Функция для безопасного получения персонажа
local function getCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

-- Функция для безопасного получения корня персонажа
local function getRootPart()
    local character = getCharacter()
    return character:WaitForChild("HumanoidRootPart")
end

-- Функция для безопасного получения гуманоида
local function getHumanoid()
    local character = getCharacter()
    return character:WaitForChild("Humanoid")
end

-- Обработчик нажатия на кнопку
ShiftLockButton.MouseButton1Click:Connect(function()
    if not Active then
        Active = RunService.RenderStepped:Connect(function()
            local success, humanoid = pcall(getHumanoid)
            if not success or not humanoid then return end
            
            humanoid.AutoRotate = false
            ShiftLockButton.Image = States.On
            ShiftlockCursor.Visible = true
            
            local success, rootPart = pcall(getRootPart)
            if not success or not rootPart then return end
            
            local camera = workspace.CurrentCamera
            if not camera then return end
            
            rootPart.CFrame = CFrame.new(
                rootPart.Position,
                Vector3.new(
                    camera.CFrame.LookVector.X * MaxLength,
                    rootPart.Position.Y,
                    camera.CFrame.LookVector.Z * MaxLength
                )
            )
            
            camera.CFrame = camera.CFrame * EnabledOffset
            camera.Focus = CFrame.fromMatrix(
                camera.Focus.Position,
                camera.CFrame.RightVector,
                camera.CFrame.UpVector
            ) * EnabledOffset
        end)
    else
        local success, humanoid = pcall(getHumanoid)
        if success and humanoid then
            humanoid.AutoRotate = true
        end
        
        ShiftLockButton.Image = States.Off
        ShiftlockCursor.Visible = false
        
        if workspace.CurrentCamera then
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * DisabledOffset
        end
        
        if Active then
            Active:Disconnect()
            Active = nil
        end
    end
end)

-- Обработчик изменения размера экрана
UserInputService.WindowSizeChanged:Connect(function()
    ShiftLockButton.Position = UDim2.new(0.92, 0, 0.55, 0)  -- Всегда сохраняем позицию
end)

-- Автоматическое выключение при смерти
Player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if Active then
            ShiftLockButton.Image = States.Off
            ShiftlockCursor.Visible = false
            
            if Active then
                Active:Disconnect()
                Active = nil
            end
        end
    end)
end)

return {}
