-- =================================================================
-- SCRIPT ESP GLOW + TEXT BY DEERZN
-- =================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Hapus UI lama jika ada agar tidak menumpuk
if CoreGui:FindFirstChild("EspGlowUI") then
    CoreGui.EspGlowUI:Destroy()
end

-- =================================================================
-- 1. PEMBUATAN GUI UTAMA
-- =================================================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "EspGlowUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

ToggleButton.Name = "EspToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah (OFF)
ToggleButton.Position = UDim2.new(0.02, 0, 0.25, 0)
ToggleButton.Size = UDim2.new(0, 200, 0, 50) -- Lebar sedikit ditambah agar teks muat
ToggleButton.Font = Enum.Font.SourceSansBold
-- Menampilkan nama Anda langsung di dalam tombol GUI
ToggleButton.Text = "ESP GLOW: OFF [DeerzN]"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- =================================================================
-- 2. LOGIKA ESP GLOW (CHAMS / TEMBUS TEMBOK)
-- =================================================================
_G.EspGlowEnabled = false

local function createGlow(character)
    if not character then return end
    if character:FindFirstChild("EspHighlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "EspHighlight"
    highlight.Adornee = character
    highlight.Parent = character
    
    highlight.FillColor = Color3.fromRGB(0, 255, 255)      -- Warna dalam badan
    highlight.FillTransparency = 0.5                      
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Warna garis pinggir
    highlight.OutlineTransparency = 0                     
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Tembus tembok
end

local function removeGlow(character)
    if character and character:FindFirstChild("EspHighlight") then
        character.EspHighlight:Destroy()
    end
end

local function toggleEsp(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if state then
                if player.Character then
                    createGlow(player.Character)
                end
                player.CharacterAdded:Connect(function(char)
                    if _G.EspGlowEnabled then
                        task.wait(0.5)
                        createGlow(char)
                    end
                end)
            else
                if player.Character then
                    removeGlow(player.Character)
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if _G.EspGlowEnabled and player ~= LocalPlayer then
            task.wait(0.5)
            createGlow(char)
        end
    end)
end)

-- =================================================================
-- 3. TOMBOL EVENT SYSTEM
-- =================================================================
ToggleButton.MouseButton1Click:Connect(function()
    if _G.EspGlowEnabled == false then
        _G.EspGlowEnabled = true
        ToggleButton.Text = "ESP GLOW: ON [DeerzN]"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Hijau (ON)
        toggleEsp(true)
    else
        _G.EspGlowEnabled = false
        ToggleButton.Text = "ESP GLOW: OFF [DeerzN]"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah (OFF)
        toggleEsp(false)
    end
end)

print("Script ESP Glow by DeerzN Berhasil Dimuat!")
