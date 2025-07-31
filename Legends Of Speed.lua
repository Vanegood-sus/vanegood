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

-- Вкладка "Телепорты"
local teleportTab = window:AddTab("Телепорты")

-- Вкладка "Создатель"
local noteTab = window:AddTab("Создатель")
noteTab:AddLabel("Private Script")
noteTab:AddLabel("")
noteTab:AddLabel("Созданно vanegood")

-- Инициализация переменных
local PN = game:GetService("Players").LocalPlayer.Name
local player = game.Players.LocalPlayer
local hrp = player.Character:WaitForChild("HumanoidRootPart")

_G.autofarm = false
_G.autorebirthvar = false
_G.autofarmhoops = false
_G.autofarmgemsvar = false
_G.autoclaimgiftsvar = false
_G.autospinwheelvar = false

-- Функции автоФарма
function autofarmgems()
    task.spawn(function()
        while _G.autofarmgemsvar do
            for i,v in pairs(workspace.orbFolder.City:GetChildren()) do
                if v:FindFirstChild("outerGem") then
                    firetouchinterest(hrp, v.outerGem, 1)
                    task.wait()
                    firetouchinterest(hrp, v.outerGem, 0)
                end
            end
            task.wait(0.1)
        end
    end)
end

function autofarmhoops()
    task.spawn(function()
        while _G.autofarmhoops do
            local hoops = workspace:FindFirstChild("Hoops")
            if hoops then
                for i, v in pairs(hoops:GetChildren()) do
                    if hrp and v:IsA("BasePart") then
                        firetouchinterest(hrp, v, 1)
                        task.wait(0.1)
                        firetouchinterest(hrp, v, 0)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

function autofarmorb()
    task.spawn(function()
        while _G.autofarm do
            local orbpath = workspace.orbFolder.City
            for i, v in pairs(orbpath:GetChildren()) do
                if v:FindFirstChild("outerOrb") then
                    firetouchinterest(hrp, v.outerOrb, 0)
                    firetouchinterest(hrp, v.outerOrb, 1)
                end
            end
            task.wait(0.1)
        end
    end)
end

function autospinwheel()
    task.spawn(function()
        while _G.autospinwheelvar do
            local args = {
                "openFortuneWheel",
                game:GetService("ReplicatedStorage"):WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer(unpack(args))
            task.wait(0.3)
        end
    end)
end

function autoclaimgifts()
    local rEvents = game:GetService("ReplicatedStorage"):WaitForChild("rEvents")
    local giftclaimremote = rEvents:WaitForChild("freeGiftClaimRemote")
    task.spawn(function()
        while _G.autoclaimgiftsvar do
            for giftnum = 8, 1, -1 do
                local args = {"claimGift", giftnum}
                giftclaimremote:InvokeServer(unpack(args))
                task.wait(0.1)
            end
            task.wait(1)
        end
    end)
end

function autorebirth()
    task.spawn(function()
        while _G.autorebirthvar do
            local args = {"rebirthRequest"}
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("rebirthEvent"):FireServer(unpack(args))
            task.wait(0.3)
        end
    end)
end

-- Добавление элементов в интерфейс
mainTab:AddToggle("Авто-фарм орбов", {
    flag = "autofarm_toggle",
    state = false,
    callback = function(value)
        _G.autofarm = value
        autofarmorb()
    end
})

mainTab:AddToggle("Авто-фарм обручей", {
    flag = "autohoops_toggle",
    state = false,
    callback = function(value)
        _G.autofarmhoops = value
        autofarmhoops()
    end
})

mainTab:AddToggle("Авто-фарм кристаллов", {
    flag = "autogems_toggle",
    state = false,
    callback = function(value)
        _G.autofarmgemsvar = value
        autofarmgems()
    end
})

mainTab:AddToggle("Авто-ребёрт", {
    flag = "autorebirth_toggle",
    state = false,
    callback = function(value)
        _G.autorebirthvar = value
        autorebirth()
    end
})

mainTab:AddToggle("Авто-получение подарков", {
    flag = "autogifts_toggle",
    state = false,
    callback = function(value)
        _G.autoclaimgiftsvar = value
        autoclaimgifts()
    end
})

mainTab:AddToggle("Авто-кручение колеса", {
    flag = "autowheel_toggle",
    state = false,
    callback = function(value)
        _G.autospinwheelvar = value
        autospinwheel()
    end
})

-- Телепорты
teleportTab:AddButton("Телепорт в пустыню", function()
    hrp.CFrame = CFrame.new(48.3109131, 36.3147125, -8680.45312, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

teleportTab:AddButton("Телепорт в луга", function()
    hrp.CFrame = CFrame.new(1686.07495, 36.3147125, -5946.63428, -0.984812617, 0, 0.173621148, 0, 1, 0, -0.173621148, 0, -0.984812617)
end)

teleportTab:AddButton("Телепорт в магму", function()
    hrp.CFrame = CFrame.new(1001.33118, 36.3147125, -10986.2178, -0.996191859, 0, -0.0871884301, 0, 1, 0, 0.0871884301, 0, -0.996191859)
end)

-- Принудительное отображение интерфейса
if game:GetService("CoreGui"):FindFirstChild("Elerium") then
    game:GetService("CoreGui").Elerium.Enabled = true
end
