--[[
    vanegood Hub v2.0 - Compact & Elegant Design
    Created by vanegood
    GitHub: https://github.com/Vanegood-sus/vanegood.git
    
    Roblox hub script with black/grey theme and dark red accents
    Features: Compact design, smooth animations, Muscle Legends integration
]]--

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables
local VanegoodHub = {}
local GUI = {}
local CurrentTab = "Main"

-- Colors
local Colors = {
    Black = Color3.fromRGB(0, 0, 0),
    DarkGray = Color3.fromRGB(40, 40, 40),
    Gray = Color3.fromRGB(60, 60, 60),
    LightGray = Color3.fromRGB(80, 80, 80),
    White = Color3.fromRGB(255, 255, 255),
    DarkRed = Color3.fromRGB(139, 0, 0)
}

-- Helper Functions
local function CreateTween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), properties)
    return tween
end

local function AddCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
    return corner
end

local function AddStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.Parent = object
    return stroke
end

-- Main Hub Creation
function VanegoodHub:Create()
    -- Create ScreenGui
    GUI.Main = Instance.new("ScreenGui")
    GUI.Main.Name = "VanegoodHub"
    GUI.Main.ResetOnSpawn = false
    GUI.Main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    GUI.Frame = Instance.new("Frame")
    GUI.Frame.Name = "MainFrame"
    GUI.Frame.Size = UDim2.new(0, 450, 0, 300)
    GUI.Frame.Position = UDim2.new(0.5, -225, 0.5, -150)
    GUI.Frame.BackgroundColor3 = Colors.Black
    GUI.Frame.BorderSizePixel = 0
    GUI.Frame.Parent = GUI.Main
    
    AddCorner(GUI.Frame, 8)
    AddStroke(GUI.Frame, Colors.DarkRed, 2)
    
    -- Title Bar
    GUI.TitleBar = Instance.new("Frame")
    GUI.TitleBar.Name = "TitleBar"
    GUI.TitleBar.Size = UDim2.new(1, 0, 0, 30)
    GUI.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    GUI.TitleBar.BackgroundColor3 = Colors.DarkRed
    GUI.TitleBar.BorderSizePixel = 0
    GUI.TitleBar.Parent = GUI.Frame
    
    AddCorner(GUI.TitleBar, 8)
    
    -- Title Text
    GUI.Title = Instance.new("TextLabel")
    GUI.Title.Name = "Title"
    GUI.Title.Size = UDim2.new(1, -40, 1, 0)
    GUI.Title.Position = UDim2.new(0, 5, 0, 0)
    GUI.Title.BackgroundTransparency = 1
    GUI.Title.Text = "vanegood"
    GUI.Title.TextColor3 = Colors.White
    GUI.Title.TextSize = 16
    GUI.Title.Font = Enum.Font.GothamBold
    GUI.Title.TextXAlignment = Enum.TextXAlignment.Left
    GUI.Title.Parent = GUI.TitleBar
    
    -- Close Button
    GUI.CloseButton = Instance.new("TextButton")
    GUI.CloseButton.Name = "CloseButton"
    GUI.CloseButton.Size = UDim2.new(0, 25, 0, 25)
    GUI.CloseButton.Position = UDim2.new(1, -30, 0, 2.5)
    GUI.CloseButton.BackgroundColor3 = Colors.DarkRed
    GUI.CloseButton.BorderSizePixel = 0
    GUI.CloseButton.Text = "✕"
    GUI.CloseButton.TextColor3 = Colors.White
    GUI.CloseButton.TextSize = 14
    GUI.CloseButton.Font = Enum.Font.GothamBold
    GUI.CloseButton.Parent = GUI.TitleBar
    
    AddCorner(GUI.CloseButton, 4)
    
    -- Hide Button
    GUI.HideButton = Instance.new("TextButton")
    GUI.HideButton.Name = "HideButton"
    GUI.HideButton.Size = UDim2.new(0, 25, 0, 25)
    GUI.HideButton.Position = UDim2.new(1, -60, 0, 2.5)
    GUI.HideButton.BackgroundColor3 = Colors.DarkRed
    GUI.HideButton.BorderSizePixel = 0
    GUI.HideButton.Text = "–"
    GUI.HideButton.TextColor3 = Colors.White
    GUI.HideButton.TextSize = 16
    GUI.HideButton.Font = Enum.Font.GothamBold
    GUI.HideButton.Parent = GUI.TitleBar
    
    AddCorner(GUI.HideButton, 4)
    
    -- Sidebar
    GUI.Sidebar = Instance.new("Frame")
    GUI.Sidebar.Name = "Sidebar"
    GUI.Sidebar.Size = UDim2.new(0, 80, 1, -30)
    GUI.Sidebar.Position = UDim2.new(0, 0, 0, 30)
    GUI.Sidebar.BackgroundColor3 = Colors.DarkGray
    GUI.Sidebar.BorderSizePixel = 0
    GUI.Sidebar.Parent = GUI.Frame
    
    -- Content Area
    GUI.Content = Instance.new("Frame")
    GUI.Content.Name = "Content"
    GUI.Content.Size = UDim2.new(1, -80, 1, -30)
    GUI.Content.Position = UDim2.new(0, 80, 0, 30)
    GUI.Content.BackgroundColor3 = Colors.DarkGray
    GUI.Content.BorderSizePixel = 0
    GUI.Content.Parent = GUI.Frame
    
    self:CreateSidebar()
    self:CreateContent()
    self:MakeDraggable()
    self:SetupEvents()
    
    return GUI.Main
