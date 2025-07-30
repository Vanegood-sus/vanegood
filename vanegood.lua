--[[
    vanegood hub
    Created by vanegood
    GitHub: https://github.com/Vanegood-sus/vanegood.git
    
    Simple dark hub with black & gray design
]]--

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Variables
local VanegoodHub = {}
local GUI = {}
local CurrentTab = "Main"
local IsMinimized = false

-- Color Scheme (Black & Gray with Dark Red accents)
local Colors = {
    Black = Color3.fromRGB(0, 0, 0),           -- Pure black
    DarkGray = Color3.fromRGB(30, 30, 30),     -- Dark gray
    Gray = Color3.fromRGB(60, 60, 60),         -- Gray
    DarkRed = Color3.fromRGB(80, 20, 20),      -- Dark red
    Red = Color3.fromRGB(120, 30, 30),         -- Red accent
    White = Color3.fromRGB(255, 255, 255),     -- White text
    LightGray = Color3.fromRGB(180, 180, 180)  -- Light gray text
}

-- Utility Functions
local function CreateTween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    return TweenService:Create(object, tweenInfo, properties)
end

local function AddCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = object
    return corner
end

local function AddStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Colors.DarkRed
    stroke.Thickness = thickness or 2
    stroke.Parent = object
    return stroke
end

-- Create Main GUI
function VanegoodHub:CreateMainGUI()
    -- Destroy existing GUI if it exists
    if PlayerGui:FindFirstChild("VanegoodHub") then
        PlayerGui.VanegoodHub:Destroy()
    end
    
    -- Main ScreenGui
    GUI.Main = Instance.new("ScreenGui")
    GUI.Main.Name = "VanegoodHub"
    GUI.Main.ResetOnSpawn = false
    GUI.Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Try CoreGui first, fallback to PlayerGui
    pcall(function()
        GUI.Main.Parent = CoreGui
    end)
    if not GUI.Main.Parent then
        GUI.Main.Parent = PlayerGui
    end
    
    -- Main Frame
    GUI.MainFrame = Instance.new("Frame")
    GUI.MainFrame.Name = "MainFrame"
    GUI.MainFrame.Size = UDim2.new(0, 500, 0, 350)
    GUI.MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    GUI.MainFrame.BackgroundColor3 = Colors.Black
    GUI.MainFrame.BorderSizePixel = 0
    GUI.MainFrame.Active = true
    GUI.MainFrame.Draggable = true
    GUI.MainFrame.Parent = GUI.Main
    
    AddCorner(GUI.MainFrame, 8)
    AddStroke(GUI.MainFrame, Colors.DarkRed, 2)
    
    -- Sidebar
    GUI.Sidebar = Instance.new("Frame")
    GUI.Sidebar.Name = "Sidebar"
    GUI.Sidebar.Size = UDim2.new(0, 120, 1, 0)
    GUI.Sidebar.Position = UDim2.new(0, 0, 0, 0)
    GUI.Sidebar.BackgroundColor3 = Colors.DarkGray
    GUI.Sidebar.BorderSizePixel = 0
    GUI.Sidebar.Parent = GUI.MainFrame
    
    AddCorner(GUI.Sidebar, 8)
    
    -- Content Frame
    GUI.Content = Instance.new("Frame")
    GUI.Content.Name = "Content"
    GUI.Content.Size = UDim2.new(1, -120, 1, 0)
    GUI.Content.Position = UDim2.new(0, 120, 0, 0)
    GUI.Content.BackgroundColor3 = Colors.Black
    GUI.Content.BorderSizePixel = 0
    GUI.Content.ClipsDescendants = true
    GUI.Content.Parent = GUI.MainFrame
    
    AddCorner(GUI.Content, 8)
    
    self:CreateSidebar()
    self:CreateContent()
    self:CreateMinimizeButton()
    
    return GUI.Main
end

