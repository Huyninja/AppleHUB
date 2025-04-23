--[[
    Apple HUB | UI Library
    Created by: Huyninja
    
    Features:
    - Window System
    - Tab System
    - Section System
    - Key System (Authentication)
    - Various Elements (Buttons, Toggles, Sliders, Dropdowns, etc.)
    - Notifications
    - Keybind Selection
    - Minimize/Maximize
]]

local AppleHub = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Utility Functions
local function DarkenColor(color, amount)
    return Color3.new(
        math.clamp(color.R - amount, 0, 1),
        math.clamp(color.G - amount, 0, 1),
        math.clamp(color.B - amount, 0, 1)
    )
end

local function LightenColor(color, amount)
    return Color3.new(
        math.clamp(color.R + amount, 0, 1),
        math.clamp(color.G + amount, 0, 1),
        math.clamp(color.B + amount, 0, 1)
    )
end

-- Default Theme
AppleHub.Theme = {
    Background = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(185, 25, 25),
    LightContrast = Color3.fromRGB(40, 40, 45),
    DarkContrast = Color3.fromRGB(25, 25, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementBackColor = Color3.fromRGB(45, 45, 50),
    ElementBorderColor = Color3.fromRGB(60, 60, 65)
}

-- Change Theme Function
function AppleHub.SetTheme(theme)
    for key, value in pairs(theme) do
        if AppleHub.Theme[key] then
            AppleHub.Theme[key] = value
        end
    end
end

-- Key System
AppleHub.KeySystem = {}
AppleHub.KeySystem.__index = AppleHub.KeySystem

function AppleHub.CreateKeySystem(title, subtitle, keys)
    local keySystem = setmetatable({}, AppleHub.KeySystem)
    keySystem.Title = title or "Apple HUB | By Huyninja"
    keySystem.Subtitle = subtitle or "Key System"
    keySystem.Keys = keys or {"AppleHubDefault"}
    keySystem.CorrectKey = false
    
    keySystem:CreateUI()
    
    return keySystem
end

function AppleHub.KeySystem:CreateUI()
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "AppleHubKeySystem"
    
    -- Use protection methods if available
    if syn and syn.protect_gui then
        syn.protect_gui(self.ScreenGui)
        self.ScreenGui.Parent = CoreGui
    elseif gethui then
        self.ScreenGui.Parent = gethui()
    else
        self.ScreenGui.Parent = LocalPlayer.PlayerGui
    end
    
    -- Create main frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, 300, 0, 200)
    self.MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    self.MainFrame.BackgroundColor3 = AppleHub.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.MainFrame
    
    -- Title
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "TitleLabel"
    self.TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = AppleHub.Theme.TextColor
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextSize = 18
    self.TitleLabel.Parent = self.MainFrame
    
    -- Subtitle
    self.SubtitleLabel = Instance.new("TextLabel")
    self.SubtitleLabel.Name = "SubtitleLabel"
    self.SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
    self.SubtitleLabel.Position = UDim2.new(0, 0, 0, 30)
    self.SubtitleLabel.BackgroundTransparency = 1
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.SubtitleLabel.Font = Enum.Font.Gotham
    self.SubtitleLabel.TextSize = 14
    self.SubtitleLabel.Parent = self.MainFrame
    
    -- Key Input
    self.KeyInput = Instance.new("TextBox")
    self.KeyInput.Name = "KeyInput"
    self.KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
    self.KeyInput.Position = UDim2.new(0.1, 0, 0.5, -17.5)
    self.KeyInput.BackgroundColor3 = AppleHub.Theme.ElementBackColor
    self.KeyInput.BorderSizePixel = 0
    self.KeyInput.PlaceholderText = "Enter Key..."
    self.KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    self.KeyInput.Text = ""
    self.KeyInput.TextColor3 = AppleHub.Theme.TextColor
    self.KeyInput.Font = Enum.Font.Gotham
    self.KeyInput.TextSize = 14
    self.KeyInput.ClearTextOnFocus = false
    self.KeyInput.Parent = self.MainFrame
    
    -- Input Corner
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = self.KeyInput
    
    -- Submit Button
    self.SubmitButton = Instance.new("TextButton")
    self.SubmitButton.Name = "SubmitButton"
    self.SubmitButton.Size = UDim2.new(0.8, 0, 0, 35)
    self.SubmitButton.Position = UDim2.new(0.1, 0, 0.5, 30)
    self.SubmitButton.BackgroundColor3 = AppleHub.Theme.Accent
    self.SubmitButton.BorderSizePixel = 0
    self.SubmitButton.Text = "Submit"
    self.SubmitButton.TextColor3 = AppleHub.Theme.TextColor
    self.SubmitButton.Font = Enum.Font.GothamBold
    self.SubmitButton.TextSize = 14
    self.SubmitButton.AutoButtonColor = false
    self.SubmitButton.Parent = self.MainFrame
    
    -- Button Corner
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = self.SubmitButton
    
    -- Status Label
    self.StatusLabel = Instance.new("TextLabel")
    self.StatusLabel.Name = "StatusLabel"
    self.StatusLabel.Size = UDim2.new(1, 0, 0, 20)
    self.StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
    self.StatusLabel.BackgroundTransparency = 1
    self.StatusLabel.Text = ""
    self.StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.StatusLabel.Font = Enum.Font.Gotham
    self.StatusLabel.TextSize = 14
    self.StatusLabel.Parent = self.MainFrame
    
    -- Setup button effects
    self.SubmitButton.MouseEnter:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
            BackgroundColor3 = LightenColor(AppleHub.Theme.Accent, 0.1)
        }):Play()
    end)
    
    self.SubmitButton.MouseLeave:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.2), {
            BackgroundColor3 = AppleHub.Theme.Accent
        }):Play()
    end)
    
    self.SubmitButton.MouseButton1Down:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.1), {
            BackgroundColor3 = DarkenColor(AppleHub.Theme.Accent, 0.1)
        }):Play()
    end)
    
    self.SubmitButton.MouseButton1Up:Connect(function()
        TweenService:Create(self.SubmitButton, TweenInfo.new(0.1), {
            BackgroundColor3 = LightenColor(AppleHub.Theme.Accent, 0.1)
        }):Play()
    end)
    
    -- Verify key
    self.SubmitButton.MouseButton1Click:Connect(function()
        local input = self.KeyInput.Text
        
        for _, key in ipairs(self.Keys) do
            if input == key then
                self.StatusLabel.Text = "Correct key! Loading..."
                self.StatusLabel.TextColor3 = Color3.fromRGB(50, 205, 50)
                self.CorrectKey = true
                wait(1)
                self.ScreenGui:Destroy()
                if self.OnSuccess then
                    self.OnSuccess()
                end
                return
            end
        end
        
        self.StatusLabel.Text = "Invalid key! Please try again."
        self.StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        
        TweenService:Create(self.KeyInput, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 3, true), {
            Position = UDim2.new(0.1, -10, 0.5, -17.5),
        }):Play()
    end)