end

-- Create Sidebar
function VanegoodHub:CreateSidebar()
    -- Main Tab Button (компактный стиль)
    GUI.MainTabButton = Instance.new("TextButton")
    GUI.MainTabButton.Name = "MainTabButton"
    GUI.MainTabButton.Size = UDim2.new(1, -10, 0, 32)
    GUI.MainTabButton.Position = UDim2.new(0, 5, 0, 8)
    GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed -- Start selected
    GUI.MainTabButton.BorderSizePixel = 0
    GUI.MainTabButton.Text = "main"
    GUI.MainTabButton.TextColor3 = Colors.White
    GUI.MainTabButton.TextSize = 13
    GUI.MainTabButton.Font = Enum.Font.GothamBold
    GUI.MainTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.MainTabButton, 4)
    
    -- Games Tab Button (компактный стиль)
    GUI.GamesTabButton = Instance.new("TextButton")
    GUI.GamesTabButton.Name = "GamesTabButton"
    GUI.GamesTabButton.Size = UDim2.new(1, -10, 0, 32)
    GUI.GamesTabButton.Position = UDim2.new(0, 5, 0, 45)
    GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    GUI.GamesTabButton.BorderSizePixel = 0
    GUI.GamesTabButton.Text = "games"
    GUI.GamesTabButton.TextColor3 = Colors.White
    GUI.GamesTabButton.TextSize = 13
    GUI.GamesTabButton.Font = Enum.Font.GothamBold
    GUI.GamesTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.GamesTabButton, 4)
    
    -- Hover effects for sidebar buttons
    GUI.MainTabButton.MouseEnter:Connect(function()
        if CurrentTab ~= "Main" then
            CreateTween(GUI.MainTabButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
        end
    end)
    
    GUI.MainTabButton.MouseLeave:Connect(function()
        if CurrentTab ~= "Main" then
            CreateTween(GUI.MainTabButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
        end
    end)
    
    GUI.GamesTabButton.MouseEnter:Connect(function()
        if CurrentTab ~= "Games" then
            CreateTween(GUI.GamesTabButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
        end
    end)
    
    GUI.GamesTabButton.MouseLeave:Connect(function()
        if CurrentTab ~= "Games" then
            CreateTween(GUI.GamesTabButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
        end
    end)
    
    -- Tab Events
    GUI.MainTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Main")
    end)
    
    GUI.GamesTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Games")
    end)
end

-- Create Content
function VanegoodHub:CreateContent()
    -- Main Page
    GUI.MainPage = Instance.new("Frame")
    GUI.MainPage.Name = "MainPage"
    GUI.MainPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.MainPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.MainPage.BackgroundTransparency = 1
    GUI.MainPage.Visible = true
    GUI.MainPage.Parent = GUI.Content
    
    -- vanegood title (dark red) - более компактный
    GUI.VanegoodTitle = Instance.new("TextLabel")
    GUI.VanegoodTitle.Name = "VanegoodTitle"
    GUI.VanegoodTitle.Size = UDim2.new(1, 0, 0, 35)
    GUI.VanegoodTitle.Position = UDim2.new(0, 0, 0, 5)
    GUI.VanegoodTitle.BackgroundTransparency = 1
    GUI.VanegoodTitle.Text = "vanegood"
    GUI.VanegoodTitle.TextColor3 = Colors.DarkRed
    GUI.VanegoodTitle.TextSize = 20
    GUI.VanegoodTitle.Font = Enum.Font.GothamBold
    GUI.VanegoodTitle.TextXAlignment = Enum.TextXAlignment.Center
    GUI.VanegoodTitle.Parent = GUI.MainPage
    
    -- Fly button (компактный и стильный)
    GUI.FlyButton = Instance.new("TextButton")
    GUI.FlyButton.Name = "FlyButton"
    GUI.FlyButton.Size = UDim2.new(0, 120, 0, 28)
    GUI.FlyButton.Position = UDim2.new(0, 15, 0, 50)
    GUI.FlyButton.BackgroundColor3 = Colors.DarkGray
    GUI.FlyButton.BorderSizePixel = 0
    GUI.FlyButton.Text = "fly"
    GUI.FlyButton.TextColor3 = Colors.White
    GUI.FlyButton.TextSize = 13
    GUI.FlyButton.Font = Enum.Font.Gotham
    GUI.FlyButton.Parent = GUI.MainPage
    
    AddCorner(GUI.FlyButton, 4)
    AddStroke(GUI.FlyButton, Colors.DarkRed, 1)
    
    -- Hover effect for fly button
    GUI.FlyButton.MouseEnter:Connect(function()
        CreateTween(GUI.FlyButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
    end)
    
    GUI.FlyButton.MouseLeave:Connect(function()
        CreateTween(GUI.FlyButton, {BackgroundColor3 = Colors.DarkGray}, 0.2):Play()
    end)
    
    -- Speed button
    GUI.SpeedButton = Instance.new("TextButton")
    GUI.SpeedButton.Name = "SpeedButton"
    GUI.SpeedButton.Size = UDim2.new(0, 120, 0, 28)
    GUI.SpeedButton.Position = UDim2.new(0, 145, 0, 50)
    GUI.SpeedButton.BackgroundColor3 = Colors.DarkGray
    GUI.SpeedButton.BorderSizePixel = 0
    GUI.SpeedButton.Text = "speed"
    GUI.SpeedButton.TextColor3 = Colors.White
    GUI.SpeedButton.TextSize = 13
    GUI.SpeedButton.Font = Enum.Font.Gotham
    GUI.SpeedButton.Parent = GUI.MainPage
    
    AddCorner(GUI.SpeedButton, 4)
    AddStroke(GUI.SpeedButton, Colors.DarkRed, 1)
    
    -- Jump button
    GUI.JumpButton = Instance.new("TextButton")
    GUI.JumpButton.Name = "JumpButton"
    GUI.JumpButton.Size = UDim2.new(0, 120, 0, 28)
    GUI.JumpButton.Position = UDim2.new(0, 15, 0, 88)
    GUI.JumpButton.BackgroundColor3 = Colors.DarkGray
    GUI.JumpButton.BorderSizePixel = 0
    GUI.JumpButton.Text = "jump"
    GUI.JumpButton.TextColor3 = Colors.White
    GUI.JumpButton.TextSize = 13
    GUI.JumpButton.Font = Enum.Font.Gotham
    GUI.JumpButton.Parent = GUI.MainPage
    
    AddCorner(GUI.JumpButton, 4)
    AddStroke(GUI.JumpButton, Colors.DarkRed, 1)
    
    -- Noclip button
    GUI.NoclipButton = Instance.new("TextButton")
    GUI.NoclipButton.Name = "NoclipButton"
    GUI.NoclipButton.Size = UDim2.new(0, 120, 0, 28)
    GUI.NoclipButton.Position = UDim2.new(0, 145, 0, 88)
    GUI.NoclipButton.BackgroundColor3 = Colors.DarkGray
    GUI.NoclipButton.BorderSizePixel = 0
    GUI.NoclipButton.Text = "noclip"
    GUI.NoclipButton.TextColor3 = Colors.White
    GUI.NoclipButton.TextSize = 13
    GUI.NoclipButton.Font = Enum.Font.Gotham
    GUI.NoclipButton.Parent = GUI.MainPage
    
    AddCorner(GUI.NoclipButton, 4)
    AddStroke(GUI.NoclipButton, Colors.DarkRed, 1)
    
    -- Add hover effects for all buttons
    local buttons = {GUI.FlyButton, GUI.SpeedButton, GUI.JumpButton, GUI.NoclipButton}
    for _, button in pairs(buttons) do
        button.MouseEnter:Connect(function()
            CreateTween(button, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, {BackgroundColor3 = Colors.DarkGray}, 0.2):Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            print(button.Text .. " button clicked (not implemented yet)")
        end)
    end
    
    -- Games Page
    GUI.GamesPage = Instance.new("Frame")
    GUI.GamesPage.Name = "GamesPage"
    GUI.GamesPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.GamesPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.GamesPage.BackgroundTransparency = 1
    GUI.GamesPage.Visible = false
    GUI.GamesPage.Parent = GUI.Content
    
    -- Muscle Legends Game Box (компактный дизайн)
    GUI.MuscleLegendsBox = Instance.new("TextButton")
    GUI.MuscleLegendsBox.Name = "MuscleLegendsBox"
    GUI.MuscleLegendsBox.Size = UDim2.new(0, 280, 0, 36)
    GUI.MuscleLegendsBox.Position = UDim2.new(0, 15, 0, 15)
    GUI.MuscleLegendsBox.BackgroundColor3 = Colors.DarkGray
    GUI.MuscleLegendsBox.BorderSizePixel = 0
    GUI.MuscleLegendsBox.Text = "Muscle Legends"
    GUI.MuscleLegendsBox.TextColor3 = Colors.White
    GUI.MuscleLegendsBox.TextSize = 14
    GUI.MuscleLegendsBox.Font = Enum.Font.GothamBold
    GUI.MuscleLegendsBox.TextXAlignment = Enum.TextXAlignment.Center
    GUI.MuscleLegendsBox.Parent = GUI.GamesPage
    
    AddCorner(GUI.MuscleLegendsBox, 4)
    AddStroke(GUI.MuscleLegendsBox, Colors.DarkRed, 1)
    
    -- Hover effect for Muscle Legends button
    GUI.MuscleLegendsBox.MouseEnter:Connect(function()
        CreateTween(GUI.MuscleLegendsBox, {
            BackgroundColor3 = Colors.Gray,
            TextColor3 = Colors.DarkRed
        }, 0.2):Play()
    end)
    
    GUI.MuscleLegendsBox.MouseLeave:Connect(function()
        CreateTween(GUI.MuscleLegendsBox, {
            BackgroundColor3 = Colors.DarkGray,
            TextColor3 = Colors.White
        }, 0.2):Play()
    end)
    
    -- Muscle Legends click event with improved error handling
    GUI.MuscleLegendsBox.MouseButton1Click:Connect(function()
        print("Loading Muscle Legends script by vanegood...")
        
        -- Visual feedback
        CreateTween(GUI.MuscleLegendsBox, {BackgroundColor3 = Colors.DarkRed}, 0.1):Play()
        task.wait(0.1)
        CreateTween(GUI.MuscleLegendsBox, {BackgroundColor3 = Colors.DarkGray}, 0.1):Play()
        
        -- Load script with better error handling
        task.spawn(function()
            local success, err = pcall(function()
                local scriptUrl = "https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/muscle_legends_script.lua"
                local script = game:HttpGet(scriptUrl)
                
                if script and #script > 100 then -- Check if script actually loaded
                    loadstring(script)()
                    print("✓ Muscle Legends script loaded successfully!")
                    
                    -- Success notification
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "vanegood",
                        Text = "Muscle Legends script loaded successfully!",
                        Duration = 3
                    })
                else
                    error("Failed to fetch script or script is too short")
                end
            end)
            
            if not success then
                warn("Failed to load Muscle Legends script:", err)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "vanegood",
                    Text = "Failed to load Muscle Legends script. Check console.",
                    Duration = 5
                })
            end
        end)
    end)
    
    -- Additional game button for aesthetics
    GUI.ComingSoonBox = Instance.new("TextButton")
    GUI.ComingSoonBox.Name = "ComingSoonBox"
    GUI.ComingSoonBox.Size = UDim2.new(0, 280, 0, 36)
    GUI.ComingSoonBox.Position = UDim2.new(0, 15, 0, 60)
    GUI.ComingSoonBox.BackgroundColor3 = Colors.Gray
    GUI.ComingSoonBox.BorderSizePixel = 0
    GUI.ComingSoonBox.Text = "More Games Coming Soon..."
    GUI.ComingSoonBox.TextColor3 = Color3.fromRGB(150, 150, 150)
    GUI.ComingSoonBox.TextSize = 12
    GUI.ComingSoonBox.Font = Enum.Font.Gotham
    GUI.ComingSoonBox.TextXAlignment = Enum.TextXAlignment.Center
    GUI.ComingSoonBox.Parent = GUI.GamesPage
    GUI.ComingSoonBox.Active = false
    
    AddCorner(GUI.ComingSoonBox, 4)
    AddStroke(GUI.ComingSoonBox, Color3.fromRGB(100, 100, 100), 1)
