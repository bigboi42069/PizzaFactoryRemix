-- CSWC Original - BallsNDeath & Mikeeyahh 29/10/24
local Library = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/Fsploit/Shittyware/refs/heads/main/Source'))()

--Library.Theme:Houston()

local Window = Library:CreateWindow({
    Title = 'Work at a Pizza Place | 🎃 Halloween 🎃 - '..Library.TextEffect:AddColor('by BallsNDeath and Mikeeyahh', Color3.fromRGB(0, 200, 255)),
    Logo = "rbxassetid://7733920644",
})

local ScriptTab = Window:AddTab({
    Title = 'Scripts',
    Icon = 'home',
})

ScriptTab:AddBlock('PizzaFactory Scripts')

local function teleportTo(cframe)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = cframe
    else
        warn("Character or HumanoidRootPart not found.")
    end
end

local teleporting = false


-- Medium House FrontDoor CFrames
local positions = {
    CFrame.new(204.874084, 6.99836588, -463.874329, 0.0203506313, 2.88098501e-09, -0.999792933, 8.01123221e-08, 1, 4.51225546e-09, 0.999792933, -8.01875544e-08, 0.0203506313), -- A1
    CFrame.new(206.120117, 6.99841881, -644.280762, 0.0370132886, -2.06297361e-08, -0.999314785, -8.09895369e-08, 1, -2.36436275e-08, 0.999314785, 8.18091692e-08, 0.0370132886), -- A2
    CFrame.new(206.14032, 6.99841309, -824.088867, 0.0126518616, -7.83695739e-08, -0.999919951, -5.66316096e-08, 1, -7.9092402e-08, 0.999919951, 5.76277408e-08, 0.0126518616), -- A3
    CFrame.new(-36.9847107, 6.99817228, -440.079742, -0.00575464545, 1.21660793e-09, 0.99998343, 7.13655055e-08, 1, -8.0593815e-10, -0.99998343, 7.13596862e-08, -0.00575464545), -- B1
    CFrame.new(42.4900322, 7.00028086, -476.031647, 0.00260952138, -2.45901735e-08, -0.999996603, 1.34128642e-09, 1, -2.45867575e-08, 0.999996603, -1.27712219e-09, 0.00260952138), -- B2
    CFrame.new(-36.4410324, 6.99810791, -620.097107, -0.02220935, -1.12574099e-07, 0.999753356, 3.5375225e-09, 1, 1.12680461e-07, -0.999753356, 6.03920958e-09, -0.02220935), -- B3
    CFrame.new(41.1725807, 6.99832535, -655.90094, 0.0160918068, 1.02561565e-07, -0.999870539, -1.41048562e-09, 1, 1.0255215e-07, 0.999870539, -2.39946396e-10, 0.0160918068), -- B4
    CFrame.new(-36.0467033, 6.99811172, -800.527771, 0.0147144273, 1.18401317e-07, 0.999891758, -1.90378273e-08, 1, -1.18133975e-07, -0.999891758, -1.72974914e-08, 0.0147144273), -- B5
    CFrame.new(42.1583366, 6.99836588, -836.29718, -0.00386650045, -5.03949593e-09, -0.999992549, -6.81085366e-09, 1, -5.01319919e-09, 0.999992549, 6.79141943e-09, -0.00386650045), -- B6
    CFrame.new(-201.962616, 6.99999523, -439.81665, -0.0194240212, -4.70079868e-08, 0.999811351, -7.07224768e-09, 1, 4.68794603e-08, -0.999811351, -6.16032603e-09, -0.0194240212), -- C1
    CFrame.new(-201.460602, 6.99807119, -619.961487, -0.00856394973, 2.1210484e-08, 0.999963343, -7.60221308e-09, 1, -2.12763691e-08, -0.999963343, -7.78414488e-09, -0.00856394973), -- C2
    CFrame.new(-201.461685, 6.99814034, -799.934998, -0.0234158263, -8.86191671e-08, 0.999725819, -4.91467631e-08, 1, 8.74923458e-08, -0.999725819, -4.70845833e-08, -0.0234158263), -- C3
}

ScriptTab:AddButton({
    Title = 'Start HalloweenFactory',
    Callback = function()
        teleporting = true
        while teleporting do
            for _, position in ipairs(positions) do
                teleportTo(position)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
                wait(0.02)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "A", false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "A", false, game)
                wait(0.02)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "S", false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "S", false, game)
                wait(0.02)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "D", false, game)
                wait(0.15)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "D", false, game)
                wait(0.02)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
                wait(0.02)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "A", false, game)
                wait(0.05)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "A", false, game)
                wait(0.15)
                teleportTo(position)
                wait(13.5)
                if not teleporting then
                    break
                end
            end
            wait(15)
        end
    end,
})

ScriptTab:AddButton({
    Title = 'Stop HalloweenFactory',
    Callback = function()
        teleporting = false
    end,
})

local SettingsTab = Window:AddTab({
    Title = 'Settings',
    Icon = 'settings',
})

SettingsTab:AddBlock('Settings')

SettingsTab:AddToggle({
    Title = 'Enable Performance Mode',
    Default = false,
    Callback = function(a)
        Library.PerformanceMode = a
    end,
})

SettingsTab:AddButton({
    Title = "Reset Window Size",
    Callback = function()
        Window:Resize(Library.SizeLibrary.Default)
    end,
})

SettingsTab:AddButton({
    Title = "Destroy UI Window",
    Callback = function()
        Window:Destroy()
    end,
})

SettingsTab:AddBlock("")

SettingsTab:AddBlock('Shittyware UI - by Fsploit')

SettingsTab:AddButton({
    Title = "Copy UI Repository Link",
    Callback = function()
        return setclipboard('https://github.com/Fsploit/Shittyware')
    end,
})