end

function AppleHub.KeySystem:OnCorrectKey(callback)
    self.OnSuccess = callback
    
    -- Return a promise-like interface that resolves when the key is correct
    local thread = coroutine.running()
    
    if self.CorrectKey then
        return true
    else
        spawn(function()
            while not self.CorrectKey do
                wait(0.1)
            end
            coroutine.resume(thread, true)
        end)
    end
    
    return coroutine.yield()
end

-- Library Main UI
AppleHub.Library = {}
AppleHub.Library.__index = AppleHub.Library

function AppleHub.CreateWindow(title, subtitle)
    local window = setmetatable({}, AppleHub.Library)
    window.Title = title or "Apple HUB | By Huyninja"
    window.Subtitle = subtitle or "v1.0"
    window.Minimized = false
    window.Tabs = {}
    window.ActiveTab = nil
    window.TabCount = 0
    
    window:CreateUI()
    
    return window
end

function AppleHub.Library:CreateUI()
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "AppleHubUI"
    
    -- Use protection methods if available
    if syn and syn.protect_gui then
        syn.protect_gui(self.ScreenGui)
        self.ScreenGui.Parent = CoreGui
    elseif gethui then
        self.ScreenGui.Parent = gethui()
    else
        self.ScreenGui.Parent = LocalPlayer.PlayerGui
    end
    
    -- Create main frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, 550, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    self.MainFrame.BackgroundColor3 = AppleHub.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Active = true
    self.MainFrame.Parent = self.ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.MainFrame
    
    -- Make draggable
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    self.MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Header
    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.Size = UDim2.new(1, 0, 0, 40)
    self.Header.BackgroundColor3 = DarkenColor(AppleHub.Theme.Background, 0.05)
    self.Header.BorderSizePixel = 0
    self.Header.Parent = self.MainFrame
    
    -- Header corner
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = self.Header
    
    -- Header fix (to avoid rounded corners at the bottom)
    local headerFix = Instance.new("Frame")
    headerFix.Name = "HeaderFix"
    headerFix.Size = UDim2.new(1, 0, 0, 10)
    headerFix.Position = UDim2.new(0, 0, 1, -10)
    headerFix.BackgroundColor3 = DarkenColor(AppleHub.Theme.Background, 0.05)
    headerFix.BorderSizePixel = 0
    headerFix.ZIndex = 0
    headerFix.Parent = self.Header
    
    -- Title
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "TitleLabel"
    self.TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = AppleHub.Theme.TextColor
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextSize = 16
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Parent = self.Header
    
    -- Subtitle
    self.SubtitleLabel = Instance.new("TextLabel")
    self.SubtitleLabel.Name = "SubtitleLabel"
    self.SubtitleLabel.Size = UDim2.new(0.3, -50, 1, 0)
    self.SubtitleLabel.Position = UDim2.new(0.7, 0, 0, 0)
    self.SubtitleLabel.BackgroundTransparency = 1
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    self.SubtitleLabel.Font = Enum.Font.Gotham
    self.SubtitleLabel.TextSize = 14
    self.SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.SubtitleLabel.Parent = self.Header
    
    -- Minimize Button
    self.MinimizeButton = Instance.new("TextButton")
    self.MinimizeButton.Name = "MinimizeButton"
    self.MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    self.MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
    self.MinimizeButton.BackgroundColor3 = DarkenColor(AppleHub.Theme.Background, 0.1)
    self.MinimizeButton.BorderSizePixel = 0
    self.MinimizeButton.Text = "-"
    self.MinimizeButton.TextColor3 = AppleHub.Theme.TextColor
    self.MinimizeButton.Font = Enum.Font.GothamBold
    self.MinimizeButton.TextSize = 18
    self.MinimizeButton.AutoButtonColor = false
    self.MinimizeButton.Parent = self.Header
    
    -- Minimize Button Corner
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = self.MinimizeButton
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(1, 0, 0, 30)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 40)
    self.TabContainer.BackgroundColor3 = AppleHub.Theme.LightContrast
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.MainFrame
    
    -- Content Container
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Size = UDim2.new(1, 0, 1, -70)
    self.ContentContainer.Position = UDim2.new(0, 0, 0, 70)
    self.ContentContainer.BackgroundColor3 = AppleHub.Theme.Background
    self.ContentContainer.BorderSizePixel = 0
    self.ContentContainer.ClipsDescendants = true
    self.ContentContainer.Parent = self.MainFrame
    
    -- Tab Buttons Layout
    self.TabButtonsLayout = Instance.new("UIListLayout")
    self.TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
    self.TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabButtonsLayout.Padding = UDim.new(0, 0)
    self.TabButtonsLayout.Parent = self.TabContainer
    
    -- Setup Minimize Button functionality
    self.MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(self.MinimizeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = DarkenColor(AppleHub.Theme.Background, 0.15)
        }):Play()
    end)
    
    self.MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(self.MinimizeButton, TweenInfo.new(0.2), {
            BackgroundColor3 = DarkenColor(AppleHub.Theme.Background, 0.1)
        }):Play()
    end)
    
    self.MinimizeButton.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    -- Notification Frame
    self.NotificationFrame = Instance.new("Frame")
    self.NotificationFrame.Name = "NotificationFrame"
    self.NotificationFrame.Size = UDim2.new(0, 250, 1, 0)
    self.NotificationFrame.Position = UDim2.new(1, 10, 0, 0)
    self.NotificationFrame.BackgroundTransparency = 1
    self.NotificationFrame.Parent = self.MainFrame
    
    -- Notification Layout
    self.NotificationLayout = Instance.new("UIListLayout")
    self.NotificationLayout.FillDirection = Enum.FillDirection.Vertical
    self.NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.NotificationLayout.Padding = UDim.new(0, 5)
    self.NotificationLayout.Parent = self.NotificationFrame
end

function AppleHub.Library:ToggleMinimize()
    self.Minimized = not self.Minimized
    
    if self.Minimized then
        self.MinimizeButton.Text = "+"
        TweenService:Create(self.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 550, 0, 40)
        }):Play()
    else
        self.MinimizeButton.Text = "-"
        TweenService:Create(self.MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 550, 0, 400)
        }):Play()
    end
