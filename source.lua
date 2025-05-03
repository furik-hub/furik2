-- Убедитесь что это ВЕСЬ текст в файле!
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

-- Настройки
local TELEGRAM_LINK = "https://t.me/+gFW93RBjwXQ4YTBi"
local REQUIRED_CLICKS = 3
local currentClicks = 0
local IS_MOBILE = UIS.TouchEnabled

-- Все скрипты (добавьте свои)
local SCRIPTS = {
    ["Blox Fruits"] = {
        load = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/main/Source.luau"))()
        end
    },
    ["Noclip"] = {
        load = function()
            local noclip = false
            game:GetService('RunService').Stepped:Connect(function()
                if noclip and Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            noclip = not noclip
            return noclip and "Noclip: ON" or "Noclip: OFF"
        end
    }
}

-- Создаём красивое меню
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FurikHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Parent = ScreenGui

-- Кнопки для скриптов
local yPosition = 80
for name, data in pairs(SCRIPTS) do
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0, 460, 0, 50)
    button.Position = UDim2.new(0, 20, 0, yPosition)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.Parent = MainFrame
    
    button.MouseButton1Click:Connect(function()
        button.Text = "Loading..."
        local result = data.load()
        if result then
            button.Text = result
        else
            button.Text = name
        end
    end)
    
    yPosition = yPosition + 60
end

-- Кнопка подтверждения подписки
local confirmButton = Instance.new("TextButton")
confirmButton.Text = "Подтвердить подписку ("..REQUIRED_CLICKS..")"
confirmButton.Size = UDim2.new(0, 200, 0, 50)
confirmButton.Position = UDim2.new(0.5, -100, 0, 20)
confirmButton.AnchorPoint = Vector2.new(0.5, 0)
confirmButton.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
confirmButton.Parent = MainFrame

confirmButton.MouseButton1Click:Connect(function()
    currentClicks = currentClicks + 1
    if currentClicks >= REQUIRED_CLICKS then
        confirmButton.Text = "Доступ открыт!"
        confirmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        confirmButton.Text = "Подтвердить подписку ("..(REQUIRED_CLICKS-currentClicks)..")"
    end
end)

-- Анимация появления
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 500, 0, 400)}):Play()