-- Create Sidebar
function VanegoodHub:CreateSidebar()
    -- Main Tab Button (prettier and smaller)
    GUI.MainTabButton = Instance.new("TextButton")
    GUI.MainTabButton.Name = "MainTabButton"
    GUI.MainTabButton.Size = UDim2.new(1, -10, 0, 35)
    GUI.MainTabButton.Position = UDim2.new(0, 5, 0, 10)
    GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed -- Start selected
    GUI.MainTabButton.BorderSizePixel = 0
    GUI.MainTabButton.Text = "main"
    GUI.MainTabButton.TextColor3 = Colors.White
    GUI.MainTabButton.TextSize = 14
    GUI.MainTabButton.Font = Enum.Font.GothamBold
    GUI.MainTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.MainTabButton, 4)
    AddStroke(GUI.MainTabButton, Colors.DarkRed, 1)
    
    -- Games Tab Button (prettier and smaller)
    GUI.GamesTabButton = Instance.new("TextButton")
    GUI.GamesTabButton.Name = "GamesTabButton"
    GUI.GamesTabButton.Size = UDim2.new(1, -10, 0, 35)
    GUI.GamesTabButton.Position = UDim2.new(0, 5, 0, 55)
    GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    GUI.GamesTabButton.BorderSizePixel = 0
    GUI.GamesTabButton.Text = "games"
    GUI.GamesTabButton.TextColor3 = Colors.White
    GUI.GamesTabButton.TextSize = 14
    GUI.GamesTabButton.Font = Enum.Font.GothamBold
    GUI.GamesTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.GamesTabButton, 4)
    AddStroke(GUI.GamesTabButton, Colors.DarkRed, 1)
    
    -- Tab Events
    GUI.MainTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Main")
    end)
    
    GUI.GamesTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Games")
    end)
    
    -- Tab events will handle the switching
end

-- Create Content
function VanegoodHub:CreateContent()
    -- Main Page
    GUI.MainPage = Instance.new("Frame")
    GUI.MainPage.Name = "MainPage"
    GUI.MainPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.MainPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.MainPage.BackgroundTransparency = 1
    GUI.MainPage.Visible = true -- Make sure it's visible
    GUI.MainPage.Parent = GUI.Content
    
    -- vanegood title (dark red)
    GUI.VanegoodTitle = Instance.new("TextLabel")
    GUI.VanegoodTitle.Name = "VanegoodTitle"
    GUI.VanegoodTitle.Size = UDim2.new(1, 0, 0, 50)
    GUI.VanegoodTitle.Position = UDim2.new(0, 0, 0, 10)
    GUI.VanegoodTitle.BackgroundTransparency = 1
    GUI.VanegoodTitle.Text = "vanegood"
    GUI.VanegoodTitle.TextColor3 = Colors.DarkRed
    GUI.VanegoodTitle.TextSize = 24
    GUI.VanegoodTitle.Font = Enum.Font.GothamBold
    GUI.VanegoodTitle.TextXAlignment = Enum.TextXAlignment.Center
    GUI.VanegoodTitle.Parent = GUI.MainPage
    
    -- Fly button (smaller and prettier)
    GUI.FlyButton = Instance.new("TextButton")
    GUI.FlyButton.Name = "FlyButton"
    GUI.FlyButton.Size = UDim2.new(0, 120, 0, 30)
    GUI.FlyButton.Position = UDim2.new(0, 20, 0, 80)
    GUI.FlyButton.BackgroundColor3 = Colors.DarkGray
    GUI.FlyButton.BorderSizePixel = 0
    GUI.FlyButton.Text = "fly"
    GUI.FlyButton.TextColor3 = Colors.White
    GUI.FlyButton.TextSize = 14
    GUI.FlyButton.Font = Enum.Font.GothamBold
    GUI.FlyButton.Parent = GUI.MainPage
    
    AddCorner(GUI.FlyButton, 4)
    AddStroke(GUI.FlyButton, Colors.DarkRed, 1)
    
    -- Fly button event (does nothing for now)
    GUI.FlyButton.MouseButton1Click:Connect(function()
        -- Nothing happens yet
        print("fly button clicked (not implemented yet)")
    end)
    
    -- Games Page
    GUI.GamesPage = Instance.new("Frame")
    GUI.GamesPage.Name = "GamesPage"
    GUI.GamesPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.GamesPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.GamesPage.BackgroundTransparency = 1
    GUI.GamesPage.Visible = false
    GUI.GamesPage.Parent = GUI.Content
    
    -- Muscle Legends Game Box (smaller and prettier)
    GUI.MuscleLegendsBox = Instance.new("Frame")
    GUI.MuscleLegendsBox.Name = "MuscleLegendsBox"
    GUI.MuscleLegendsBox.Size = UDim2.new(0, 250, 0, 45)
    GUI.MuscleLegendsBox.Position = UDim2.new(0, 20, 0, 20)
    GUI.MuscleLegendsBox.BackgroundColor3 = Colors.DarkGray
    GUI.MuscleLegendsBox.BorderSizePixel = 0
    GUI.MuscleLegendsBox.Parent = GUI.GamesPage
    
    AddCorner(GUI.MuscleLegendsBox, 4)
    AddStroke(GUI.MuscleLegendsBox, Colors.DarkRed, 1)
    
    -- Muscle Legends Title (smaller text)
    GUI.MuscleLegendsTitle = Instance.new("TextLabel")
    GUI.MuscleLegendsTitle.Name = "MuscleLegendsTitle"
    GUI.MuscleLegendsTitle.Size = UDim2.new(1, -20, 1, 0)
    GUI.MuscleLegendsTitle.Position = UDim2.new(0, 10, 0, 0)
    GUI.MuscleLegendsTitle.BackgroundTransparency = 1
    GUI.MuscleLegendsTitle.Text = "Muscle Legends"
    GUI.MuscleLegendsTitle.TextColor3 = Colors.White
    GUI.MuscleLegendsTitle.TextSize = 15
    GUI.MuscleLegendsTitle.TextXAlignment = Enum.TextXAlignment.Left
    GUI.MuscleLegendsTitle.Font = Enum.Font.GothamBold
    GUI.MuscleLegendsTitle.Parent = GUI.MuscleLegendsBox
    
    -- Make Muscle Legends box clickable
    local ClickDetector = Instance.new("TextButton")
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.Parent = GUI.MuscleLegendsBox
    
    ClickDetector.MouseButton1Click:Connect(function()
        -- Load Muscle Legends script with better error handling
        local success, error = pcall(function()
            local scriptContent = game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/muscle_legends_script.lua")
            if scriptContent and scriptContent ~= "" then
                loadstring(scriptContent)()
                print("Muscle Legends script loaded successfully by vanegood")
            else
                warn("Failed to load Muscle Legends script - empty response")
            end
        end)
        
        if not success then
            warn("Error loading Muscle Legends script: " .. tostring(error))
        end
    end)