end

function AppleHub.Library:AddTab(name, icon)
    local tab = {}
    tab.Name = name
    tab.Icon = icon
    tab.Sections = {}
    tab.SectionCount = 0
    
    -- Tab Button
    tab.Button = Instance.new("TextButton")
    tab.Button.Name = name .. "Button"
    tab.Button.Size = UDim2.new(0, 100, 1, 0)
    tab.Button.BackgroundColor3 = AppleHub.Theme.LightContrast
    tab.Button.BorderSizePixel = 0
    tab.Button.Text = name
    tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    tab.Button.Font = Enum.Font.Gotham
    tab.Button.TextSize = 14
    tab.Button.AutoButtonColor = false
    tab.Button.Parent = self.TabContainer
    
    -- Tab Icon (optional)
    if icon then
        local iconImage = Instance.new("ImageLabel")
        iconImage.Name = "IconImage"
        iconImage.Size = UDim2.new(0, 16, 0, 16)
        iconImage.Position = UDim2.new(0, 10, 0.5, -8)
        iconImage.BackgroundTransparency = 1
        iconImage.Image = icon
        iconImage.Parent = tab.Button
        
        tab.Button.Text = "   " .. name
        tab.Button.TextXAlignment = Enum.TextXAlignment.Center
    end
    
    -- Tab Content Frame
    tab.Content = Instance.new("ScrollingFrame")
    tab.Content.Name = name .. "Content"
    tab.Content.Size = UDim2.new(1, 0, 1, 0)
    tab.Content.BackgroundTransparency = 1
    tab.Content.BorderSizePixel = 0
    tab.Content.ScrollBarThickness = 2
    tab.Content.ScrollBarImageColor3 = AppleHub.Theme.Accent
    tab.Content.Visible = false
    tab.Content.Parent = self.ContentContainer
    
    -- Content Layout
    tab.ContentLayout = Instance.new("UIListLayout")
    tab.ContentLayout.FillDirection = Enum.FillDirection.Horizontal
    tab.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tab.ContentLayout.Padding = UDim.new(0, 10)
    tab.ContentLayout.Parent = tab.Content
    
    -- Content Padding
    tab.ContentPadding = Instance.new("UIPadding")
    tab.ContentPadding.PaddingLeft = UDim.new(0, 10)
    tab.ContentPadding.PaddingRight = UDim.new(0, 10)
    tab.ContentPadding.PaddingTop = UDim.new(0, 10)
    tab.ContentPadding.PaddingBottom = UDim.new(0, 10)
    tab.ContentPadding.Parent = tab.Content
    
    -- Select tab on click
    tab.Button.MouseButton1Click:Connect(function()
        self:SelectTab(tab.Name)
    end)
    
    -- Add hover effect
    tab.Button.MouseEnter:Connect(function()
        if self.ActiveTab ~= tab then
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = LightenColor(AppleHub.Theme.LightContrast, 0.05)
            }):Play()
        end
    end)
    
    tab.Button.MouseLeave:Connect(function()
        if self.ActiveTab ~= tab then
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = AppleHub.Theme.LightContrast
            }):Play()
        end
    end)
    
    -- Add to tabs table
    self.TabCount = self.TabCount + 1
    tab.Index = self.TabCount
    tab.LayoutOrder = self.TabCount
    tab.Button.LayoutOrder = self.TabCount
    
    self.Tabs[name] = tab
    
    -- Function to add sections to this tab
    function tab:AddSection(sectionName)
        self.SectionCount = self.SectionCount + 1
        
        local section = {}
        section.Name = sectionName
        section.Tab = self
        section.Elements = {}
        section.ElementCount = 0
        
        -- Section Frame
        section.Frame = Instance.new("Frame")
        section.Frame.Name = sectionName .. "Section"
        section.Frame.Size = UDim2.new(0, 250, 0, 0) -- Height will be auto-adjusted
        section.Frame.BackgroundColor3 = AppleHub.Theme.LightContrast
        section.Frame.BorderSizePixel = 0
        section.Frame.AutomaticSize = Enum.AutomaticSize.Y
        section.Frame.ClipsDescendants = false
        section.Frame.LayoutOrder = self.SectionCount
        section.Frame.Parent = self.Content
        
        -- Section Corner
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 6)
        sectionCorner.Parent = section.Frame
        
        -- Section Title
        section.Title = Instance.new("TextLabel")
        section.Title.Name = "Title"
        section.Title.Size = UDim2.new(1, 0, 0, 30)
        section.Title.BackgroundTransparency = 1
        section.Title.Text = "  " .. sectionName
        section.Title.TextColor3 = AppleHub.Theme.TextColor
        section.Title.Font = Enum.Font.GothamBold
        section.Title.TextSize = 14
        section.Title.TextXAlignment = Enum.TextXAlignment.Left
        section.Title.Parent = section.Frame
        
        -- Section Container
        section.Container = Instance.new("Frame")
        section.Container.Name = "Container"
        section.Container.Size = UDim2.new(1, 0, 0, 0) -- Will be auto-sized
        section.Container.Position = UDim2.new(0, 0, 0, 30)
        section.Container.BackgroundTransparency = 1
        section.Container.AutomaticSize = Enum.AutomaticSize.Y
        section.Container.Parent = section.Frame
        
        -- Container Layout
        section.Layout = Instance.new("UIListLayout")
        section.Layout.FillDirection = Enum.FillDirection.Vertical
        section.Layout.SortOrder = Enum.SortOrder.LayoutOrder
        section.Layout.Padding = UDim.new(0, 8)
        section.Layout.Parent = section.Container
        
        -- Container Padding
        section.Padding = Instance.new("UIPadding")
        section.Padding.PaddingLeft = UDim.new(0, 10)
        section.Padding.PaddingRight = UDim.new(0, 10)
        section.Padding.PaddingTop = UDim.new(0, 5)
        section.Padding.PaddingBottom = UDim.new(0, 10)
        section.Padding.Parent = section.Container
        
        -- Add elements to section
        function section:AddButton(buttonText, callback)
            self.ElementCount = self.ElementCount + 1
            
            local button = {}
            button.Text = buttonText
            button.Callback = callback or function() end
            
            -- Button Frame
            button.Frame = Instance.new("Frame")
            button.Frame.Name = "ButtonFrame"
            button.Frame.Size = UDim2.new(1, 0, 0, 32)
            button.Frame.BackgroundTransparency = 1
            button.Frame.LayoutOrder = self.ElementCount
            button.Frame.Parent = self.Container
            
            -- Button
            button.Button = Instance.new("TextButton")
            button.Button.Name = "Button"
            button.Button.Size = UDim2.new(1, 0, 1, 0)
            button.Button.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            button.Button.BorderSizePixel = 0
            button.Button.Text = buttonText
            button.Button.TextColor3 = AppleHub.Theme.TextColor
            button.Button.Font = Enum.Font.Gotham
            button.Button.TextSize = 14
            button.Button.AutoButtonColor = false
            button.Button.Parent = button.Frame
            
            -- Button Corner
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button.Button
                        
            -- Button effects
            button.Button.MouseEnter:Connect(function()
                TweenService:Create(button.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.1)
                }):Play()
            end)
            
            button.Button.MouseLeave:Connect(function()
                TweenService:Create(button.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = AppleHub.Theme.ElementBackColor
                }):Play()
            end)
            
            button.Button.MouseButton1Down:Connect(function()
                TweenService:Create(button.Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = DarkenColor(AppleHub.Theme.ElementBackColor, 0.1)
                }):Play()
            end)
            
            button.Button.MouseButton1Up:Connect(function()
                TweenService:Create(button.Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.1)
                }):Play()
            end)
            
            button.Button.MouseButton1Click:Connect(function()
                button.Callback()
            end)
            
            self.Elements[buttonText] = button
            return button
            end


        -- Add Toggle to section
        function section:AddToggle(toggleText, defaultValue, callback)
            self.ElementCount = self.ElementCount + 1
            
            local toggle = {}
            toggle.Text = toggleText
            toggle.Value = defaultValue or false
            toggle.Callback = callback or function() end
            
            -- Toggle Frame
            toggle.Frame = Instance.new("Frame")
            toggle.Frame.Name = "ToggleFrame"
            toggle.Frame.Size = UDim2.new(1, 0, 0, 32)
            toggle.Frame.BackgroundTransparency = 1
            toggle.Frame.LayoutOrder = self.ElementCount
            toggle.Frame.Parent = self.Container
            
            -- Toggle Label
            toggle.Label = Instance.new("TextLabel")
            toggle.Label.Name = "ToggleLabel"
            toggle.Label.Size = UDim2.new(1, -50, 1, 0)
            toggle.Label.BackgroundTransparency = 1
            toggle.Label.Text = toggleText
            toggle.Label.TextColor3 = AppleHub.Theme.TextColor
            toggle.Label.Font = Enum.Font.Gotham
            toggle.Label.TextSize = 14
            toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
            toggle.Label.Parent = toggle.Frame
            
            -- Toggle Button Background
            toggle.Background = Instance.new("Frame")
            toggle.Background.Name = "Background"
            toggle.Background.Size = UDim2.new(0, 40, 0, 20)
            toggle.Background.Position = UDim2.new(1, -45, 0.5, -10)
            toggle.Background.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            toggle.Background.BorderSizePixel = 0
            toggle.Background.Parent = toggle.Frame
            
            -- Background Corner
            local backgroundCorner = Instance.new("UICorner")
            backgroundCorner.CornerRadius = UDim.new(1, 0)
            backgroundCorner.Parent = toggle.Background
            
            -- Toggle Indicator
            toggle.Indicator = Instance.new("Frame")
            toggle.Indicator.Name = "Indicator"
            toggle.Indicator.Size = UDim2.new(0, 16, 0, 16)
            toggle.Indicator.Position = UDim2.new(0, 2, 0.5, -8)
            toggle.Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Indicator.BorderSizePixel = 0
            toggle.Indicator.Parent = toggle.Background
            
            -- Indicator Corner
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(1, 0)
            indicatorCorner.Parent = toggle.Indicator
            
            -- Set default state
            if toggle.Value then
                toggle.Background.BackgroundColor3 = AppleHub.Theme.Accent
                toggle.Indicator.Position = UDim2.new(1, -18, 0.5, -8)
                toggle.Callback(true)
            end
            
            -- Toggle Click Area
            toggle.ClickArea = Instance.new("TextButton")
            toggle.ClickArea.Name = "ClickArea"
            toggle.ClickArea.Size = UDim2.new(1, 0, 1, 0)
            toggle.ClickArea.BackgroundTransparency = 1
            toggle.ClickArea.Text = ""
            toggle.ClickArea.Parent = toggle.Frame
            
            -- Click functionality
            toggle.ClickArea.MouseButton1Click:Connect(function()
                toggle.Value = not toggle.Value
                
                if toggle.Value then
                    TweenService:Create(toggle.Background, TweenInfo.new(0.3), {
                        BackgroundColor3 = AppleHub.Theme.Accent
                    }):Play()
                    
                    TweenService:Create(toggle.Indicator, TweenInfo.new(0.3), {
                        Position = UDim2.new(1, -18, 0.5, -8)
                    }):Play()
                else
                    TweenService:Create(toggle.Background, TweenInfo.new(0.3), {
                        BackgroundColor3 = AppleHub.Theme.ElementBackColor
                    }):Play()
                    
                    TweenService:Create(toggle.Indicator, TweenInfo.new(0.3), {
                        Position = UDim2.new(0, 2, 0.5, -8)
                    }):Play()
                end
                
                toggle.Callback(toggle.Value)
            end)
            
            function toggle:Set(value)
                toggle.Value = value
                
                if toggle.Value then
                    toggle.Background.BackgroundColor3 = AppleHub.Theme.Accent
                    toggle.Indicator.Position = UDim2.new(1, -18, 0.5, -8)
                else
                    toggle.Background.BackgroundColor3 = AppleHub.Theme.ElementBackColor
                    toggle.Indicator.Position = UDim2.new(0, 2, 0.5, -8)
                end
                
                toggle.Callback(toggle.Value)
            end
            
            self.Elements[toggleText] = toggle
            return toggle
        end

        -- Add Slider to section
        function section:AddSlider(sliderText, minValue, maxValue, defaultValue, valueFormat, callback)
            self.ElementCount = self.ElementCount + 1
            
            local slider = {}
            slider.Text = sliderText
            slider.Min = minValue or 0
            slider.Max = maxValue or 100
            slider.Value = defaultValue or slider.Min
            slider.ValueFormat = valueFormat or "%.1f"
            slider.Callback = callback or function() end
            slider.Dragging = false
            
            -- Clamp default value within range
            slider.Value = math.clamp(slider.Value, slider.Min, slider.Max)
            
            -- Slider Frame
            slider.Frame = Instance.new("Frame")
            slider.Frame.Name = "SliderFrame"
            slider.Frame.Size = UDim2.new(1, 0, 0, 55)
            slider.Frame.BackgroundTransparency = 1
            slider.Frame.LayoutOrder = self.ElementCount
            slider.Frame.Parent = self.Container
            
            -- Slider Label
            slider.Label = Instance.new("TextLabel")
            slider.Label.Name = "SliderLabel"
            slider.Label.Size = UDim2.new(1, 0, 0, 20)
            slider.Label.BackgroundTransparency = 1
            slider.Label.Text = sliderText
            slider.Label.TextColor3 = AppleHub.Theme.TextColor
            slider.Label.Font = Enum.Font.Gotham
            slider.Label.TextSize = 14
            slider.Label.TextXAlignment = Enum.TextXAlignment.Left
            slider.Label.Parent = slider.Frame
            
            -- Value Display
            slider.ValueLabel = Instance.new("TextLabel")
            slider.ValueLabel.Name = "ValueLabel"
            slider.ValueLabel.Size = UDim2.new(0, 45, 0, 20)
            slider.ValueLabel.Position = UDim2.new(1, -45, 0, 0)
            slider.ValueLabel.BackgroundTransparency = 1
            slider.ValueLabel.Text = string.format(slider.ValueFormat, slider.Value)
            slider.ValueLabel.TextColor3 = AppleHub.Theme.TextColor
            slider.ValueLabel.Font = Enum.Font.Gotham
            slider.ValueLabel.TextSize = 14
            slider.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            slider.ValueLabel.Parent = slider.Frame
            
            -- Slider Background
            slider.Background = Instance.new("Frame")
            slider.Background.Name = "Background"
            slider.Background.Size = UDim2.new(1, 0, 0, 10)
            slider.Background.Position = UDim2.new(0, 0, 0.7, 0)
            slider.Background.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            slider.Background.BorderSizePixel = 0
            slider.Background.Parent = slider.Frame
            
            -- Background Corner
            local backgroundCorner = Instance.new("UICorner")
            backgroundCorner.CornerRadius = UDim.new(0, 5)
            backgroundCorner.Parent = slider.Background
            
            -- Slider Fill
            slider.Fill = Instance.new("Frame")
            slider.Fill.Name = "Fill"
            slider.Fill.BackgroundColor3 = AppleHub.Theme.Accent
            slider.Fill.BorderSizePixel = 0
            slider.Fill.Parent = slider.Background
            
            -- Fill Corner
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 5)
            fillCorner.Parent = slider.Fill
            
            -- Slider Knob
            slider.Knob = Instance.new("Frame")
            slider.Knob.Name = "Knob"
            slider.Knob.Size = UDim2.new(0, 16, 0, 16)
            slider.Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            slider.Knob.BorderSizePixel = 0
            slider.Knob.ZIndex = 2
            slider.Knob.Parent = slider.Background
            
            -- Knob Corner
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = slider.Knob
            
            -- Slider Click Area
            slider.ClickArea = Instance.new("TextButton")
            slider.ClickArea.Name = "ClickArea"
            slider.ClickArea.Size = UDim2.new(1, 0, 1, 0)
            slider.ClickArea.BackgroundTransparency = 1
            slider.ClickArea.Text = ""
            slider.ClickArea.Parent = slider.Background
            
            -- Update visuals based on default value
            local percentValue = (slider.Value - slider.Min) / (slider.Max - slider.Min)
            slider.Fill.Size = UDim2.new(percentValue, 0, 1, 0)
            slider.Knob.Position = UDim2.new(percentValue, -8, 0.5, -8)
            
            -- Slider functionality
            local function updateSlider(input)
                local sizeX = math.clamp((input.Position.X - slider.Background.AbsolutePosition.X) / slider.Background.AbsoluteSize.X, 0, 1)
                local newValue = slider.Min + ((slider.Max - slider.Min) * sizeX)
                slider.Value = newValue
                slider.ValueLabel.Text = string.format(slider.ValueFormat, slider.Value)
                slider.Fill.Size = UDim2.new(sizeX, 0, 1, 0)
                slider.Knob.Position = UDim2.new(sizeX, -8, 0.5, -8)
                slider.Callback(newValue)
            end
            
            slider.ClickArea.MouseButton1Down:Connect(function(input)
                slider.Dragging = true
                updateSlider(input)
            end)
            
            slider.ClickArea.MouseButton1Up:Connect(function()
                slider.Dragging = false
            end)
            
            slider.ClickArea.MouseMoved:Connect(function(input)
                if slider.Dragging then
                    updateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    slider.Dragging = false
                end
            end)
            
            function slider:Set(value)
                value = math.clamp(value, slider.Min, slider.Max)
                slider.Value = value
                
                local percentValue = (value - slider.Min) / (slider.Max - slider.Min)
                slider.ValueLabel.Text = string.format(slider.ValueFormat, value)
                slider.Fill.Size = UDim2.new(percentValue, 0, 1, 0)
                slider.Knob.Position = UDim2.new(percentValue, -8, 0.5, -8)
                
                slider.Callback(value)
            end
            
            self.Elements[sliderText] = slider
            return slider
        end

        -- Add Dropdown to section
        function section:AddDropdown(dropdownText, options, defaultIndex, callback)
            self.ElementCount = self.ElementCount + 1
            
            local dropdown = {}
            dropdown.Text = dropdownText
            dropdown.Options = options or {}
            dropdown.SelectedIndex = defaultIndex or 1
            dropdown.Open = false
            dropdown.Callback = callback or function() end
            
            -- Ensure selected index is valid
            if #dropdown.Options > 0 then
                dropdown.SelectedIndex = math.clamp(dropdown.SelectedIndex, 1, #dropdown.Options)
                dropdown.SelectedOption = dropdown.Options[dropdown.SelectedIndex]
            else
                dropdown.SelectedIndex = 0
                dropdown.SelectedOption = ""
            end
            
            -- Dropdown Frame
            dropdown.Frame = Instance.new("Frame")
            dropdown.Frame.Name = "DropdownFrame"
            dropdown.Frame.Size = UDim2.new(1, 0, 0, 55)
            dropdown.Frame.BackgroundTransparency = 1
            dropdown.Frame.LayoutOrder = self.ElementCount
            dropdown.Frame.Parent = self.Container
            
            -- Dropdown Label
            dropdown.Label = Instance.new("TextLabel")
            dropdown.Label.Name = "DropdownLabel"
            dropdown.Label.Size = UDim2.new(1, 0, 0, 20)
            dropdown.Label.BackgroundTransparency = 1
            dropdown.Label.Text = dropdownText
            dropdown.Label.TextColor3 = AppleHub.Theme.TextColor
            dropdown.Label.Font = Enum.Font.Gotham
            dropdown.Label.TextSize = 14
            dropdown.Label.TextXAlignment = Enum.TextXAlignment.Left
            dropdown.Label.Parent = dropdown.Frame
            
            -- Dropdown Button
            dropdown.Button = Instance.new("TextButton")
            dropdown.Button.Name = "DropdownButton"
            dropdown.Button.Size = UDim2.new(1, 0, 0, 30)
            dropdown.Button.Position = UDim2.new(0, 0, 0, 25)
            dropdown.Button.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            dropdown.Button.BorderSizePixel = 0
            dropdown.Button.TextXAlignment = Enum.TextXAlignment.Left
            dropdown.Button.Text = "  " .. (dropdown.SelectedOption or "Select...")
            dropdown.Button.TextColor3 = AppleHub.Theme.TextColor
            dropdown.Button.Font = Enum.Font.Gotham
            dropdown.Button.TextSize = 14
            dropdown.Button.AutoButtonColor = false
            dropdown.Button.Parent = dropdown.Frame
            
            -- Button Corner
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = dropdown.Button
            
            -- Arrow Icon
            dropdown.Arrow = Instance.new("TextLabel")
            dropdown.Arrow.Name = "Arrow"
            dropdown.Arrow.Size = UDim2.new(0, 20, 0, 20)
            dropdown.Arrow.Position = UDim2.new(1, -25, 0.5, -10)
            dropdown.Arrow.BackgroundTransparency = 1
            dropdown.Arrow.Text = "▼"
            dropdown.Arrow.TextColor3 = AppleHub.Theme.TextColor
            dropdown.Arrow.Font = Enum.Font.Gotham
            dropdown.Arrow.TextSize = 14
            dropdown.Arrow.Parent = dropdown.Button
            
            -- Dropdown List Container
            dropdown.ListContainer = Instance.new("Frame")
            dropdown.ListContainer.Name = "ListContainer"
            dropdown.ListContainer.Size = UDim2.new(1, 0, 0, 0) -- Will be auto-sized
            dropdown.ListContainer.Position = UDim2.new(0, 0, 1, 5)
            dropdown.ListContainer.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            dropdown.ListContainer.BorderSizePixel = 0
            dropdown.ListContainer.Visible = false
            dropdown.ListContainer.ZIndex = 10
            dropdown.ListContainer.ClipsDescendants = true
            dropdown.ListContainer.Parent = dropdown.Button
            
            -- Container Corner
            local containerCorner = Instance.new("UICorner")
            containerCorner.CornerRadius = UDim.new(0, 6)
            containerCorner.Parent = dropdown.ListContainer
            
            -- List Layout
            dropdown.ListLayout = Instance.new("UIListLayout")
            dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
            dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            dropdown.ListLayout.Padding = UDim.new(0, 2)
            dropdown.ListLayout.Parent = dropdown.ListContainer
            
            -- List Padding
            dropdown.ListPadding = Instance.new("UIPadding")
            dropdown.ListPadding.PaddingLeft = UDim.new(0, 5)
            dropdown.ListPadding.PaddingRight = UDim.new(0, 5)
            dropdown.ListPadding.PaddingTop = UDim.new(0, 5)
            dropdown.ListPadding.PaddingBottom = UDim.new(0, 5)
            dropdown.ListPadding.Parent = dropdown.ListContainer
            
            -- Populate dropdown options
            for i, option in ipairs(dropdown.Options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = "Option_" .. i
                optionButton.Size = UDim2.new(1, -10, 0, 25)
                optionButton.BackgroundColor3 = AppleHub.Theme.ElementBackColor
                optionButton.BorderSizePixel = 0
                optionButton.Text = "  " .. option
                optionButton.TextColor3 = AppleHub.Theme.TextColor
                optionButton.Font = Enum.Font.Gotham
                optionButton.TextSize = 14
                optionButton.TextXAlignment = Enum.TextXAlignment.Left
                optionButton.LayoutOrder = i
                optionButton.ZIndex = 11
                optionButton.AutoButtonColor = false
                optionButton.Parent = dropdown.ListContainer
                
                -- Option Corner
                local optionCorner = Instance.new("UICorner")
                optionCorner.CornerRadius = UDim.new(0, 4)
                optionCorner.Parent = optionButton
                
                -- Highlight selected option
                if i == dropdown.SelectedIndex then
                    optionButton.BackgroundColor3 = AppleHub.Theme.Accent
                end
                
                -- Option effects
                optionButton.MouseEnter:Connect(function()
                    if i ~= dropdown.SelectedIndex then
                        TweenService:Create(optionButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.1)
                        }):Play()
                    end
                end)
                
                optionButton.MouseLeave:Connect(function()
                    if i ~= dropdown.SelectedIndex then
                        TweenService:Create(optionButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = AppleHub.Theme.ElementBackColor
                        }):Play()
                    end
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    dropdown:Select(i)
                    dropdown:Toggle(false)
                end)
            end
            
            -- Calculate dropdown height based on options
            local listHeight = (#dropdown.Options * 27) + 10 -- Option height + padding
            
            -- Toggle dropdown functionality
            function dropdown:Toggle(state)
                if state == nil then
                    state = not dropdown.Open
                end
                
                dropdown.Open = state
                
                if state then
                    dropdown.ListContainer.Visible = true
                    dropdown.Arrow.Text = "▲"
                    TweenService:Create(dropdown.ListContainer, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, 0, 0, listHeight)
                    }):Play()
                else
                    dropdown.Arrow.Text = "▼"
                    TweenService:Create(dropdown.ListContainer, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    
                    wait(0.3)
                    if not dropdown.Open then
                        dropdown.ListContainer.Visible = false
                    end
                end
            end
            
            -- Select option functionality
            function dropdown:Select(index)
                if dropdown.Options[index] then
                    -- Reset previous selection
                    if dropdown.SelectedIndex > 0 and dropdown.SelectedIndex <= #dropdown.Options then
                        local prevOption = dropdown.ListContainer:FindFirstChild("Option_" .. dropdown.SelectedIndex)
                        if prevOption then
                            prevOption.BackgroundColor3 = AppleHub.Theme.ElementBackColor
                        end
                    end
                    
                    -- Update selection
                    dropdown.SelectedIndex = index
                    dropdown.SelectedOption = dropdown.Options[index]
                    dropdown.Button.Text = "  " .. dropdown.SelectedOption
                    
                    -- Highlight new selection
                    local newOption = dropdown.ListContainer:FindFirstChild("Option_" .. index)
                    if newOption then
                        newOption.BackgroundColor3 = AppleHub.Theme.Accent
                    end
                    
                    -- Fire callback
                    dropdown.Callback(dropdown.SelectedOption, index)
                end
            end
            
            -- Button effects
            dropdown.Button.MouseEnter:Connect(function()
                TweenService:Create(dropdown.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.1)
                }):Play()
            end)
            
            dropdown.Button.MouseLeave:Connect(function()
                TweenService:Create(dropdown.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = AppleHub.Theme.ElementBackColor
                }):Play()
            end)
            
            dropdown.Button.MouseButton1Click:Connect(function()
                dropdown:Toggle()
            end)
            
            -- Close dropdown when clicking outside
            UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local mousePosition = UserInputService:GetMouseLocation()
                    local isInDropdown = false
                    
                    if dropdown.Open then
                        local buttonPos = dropdown.Button.AbsolutePosition
                        local buttonSize = dropdown.Button.AbsoluteSize
                        local listPos = dropdown.ListContainer.AbsolutePosition
                        local listSize = dropdown.ListContainer.AbsoluteSize
                        
                        -- Check if mouse is inside dropdown button or list
                        isInDropdown = (mousePosition.X >= buttonPos.X and mousePosition.X <= buttonPos.X + buttonSize.X and
                                        mousePosition.Y >= buttonPos.Y and mousePosition.Y <= buttonPos.Y + buttonSize.Y) or
                                    (mousePosition.X >= listPos.X and mousePosition.X <= listPos.X + listSize.X and
                                        mousePosition.Y >= listPos.Y and mousePosition.Y <= listPos.Y + listSize.Y)
                        
                        if not isInDropdown then
                            dropdown:Toggle(false)
                        end
                    end
                end
            end)
            
            self.Elements[dropdownText] = dropdown
            return dropdown
        end
        
        -- Add Keybind to section
        function section:AddKeybind(bindText, defaultKey, callback)
            self.ElementCount = self.ElementCount + 1
            
            local keybind = {}
            keybind.Text = bindText
            keybind.Key = defaultKey or Enum.KeyCode.Unknown
            keybind.Callback = callback or function() end
            keybind.Listening = false
            
            -- Keybind Frame
            keybind.Frame = Instance.new("Frame")
            keybind.Frame.Name = "KeybindFrame"
            keybind.Frame.Size = UDim2.new(1, 0, 0, 32)
            keybind.Frame.BackgroundTransparency = 1
            keybind.Frame.LayoutOrder = self.ElementCount
            keybind.Frame.Parent = self.Container
            
            -- Keybind Label
            keybind.Label = Instance.new("TextLabel")
            keybind.Label.Name = "KeybindLabel"
            keybind.Label.Size = UDim2.new(1, -80, 1, 0)
            keybind.Label.BackgroundTransparency = 1
            keybind.Label.Text = bindText
            keybind.Label.TextColor3 = AppleHub.Theme.TextColor
            keybind.Label.Font = Enum.Font.Gotham
            keybind.Label.TextSize = 14
            keybind.Label.TextXAlignment = Enum.TextXAlignment.Left
            keybind.Label.Parent = keybind.Frame
            
            -- Keybind Button
            keybind.Button = Instance.new("TextButton")
            keybind.Button.Name = "KeybindButton"
            keybind.Button.Size = UDim2.new(0, 75, 0, 25)
            keybind.Button.Position = UDim2.new(1, -75, 0.5, -12.5)
            keybind.Button.BackgroundColor3 = AppleHub.Theme.ElementBackColor
            keybind.Button.BorderSizePixel = 0
            keybind.Button.Text = keybind.Key.Name ~= "Unknown" and keybind.Key.Name or "..."
            keybind.Button.TextColor3 = AppleHub.Theme.TextColor
            keybind.Button.Font = Enum.Font.Gotham
            keybind.Button.TextSize = 14
            keybind.Button.AutoButtonColor = false
            keybind.Button.Parent = keybind.Frame
            
            -- Button Corner
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = keybind.Button
            
            -- Button effects
            keybind.Button.MouseEnter:Connect(function()
                TweenService:Create(keybind.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.1)
                }):Play()
            end)
            
            keybind.Button.MouseLeave:Connect(function()
                TweenService:Create(keybind.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = AppleHub.Theme.ElementBackColor
                }):Play()
            end)
            
            keybind.Button.MouseButton1Click:Connect(function()
                keybind.Listening = true
                keybind.Button.Text = "..."
                
                -- Fade animation
                local flashTween = TweenService:Create(keybind.Button, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true), {
                    BackgroundColor3 = LightenColor(AppleHub.Theme.ElementBackColor, 0.15)
                })
                flashTween:Play()
                
                -- Cancel listening if clicked again
                keybind.Button.MouseButton1Click:Connect(function()
                    if keybind.Listening then
                        keybind.Listening = false
                        keybind.Button.Text = keybind.Key.Name ~= "Unknown" and keybind.Key.Name or "..."
                        flashTween:Cancel()
                        TweenService:Create(keybind.Button, TweenInfo.new(0.2), {
                            BackgroundColor3 = AppleHub.Theme.ElementBackColor
                        }):Play()
                    end
                end)
            end)
            
            -- Listen for key
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if keybind.Listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    keybind.Key = input.KeyCode
                    keybind.Button.Text = input.KeyCode.Name
                    keybind.Listening = false
                    
                    -- Stop flashing
                    TweenService:Create(keybind.Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = AppleHub.Theme.ElementBackColor
                    }):Play()
                elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                    -- Trigger if key is pressed
                    if input.KeyCode == keybind.Key then
                        keybind.Callback()
                    end
                end
            end)
            
            function keybind:Set(key)
                keybind.Key = key
                keybind.Button.Text = key.Name
            end
            
            self.Elements[bindText] = keybind
            return keybind
        end

        -- Add Image element to section
        function section:AddImage(imageId, size)
            self.ElementCount = self.ElementCount + 1
            
            local imageElement = {}
            imageElement.ImageId = imageId
            imageElement.Size = size or UDim2.new(0, 100, 0, 100)
            
            -- Image Frame
            imageElement.Frame = Instance.new("Frame")
            imageElement.Frame.Name = "ImageFrame"
            imageElement.Frame.Size = UDim2.new(1, 0, 0, imageElement.Size.Y.Offset + 10)
            imageElement.Frame.BackgroundTransparency = 1
            imageElement.Frame.LayoutOrder = self.ElementCount
            imageElement.Frame.Parent = self.Container
            
            -- Image Label
            imageElement.Image = Instance.new("ImageLabel")
            imageElement.Image.Name = "Image"
            imageElement.Image.Size = imageElement.Size
            imageElement.Image.Position = UDim2.new(0.5, -imageElement.Size.X.Offset/2, 0, 5)
            imageElement.Image.BackgroundTransparency = 1
            imageElement.Image.Image = imageId
            imageElement.Image.ScaleType = Enum.ScaleType.Stretch
            imageElement.Image.Parent = imageElement.Frame
            
            function imageElement:SetImage(imageId)
                imageElement.ImageId = imageId
                imageElement.Image.Image = imageId
            end
            
            function imageElement:Resize(size)
                imageElement.Size = size
                imageElement.Image.Size = size
                imageElement.Image.Position = UDim2.new(0.5, -size.X.Offset/2, 0, 5)
                imageElement.Frame.Size = UDim2.new(1, 0, 0, size.Y.Offset + 10)
            end
            
            self.Elements["Image_" .. self.ElementCount] = imageElement
            return imageElement
        end

        return section
    end
    
    return tab
