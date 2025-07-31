local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library/main/Library", true))()

-- Создание главного окна со светло-серым цветом
local window = library:AddWindow("Vanegood Hub", {
    main_color = Color3.fromRGB(200, 200, 200), -- светло-серый
    min_size = Vector2.new(500, 400),
    can_resize = true
})

-- Основная вкладка 
local mainTab = window:AddTab("Меню")
mainTab:Show()
-- AutoSteps
mainTab:AddButton("AutoSteps", function()
    getgenv().AutoSteps = true
    while getgenv().AutoSteps do
        local args = {
            [1] = "collectOrb",
            [2] = "Orange Orb",
            [3] = "City"
        }
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
        task.wait()
    end
end)

-- AutoGems
mainTab:AddButton("AutoGems", function()
    getgenv().AutoGems = true
    while getgenv().AutoGems do
        local args = {
            [1] = "collectOrb",
            [2] = "Gem",
            [3] = "City"
        }
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
        task.wait()
    end
end)

-- AutoRebirth
mainTab:AddButton("AutoRebirth", function()
    getgenv().AutoRebirth = true
    while getgenv().AutoRebirth do
        local args = {
            [1] = "rebirthRequest"
        }
        game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
        task.wait()
    end
end)

-- Вкладка "Создатель"
local noteTab = window:AddTab("Создатель")
noteTab:AddLabel("Private Script")
noteTab:AddLabel("")
noteTab:AddLabel("Созданно vanegood")

-- Принудительное отображение интерфейса
if game:GetService("CoreGui"):FindFirstChild("Elerium") then
    game:GetService("CoreGui").Elerium.Enabled = true
end