end

-- Create Minimize Button
function VanegoodHub:CreateMinimizeButton()
    GUI.MinimizeButton = Instance.new("TextButton")
    GUI.MinimizeButton.Name = "MinimizeButton"
    GUI.MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    GUI.MinimizeButton.Position = UDim2.new(0, 10, 0, 10)
    GUI.MinimizeButton.BackgroundColor3 = Colors.Gray
    GUI.MinimizeButton.BorderSizePixel = 0
    GUI.MinimizeButton.Text = ""
    GUI.MinimizeButton.Parent = GUI.Main
    
    AddCorner(GUI.MinimizeButton, 20)
    
    -- Dark red circle in the middle
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = UDim2.new(0.5, -10, 0.5, -10)
    Circle.BackgroundColor3 = Colors.DarkRed
    Circle.BorderSizePixel = 0
    Circle.Parent = GUI.MinimizeButton
    
    AddCorner(Circle, 10)
    
    GUI.MinimizeButton.MouseButton1Click:Connect(function()
        if IsMinimized then
            -- Show hub
            CreateTween(GUI.MainFrame, {Size = UDim2.new(0, 500, 0, 350)}, 0.3):Play()
            GUI.MainFrame.Visible = true
            IsMinimized = false
        else
            -- Hide hub
            CreateTween(GUI.MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
            task.wait(0.3)
            GUI.MainFrame.Visible = false
            IsMinimized = true
        end
    end)
end

-- Switch Tab
function VanegoodHub:SwitchTab(tabName)
    CurrentTab = tabName
    
    -- Reset all tab button colors
    GUI.MainTabButton.BackgroundColor3 = Colors.Gray
    GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    
    -- Hide all pages
    GUI.MainPage.Visible = false
    GUI.GamesPage.Visible = false
    
    if tabName == "Main" then
        GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed
        GUI.MainPage.Visible = true
        print("Switched to Main tab")
    elseif tabName == "Games" then
        GUI.GamesTabButton.BackgroundColor3 = Colors.DarkRed
        GUI.GamesPage.Visible = true
        print("Switched to Games tab")
    end
end

-- Initialize Hub
function VanegoodHub:Init()
    print("Starting vanegood hub initialization...")
    self:CreateMainGUI()
    
    -- Make sure Main tab is selected and visible
    self:SwitchTab("Main")
    
    print("vanegood hub loaded")
    print("GitHub: https://github.com/Vanegood-sus/vanegood.git")
end

-- Auto-execute protection
if not getgenv().VanegoodHubLoaded then
    getgenv().VanegoodHubLoaded = true
    VanegoodHub:Init()
else
    warn("vanegood hub is already loaded!")
end

return VanegoodHub
