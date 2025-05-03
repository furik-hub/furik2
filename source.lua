--[[
  Furik Ultimate Hub v6.0
  Полная версия с проверкой подписки и хабом скриптов
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer

-- Настройки
local TELEGRAM_LINK = "https://t.me/+gFW93RBjwXQ4YTBi"
local VERSION = "v6.0"
local REQUIRED_CLICKS = 3
local currentClicks = 0
local IS_MOBILE = UIS.TouchEnabled

-- Все скрипты
local SCRIPTS = {
    ["Murder Mystery 2"] = {
        url = "https://raw.githubusercontent.com/XhubPrem/Universal/main/script.lua",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/XhubPrem/Universal/main/script.lua"))()
        end
    },
    ["Blox Fruits (Redz Hub)"] = {
        url = "https://raw.githubusercontent.com/newredz/BloxFruits/main/Source.luau",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/main/Source.luau"))({
                AutoFarm = true,
                AutoSeaBeast = true
            })
        end
    },
    ["Blox Fruits (Atak)"] = {
        url = "https://raw.githubusercontent.com/KOBENFF/sdfd/main/Koatta.txt",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/KOBENFF/sdfd/main/Koatta.txt"))()
        end
    },
    ["Rivals"] = {
        url = "https://soluna-script.vercel.app/main.lua",
        load = function()
            return loadstring(game:HttpGet("https://soluna-script.vercel.app/main.lua", true))()
        end
    },
    ["Grow a Garden"] = {
        url = "https://raw.githubusercontent.com/ago106/SpaceHub/main/Multi",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/ago106/SpaceHub/main/Multi"))()
        end
    },
    ["FISCH"] = {
        url = "https://you.whimper.xyz/sources/rb/fisch.lua",
        load = function()
            return loadstring(game:HttpGet("https://you.whimper.xyz/sources/rb/fisch.lua"))()
        end
    },
    ["BREAK IN"] = {
        url = "https://raw.githubusercontent.com/jdihdzzzhack/Auto-Get-by-draksel-Tg-Vomagla/main/Эаа",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/jdihdzzzhack/Auto-Get-by-draksel-Tg-Vomagla/main/Эаа"))()
        end
    },
    ["BASKETBALL LEGENDS"] = {
        url = "https://raw.githubusercontent.com/RadeonScripts/RadeonHubMain/main/MainRobloxExploit",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/RadeonScripts/RadeonHubMain/main/MainRobloxExploit"))()
        end
    },
    ["BROOKHAVEN"] = {
        url = "https://raw.githubusercontent.com/Luarmor123/YHUB-Community/main/AutoFarmBrookhaven.lua",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/Luarmor123/YHUB-Community/main/AutoFarmBrookhaven.lua"))()
        end
    },
    ["Dead Rails (Облигации)"] = {
        url = "https://raw.githubusercontent.com/gumanba/Scripts/main/DeadRails",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/DeadRails", true))()
        end
    },
    ["Dead Rails (Премиум)"] = {
        url = "https://rawscripts.net/raw/Dead-Rails-Alpha-Dead-Rails-OP-KiciaHook-Script-Fastest-Auto-Farm-35961",
        load = function()
            return loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-Dead-Rails-OP-KiciaHook-Script-Fastest-Auto-Farm-35961"))()
        end
    },
    ["Fly Script"] = {
        url = "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        end
    },
    ["Noclip (Вкл/Выкл)"] = {
        url = "N/A",
        load = function()
            local noclipActive = false
            local connection
            
            local function toggle()
                noclipActive = not noclipActive
                if noclipActive then
                    if connection then connection:Disconnect() end
                    connection = game:GetService('RunService').Stepped:Connect(function()
                        if Player.Character then
                            for _, part in pairs(Player.Character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)
                    return "NOCLIP: ВКЛЮЧЕН"
                else
                    if connection then connection:Disconnect() end
                    return "NOCLIP: ВЫКЛЮЧЕН"
                end
            end
            
            return toggle()
        end
    },
    ["Blade Ball"] = {
        url = "https://raw.githubusercontent.com/sirapobsriumang/Blade-ball/main/Blade-ball-free",
        load = function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/sirapobsriumang/Blade-ball/main/Blade-ball-free"))()
        end
    }
}

-- Создание кликабельной ссылки
local function CreateClickableLink(parent, positionY)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -40, 0, 30)
    frame.Position = UDim2.new(0, 20, 0, positionY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Image = "rbxassetid://3926305904"
    icon.BackgroundTransparency = 1
    icon.Parent = frame

    local linkLabel = Instance.new("TextButton")
    linkLabel.Size = UDim2.new(1, -25, 1, 0)
    linkLabel.Position = UDim2.new(0, 25, 0, 0)
    linkLabel.Text = TELEGRAM_LINK
    linkLabel.Font = Enum.Font.Gotham
    linkLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    linkLabel.TextSize = 16
    linkLabel.TextXAlignment = Enum.TextXAlignment.Left
    linkLabel.BackgroundTransparency = 1
    linkLabel.Parent = frame

    local underline = Instance.new("Frame")
    underline.Size = UDim2.new(1, -25, 0, 1)
    underline.Position = UDim2.new(0, 25, 1, -2)
    underline.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    underline.BorderSizePixel = 0
    underline.Parent = frame

    linkLabel.MouseButton1Click:Connect(function()
        pcall(function()
            TeleportService:OpenBrowserWindow(TELEGRAM_LINK)
        end)
    end)
    
    return frame
end

-- Создание основного хаба
local function CreateMainHub()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FurikScriptHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = IS_MOBILE and UDim2.new(0.95, 0, 0, 0) or UDim2.new(0.45, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 14)
    UICorner.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(80, 80, 100)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- Заголовок с поиском
    local TitleFrame = Instance.new("Frame")
    TitleFrame.Size = UDim2.new(1, 0, 0.15, 0)
    TitleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    TitleFrame.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 14)
    TitleCorner.Parent = TitleFrame

    local Title = Instance.new("TextLabel")
    Title.Text = "FURIK SCRIPT HUB"
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = IS_MOBILE and 22 or 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Size = UDim2.new(0.5, 0, 0.5, 0)
    Title.Position = UDim2.new(0.02, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleFrame

    -- Поле поиска
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(0.6, 0, 0.5, 0)
    SearchBox.Position = UDim2.new(0.4, 0, 0.25, 0)
    SearchBox.PlaceholderText = "Поиск скриптов..."
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.TextSize = 14
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    SearchBox.Parent = TitleFrame

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 8)
    SearchCorner.Parent = SearchBox

    local SearchPadding = Instance.new("UIPadding")
    SearchPadding.PaddingLeft = UDim.new(0, 10)
    SearchPadding.Parent = SearchBox

    -- Список игр
    local GameList = Instance.new("ScrollingFrame")
    GameList.Size = UDim2.new(1, -20, 0.75, -10)
    GameList.Position = UDim2.new(0, 10, 0.2, 0)
    GameList.BackgroundTransparency = 1
    GameList.ScrollBarThickness = 6
    GameList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GameList.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 12)
    UIListLayout.Parent = GameList

    -- Мини-кнопка
    local MiniButton = Instance.new("TextButton")
    MiniButton.Size = UDim2.new(0, 50, 0, 50)
    MiniButton.Position = UDim2.new(0, 20, 0.5, 0)
    MiniButton.AnchorPoint = Vector2.new(0, 0.5)
    MiniButton.Text = "≡"
    MiniButton.Font = Enum.Font.GothamBold
    MiniButton.TextSize = 24
    MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiniButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    MiniButton.Visible = false
    MiniButton.ZIndex = 2
    MiniButton.Parent = ScreenGui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 12)
    MiniCorner.Parent = MiniButton

    -- Функция создания кнопки скрипта
    local function CreateScriptButton(gameName, data, parent)
        local Button = Instance.new("TextButton")
        Button.Name = gameName
        Button.Text = gameName
        Button.Size = UDim2.new(1, 0, 0, IS_MOBILE and 60 or 50)
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 16
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        Button.AutoButtonColor = false
        Button.Parent = parent
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = Button
        
        local ButtonStroke = Instance.new("UIStroke")
        ButtonStroke.Color = Color3.fromRGB(80, 80, 120)
        ButtonStroke.Thickness = 1
        ButtonStroke.Parent = Button
        
        -- Анимация кнопки
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(70, 70, 100),
                TextColor3 = Color3.fromRGB(255, 180, 0)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 70),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end)
        
        -- Загрузка скрипта
        Button.MouseButton1Click:Connect(function()
            Button.Text = "ЗАГРУЗКА..."
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            }):Play()
            
            local success, err = pcall(function()
                data.load()
            end)
            
            if success then
                Button.Text = "УСПЕШНО!"
                task.wait(1)
                Button.Text = gameName
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                }):Play()
            else
                Button.Text = "ОШИБКА!"
                warn("Ошибка загрузки скрипта "..gameName..": "..err)
                task.wait(1)
                Button.Text = gameName
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                }):Play()
            end
        end)
        
        return Button
    end

    -- Создание всех кнопок
    local allButtons = {}
    for gameName, data in pairs(SCRIPTS) do
        local btn = CreateScriptButton(gameName, data, GameList)
        table.insert(allButtons, btn)
    end

    -- Функция поиска
    local function UpdateSearch()
        local searchText = string.lower(SearchBox.Text)
        
        for _, button in ipairs(allButtons) do
            if searchText == "" or string.find(string.lower(button.Name), searchText) then
                button.Visible = true
            else
                button.Visible = false
            end
        end
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateSearch)

    -- Функции сворачивания/разворачивания
    local function Minimize()
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.5)
        MainFrame.Visible = false
        MiniButton.Visible = true
    end

    local function Maximize()
        MiniButton.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
            Size = IS_MOBILE and UDim2.new(0.95, 0, 0.8, 0) or UDim2.new(0.45, 0, 0.7, 0)
        }):Play()
    end

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "─"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -45, 0, 5)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Parent = MainFrame

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(Minimize)
    MiniButton.MouseButton1Click:Connect(Maximize)

    -- Плавное появление
    task.wait(0.1)
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Size = IS_MOBILE and UDim2.new(0.95, 0, 0.8, 0) or UDim2.new(0.45, 0, 0.7, 0)
    }):Play()

    return ScreenGui