end

-- Switch Tab Function
function VanegoodHub:SwitchTab(tabName)
    CurrentTab = tabName
    
    if tabName == "Main" then
        GUI.MainPage.Visible = true
        GUI.GamesPage.Visible = false
        GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed
        GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    elseif tabName == "Games" then
        GUI.MainPage.Visible = false
        GUI.GamesPage.Visible = true
        GUI.MainTabButton.BackgroundColor3 = Colors.Gray
        GUI.GamesTabButton.BackgroundColor3 = Colors.DarkRed
    end
end

-- Make Draggable
function VanegoodHub:MakeDraggable()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    GUI.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = GUI.Frame.Position
        end
    end)
    
    GUI.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            GUI.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Setup Events
function VanegoodHub:SetupEvents()
    GUI.CloseButton.MouseButton1Click:Connect(function()
        CreateTween(GUI.Frame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
        task.wait(0.3)
        GUI.Main:Destroy()
    end)
    
    local hidden = false
    GUI.HideButton.MouseButton1Click:Connect(function()
        if not hidden then
            CreateTween(GUI.Frame, {Size = UDim2.new(0, 450, 0, 30)}, 0.3):Play()
            hidden = true
        else
            CreateTween(GUI.Frame, {Size = UDim2.new(0, 450, 0, 300)}, 0.3):Play()
            hidden = false
        end
    end)
    
    -- Add hover effects for title bar buttons
    GUI.CloseButton.MouseEnter:Connect(function()
        CreateTween(GUI.CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}, 0.2):Play()
    end)
    
    GUI.CloseButton.MouseLeave:Connect(function()
        CreateTween(GUI.CloseButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
    end)
    
    GUI.HideButton.MouseEnter:Connect(function()
        CreateTween(GUI.HideButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
    end)
    
    GUI.HideButton.MouseLeave:Connect(function()
        CreateTween(GUI.HideButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
    end)
end

-- Initialize Hub
local hub = VanegoodHub:Create()

print("✓ vanegood Hub v2.0 loaded successfully!")
print("✓ Created by vanegood - GitHub: https://github.com/Vanegood-sus/vanegood.git")
print("✓ Compact & elegant design with improved Muscle Legends integration")
