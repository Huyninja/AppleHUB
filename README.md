# AppleHub UI Library Documentation

AppleHub is a sleek, customizable UI library for Roblox scripts that provides a variety of UI elements with a modern design.

## Getting Started

### Setup

```lua
-- Include the AppleHub library in your script
-- Create a window
local UI = AppleHub.CreateWindow("My Script", "v1.0")
```

### Basic Structure

The UI hierarchy is as follows:
- **Window**: The main container
  - **Tabs**: Pages within the window
    - **Sections**: Groups within tabs
      - **Elements**: UI components within sections

## Creating UI Elements

### Window

```lua
local UI = AppleHub.CreateWindow("Title", "Subtitle")
```

### Tabs

```lua
local MainTab = UI:AddTab("Main")
local SettingsTab = UI:AddTab("Settings", "rbxassetid://3926305904") -- With icon
```

### Sections

```lua
local GeneralSection = MainTab:AddSection("General")
local FeaturesSection = MainTab:AddSection("Features")
```

### Elements

#### Button

```lua
local MyButton = GeneralSection:AddButton("Click Me", function()
    print("Button clicked!")
end)
```

#### Toggle

```lua
local MyToggle = GeneralSection:AddToggle("Enable Feature", false, function(value)
    print("Toggle is now: " .. tostring(value))
end)

-- Update toggle value
MyToggle:Set(true)
```

#### Slider

```lua
local MySlider = GeneralSection:AddSlider("Speed", 0, 100, 50, "%.0f", function(value)
    print("Slider value: " .. value)
end)

-- Update slider value
MySlider:Set(75)
```

#### Dropdown

```lua
local options = {"Option 1", "Option 2", "Option 3"}
local MyDropdown = GeneralSection:AddDropdown("Select Option", options, 1, function(value, index)
    print("Selected: " .. value .. " at index " .. index)
end)

-- Select dropdown option by index
MyDropdown:Select(2)
-- Toggle dropdown menu
MyDropdown:Toggle(true)
```

#### Keybind

```lua
local MyKeybind = GeneralSection:AddKeybind("Toggle Key", Enum.KeyCode.E, function()
    print("Keybind pressed!")
end)

-- Change keybind
MyKeybind:Set(Enum.KeyCode.F)
```

#### Image

```lua
local MyImage = GeneralSection:AddImage("rbxassetid://7072706001", UDim2.new(0, 150, 0, 150))

-- Change image
MyImage:SetImage("rbxassetid://7072706002")
-- Resize image
MyImage:Resize(UDim2.new(0, 200, 0, 200))
```

## Window Controls

### Toggle Minimized State

```lua
UI:ToggleMinimize() -- Minimize or maximize the window
```

### Select Tab

```lua
UI:SelectTab("Settings") -- Change active tab
```

## Notifications

```lua
-- Parameters: title, message, duration (seconds), type ("Info", "Success", "Warning", "Error")
UI:Notify("Hello", "This is a notification", 3, "Info")
UI:Notify("Success", "Operation completed", 3, "Success")
UI:Notify("Warning", "Something might be wrong", 3, "Warning")
UI:Notify("Error", "An error occurred", 3, "Error")
```

## Theme Customization

```lua
-- Change the entire theme
AppleHub.SetTheme({
    Background = Color3.fromRGB(35, 35, 35),
    LightContrast = Color3.fromRGB(45, 45, 45),
    DarkContrast = Color3.fromRGB(30, 30, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 120, 255),
    ElementBackColor = Color3.fromRGB(50, 50, 50)
})
```

## Example Usage

```lua
-- Load the library
local UI = AppleHub.CreateWindow("Pet Simulator X", "v1.2")

-- Create tabs
local FarmTab = UI:AddTab("Farming")
local EggsTab = UI:AddTab("Eggs")
local MiscTab = UI:AddTab("Misc")

-- Create farming sections
local AutoFarmSection = FarmTab:AddSection("Auto Farm")
local SettingsSection = FarmTab:AddSection("Settings")

-- Add farming elements
local AutoFarmToggle = AutoFarmSection:AddToggle("Auto Farm", false, function(value)
    -- Auto farm logic here
end)

local FarmSpeedSlider = SettingsSection:AddSlider("Farm Speed", 1, 10, 5, "%.0f", function(value)
    -- Change farm speed logic
end)

-- Create egg section
local EggOpenSection = EggsTab:AddSection("Open Eggs")

-- Add egg elements
local EggDropdown = EggOpenSection:AddDropdown("Select Egg", {"Basic Egg", "Rare Egg", "Legendary Egg"}, 1, function(value)
    -- Select egg logic
end)

local AutoOpenToggle = EggOpenSection:AddToggle("Auto Open", false, function(value)
    -- Auto open logic
end)

-- Misc section
local TeleportSection = MiscTab:AddSection("Teleport")

-- Add teleport button
local TeleportButton = TeleportSection:AddButton("Teleport to Shop", function()
    -- Teleport logic
end)

-- Show notification on load
UI:Notify("Welcome", "Script loaded successfully!", 3, "Success")
```