end

-- Окно подписки
local function ShowSubscriptionWindow()
    local SubscriptionUI = Instance.new("ScreenGui")
    SubscriptionUI.Name = "FurikSubscriptionUI"
    SubscriptionUI.ResetOnSpawn = false
    SubscriptionUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SubscriptionUI.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 350)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Parent = SubscriptionUI

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 60, 60)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Text = "ТРЕБУЕТСЯ ПОДПИСКА"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 22
    Title.BackgroundTransparency = 1
    Title.Parent = MainFrame

    -- Иконка замка
    local LockIcon = Instance.new("ImageLabel")
    LockIcon.Size = UDim2.new(0, 80, 0, 80)
    LockIcon.Position = UDim2.new(0.5, -40, 0, 60)
    LockIcon.Image = "rbxassetid://7072718362"
    LockIcon.BackgroundTransparency = 1
    LockIcon.Parent = MainFrame

    -- Основной текст
    local MainText = Instance.new("TextLabel")
    MainText.Size = UDim2.new(1, -40, 0, 60)
    MainText.Position = UDim2.new(0, 20, 0, 150)
    MainText.Text = "Доступ к Furik Mega Hub возможен только для подписчиков нашего Telegram-канала. Подписка обязательна для использования всех функций."
    MainText.Font = Enum.Font.Gotham
    MainText.TextColor3 = Color3.fromRGB(200, 200, 200)
    MainText.TextSize = 14
    MainText.TextWrapped = true
    MainText.BackgroundTransparency = 1
    MainText.Parent = MainFrame

    -- Ссылка на Telegram
    CreateClickableLink(MainFrame, 210)

    -- Кнопка подтверждения
    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Size = UDim2.new(0, 200, 0, 45)
    ConfirmButton.Position = UDim2.new(0.5, -100, 1, -70)
    ConfirmButton.Text = "ПОДТВЕРДИТЬ ПОДПИСКУ"
    ConfirmButton.Font = Enum.Font.GothamBold
    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmButton.TextSize = 16
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(106, 27, 154)
    ConfirmButton.Parent = MainFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ConfirmButton

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = Color3.fromRGB(140, 50, 180)
    ButtonStroke.Thickness = 2
    ButtonStroke.Parent = ConfirmButton

    -- Обработчик кнопки
    ConfirmButton.MouseButton1Click:Connect(function()
        currentClicks = currentClicks + 1
        
        -- Анимация нажатия
        TweenService:Create(ConfirmButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 190, 0, 43)}):Play()
        task.wait(0.1)
        TweenService:Create(ConfirmButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 200, 0, 45)}):Play()
        
        if currentClicks >= REQUIRED_CLICKS then
            ConfirmButton.Text = "ЗАГРУЗКА HUB..."
            ConfirmButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            task.wait(0.8)
            SubscriptionUI:Destroy()
            CreateMainHub() -- Переходим к хабу скриптов
        else
            ConfirmButton.Text = "ПОДТВЕРЖДАЕТСЯ..."
            task.wait(0.3)
            ConfirmButton.Text = "ПОДТВЕРДИТЬ ПОДПИСКУ"
        end
    end)

    -- Кнопка копирования
    local CopyButton = Instance.new("TextButton")
    CopyButton.Size = UDim2.new(0, 200, 0, 30)
    CopyButton.Position = UDim2.new(0.5, -100, 0, 240)
    CopyButton.Text = "СКОПИРОВАТЬ ССЫЛКУ"
    CopyButton.Font = Enum.Font.Gotham
    CopyButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    CopyButton.TextSize = 14
    CopyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CopyButton.Parent = MainFrame

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyButton

    CopyButton.MouseButton1Click:Connect(function()
        setclipboard(TELEGRAM_LINK)
        CopyButton.Text = "ССЫЛКА СКОПИРОВАНА!"
        task.wait(1.5)
        CopyButton.Text = "СКОПИРОВАТЬ ССЫЛКУ"
    end)

    -- Анимация появления
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 350)}):Play()

    return SubscriptionUI
end

-- Запуск системы
ShowSubscriptionWindow()