end

function AppleHub.Library:SelectTab(tabName)
    local tab = self.Tabs[tabName]
    
    if tab and self.ActiveTab ~= tab then
        -- Hide previous tab
        if self.ActiveTab then
            self.ActiveTab.Content.Visible = false
            TweenService:Create(self.ActiveTab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = AppleHub.Theme.LightContrast,
                TextColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
        end
        
        -- Show new tab
        tab.Content.Visible = true
        TweenService:Create(tab.Button, TweenInfo.new(0.2), {
            BackgroundColor3 = AppleHub.Theme.Accent,
            TextColor3 = AppleHub.Theme.TextColor
        }):Play()
        
        self.ActiveTab = tab
    end
end

-- Notification System
function AppleHub.Library:Notify(title, message, duration, type)
    title = title or "Notification"
    message = message or ""
    duration = duration or 3
    type = type or "Info" -- Info, Success, Warning, Error
    
    -- Type Colors
    local typeColors = {
        Info = Color3.fromRGB(70, 140, 240),
        Success = Color3.fromRGB(50, 200, 100),
        Warning = Color3.fromRGB(250, 180, 70),
        Error = Color3.fromRGB(240, 70, 70)
    }
    
    local color = typeColors[type] or typeColors.Info
    
    -- Create notification
    local notification = {}
    
    -- Notification Frame
    notification.Frame = Instance.new("Frame")
    notification.Frame.Name = "Notification"
    notification.Frame.Size = UDim2.new(0, 230, 0, 80)
    notification.Frame.BackgroundColor3 = AppleHub.Theme.Background
    notification.Frame.BorderSizePixel = 0
    notification.Frame.ClipsDescendants = true
    notification.Frame.Position = UDim2.new(1, 10, 0, 0) -- Start offscreen
    notification.Frame.Parent = self.NotificationFrame
    
    -- Frame Corner
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 6)
    frameCorner.Parent = notification.Frame
    
    -- Title
    notification.Title = Instance.new("TextLabel")
    notification.Title.Name = "Title"
    notification.Title.Size = UDim2.new(1, -15, 0, 25)
    notification.Title.Position = UDim2.new(0, 15, 0, 5)
    notification.Title.BackgroundTransparency = 1
    notification.Title.Text = title
    notification.Title.TextColor3 = color
    notification.Title.Font = Enum.Font.GothamBold
    notification.Title.TextSize = 16
    notification.Title.TextXAlignment = Enum.TextXAlignment.Left
    notification.Title.Parent = notification.Frame
    
    -- Message
    notification.Message = Instance.new("TextLabel")
    notification.Message.Name = "Message"
    notification.Message.Size = UDim2.new(1, -15, 0, 40)
    notification.Message.Position = UDim2.new(0, 15, 0, 30)
    notification.Message.BackgroundTransparency = 1
    notification.Message.Text = message
    notification.Message.TextColor3 = AppleHub.Theme.TextColor
    notification.Message.Font = Enum.Font.Gotham
    notification.Message.TextSize = 14
    notification.Message.TextWrapped = true
    notification.Message.TextXAlignment = Enum.TextXAlignment.Left
    notification.Message.TextYAlignment = Enum.TextYAlignment.Top
    notification.Message.Parent = notification.Frame
    
    -- Progress Bar
    notification.ProgressBar = Instance.new("Frame")
    notification.ProgressBar.Name = "ProgressBar"
    notification.ProgressBar.Size = UDim2.new(1, 0, 0, 3)
    notification.ProgressBar.Position = UDim2.new(0, 0, 1, -3)
    notification.ProgressBar.BackgroundColor3 = color
    notification.ProgressBar.BorderSizePixel = 0
    notification.ProgressBar.Parent = notification.Frame
    
    -- Close Button
    notification.CloseButton = Instance.new("TextButton")
    notification.CloseButton.Name = "CloseButton"
    notification.CloseButton.Size = UDim2.new(0, 20, 0, 20)
    notification.CloseButton.Position = UDim2.new(1, -25, 0, 10)
    notification.CloseButton.BackgroundTransparency = 1
    notification.CloseButton.Text = "×"
    notification.CloseButton.TextColor3 = AppleHub.Theme.TextColor
    notification.CloseButton.Font = Enum.Font.Gotham
    notification.CloseButton.TextSize = 20
    notification.CloseButton.Parent = notification.Frame
    
    -- Slide in animation
    TweenService:Create(notification.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    -- Progress bar animation
    TweenService:Create(notification.ProgressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3)
    }):Play()
    
    -- Close button functionality
    notification.CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(notification.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, 10, 0, 0)
        }):Play()
        
        wait(0.5)
        notification.Frame:Destroy()
    end)
    
    -- Auto close after duration
    spawn(function()
        wait(duration)
        
        if notification.Frame and notification.Frame.Parent then
            TweenService:Create(notification.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, 10, 0, 0)
            }):Play()
            
            wait(0.5)
            if notification.Frame and notification.Frame.Parent then
                notification.Frame:Destroy()
            end
        end
    end)
    
    return notification
end
