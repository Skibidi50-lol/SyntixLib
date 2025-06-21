local Syntix = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Sounds
local HoverSound = Instance.new("Sound")
HoverSound.SoundId = "rbxassetid://9114454769"
HoverSound.Volume = 0.5

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://452267918"
ClickSound.Volume = 0.7

-- CreateWindow Function
local function CreateWindow(windowName)
    local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = windowName
    ScreenGui.ResetOnSpawn = false
    HoverSound.Parent = ScreenGui
    ClickSound.Parent = ScreenGui

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", MainFrame)
    local stroke = Instance.new("UIStroke", MainFrame)
    stroke.Color = Color3.fromRGB(175, 175, 175)
    stroke.Thickness = 3

    local Sidebar = Instance.new("ScrollingFrame", MainFrame)
    Sidebar.Size = UDim2.new(0, 120, 1, 0)
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 1000)
    Sidebar.ScrollBarThickness = 6
    Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
    Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, -35)
    Title.Text = windowName
    Title.TextColor3 = Color3.fromRGB(200, 200, 200)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Center

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -130, 1, -20)
    ContentFrame.Position = UDim2.new(0, 130, 0, 10)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", ContentFrame)

    -- Make MainFrame draggable
    local dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragStart = nil
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragStart then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    local Syntix = {}

function Syntix:CreateWindow(name)
    return CreateWindow(name)
end

function Syntix:MakeTab(window, name, icon)
    return MakeTab(window, name, icon)
end

function Syntix:AddToggle(tab, name, default, callback, y)
    return AddToggle(tab, name, default, callback, y)
end

function Syntix:AddButton(tab, name, callback, y)
    return AddButton(tab, name, callback, y)
end

function Syntix:CreateSection(tab, name, y)
    return CreateSection(tab, name, y)
end

return Syntix

-- MakeTab Function
local function MakeTab(window, text, robloxicon)
    local tab = Instance.new("ScrollingFrame", window.Content)
    tab.Name = text
    tab.Size = UDim2.new(1, -10, 1, -10)
    tab.Position = UDim2.new(0, 5, 0, 5)
    tab.CanvasSize = UDim2.new(0, 0, 0, 1000)
    tab.ScrollBarThickness = 6
    tab.BackgroundTransparency = 1
    tab.Visible = #window.Tabs == 0

    local order = #window.Tabs + 1
    local button = Instance.new("TextButton", window.Sidebar)
    button.Size = UDim2.new(0, 120, 0, 35)
    button.Position = UDim2.new(0, (order - 1) * 130 + 5, 0, 5)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.Text = ""
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12

    local icon = Instance.new("ImageLabel", button)
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 6, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = robloxicon

    local label = Instance.new("TextLabel", button)
    label.Size = UDim2.new(1, -28, 1, 0)
    label.Position = UDim2.new(0, 28, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextScaled = false
    label.ClipsDescendants = true

    local icon = Instance.new("ImageLabel", button)
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 5, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = robloxicon

    Instance.new("UICorner", button)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        HoverSound:Play()
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    button.MouseButton1Click:Connect(function()
        for _, other in ipairs(window.Tabs) do
            other.Frame.Visible = false
        end
        tab.Visible = true
        ClickSound:Play()
    end)

    table.insert(window.Tabs, { Name = text, Frame = tab, Button = button })
    return tab
end

-- AddButton Function
local function AddButton(tab, name, callback, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 30)
    button.Position = UDim2.new(0, 10, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Parent = tab

    Instance.new("UICorner", button)
    Instance.new("UIStroke", button).Color = Color3.fromRGB(90, 90, 90)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    button.MouseButton1Click:Connect(callback)
end

-- CreateSection
local function CreateSection(tab, name, y)
    local label = Instance.new("TextLabel", tab)
    label.Text = name
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, y)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    return y + 25
end

-- AddToggle
local function AddToggle(tab, name, default, callback, y)
    local val = Instance.new("BoolValue")
    val.Value = default
    val.Name = name .. "Toggle"

    local frame = Instance.new("Frame", tab)
    frame.Size = UDim2.new(0, 200, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Text = name
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("Frame", frame)
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(0, 130, 0.5, -10)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", toggle)

    local circle = Instance.new("Frame", toggle)
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = default and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
    circle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", circle)
    Instance.new("UIStroke", toggle).Color = Color3.fromRGB(90, 90, 90)

    local function update()
        toggle.BackgroundColor3 = val.Value and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(50, 50, 50)
        circle:TweenPosition(val.Value and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2), "Out", "Quad", 0.15, true)
    end

    update()

    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            val.Value = not val.Value
            update()
            callback(val.Value)
        end
    end)
end

(function()
    ClickSound:Play()
    window.MainFrame.Visible = not window.MainFrame.Visible
end)
