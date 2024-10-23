local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local houses = {
    {CFrame.new(184.121826, 3.40035772, -464.13504, 0.024004763, 4.07734788e-08, -0.999999999, 6.77649794e-08, 1, 4.24123847e-08, 0.999999999, 0, 0)}, -- A1
    {CFrame.new(183.404602, 3.40041065, -643.995178, -0.00680717221, 5.11775937e-08, -0.999999999, 1.12246923e-08, 1, 5.11023686e-08, 0.999999999, 0, 0)}, --A2
    {CFrame.new(183.849396, 3.40040493, -831.901733, 0.0234296825, -2.83246973e-08, -0.999999999, 3.89105885e-08, 1, -2.74205618e-08, 0.999999999, 0, 0)}, --A3
    {CFrame.new(-14.8219395, 3.40013051, -444.217224, 0.0298809279, -1.72805503e-08, 0.999999999, 1.79612702e-09, 1, 1.72345747e-08, -0.999999999, 0, 0)}, --B1
    {CFrame.new(18.6507683, 3.40023756, -472.692841, -0.0377451703, 1.36923974e-08, -0.999999999, -1.62546909e-09, 1, 1.37635583e-08, 0.999999999, 0, 0)}, --B2
    {CFrame.new(-16.1664162, 3.40009975, -615.756165, -0.000817497901, -5.44477494e-08, 0.999999999, -1.88778859e-08, 1, 5.44323342e-08, -0.999999999, 0, 0)}, --B3
    {CFrame.new(19.363287, 3.40030956, -652.319214, 0.0177504756, -5.7227119e-08, -0.999999999, 5.31250173e-08, 1, -5.62929934e-08, 0.999999999, 0, 0)}, --B4
    {CFrame.new(-14.9540148, 3.40008187, -800.02887, -0.0214686599, 3.4947746e-08, 0.999999999, 6.56331238e-08, 1, -3.35464208e-08, -0.999999999, 0, 0)}, --B5
    {CFrame.new(18.9661083, 3.3202858, -843.917725, -0.00571252638, -2.6233149e-10, -0.999999999, 1.90183095e-11, 1, -2.62444427e-10, 0.999999999, 0, 0)}, --B6
    {CFrame.new(-180.296143, 3.40001225, -429.667877, -0.0165395495, -3.89166317e-08, 0.999999999, -8.25808826e-08, 1, 3.7555921e-08, -0.999999999, 0, 0)}, --C1
    {CFrame.new(-179.852448, 3.4000628, -619.527527, 0.00664125895, -4.08390335e-08, 0.999999999, -9.22226562e-08, 1, 4.14524202e-08, -0.999999999, 0, 0)}, --C2
    {CFrame.new(-179.755905, 3.40013194, -799.496277, -0.00149426353, 4.12323971e-08, 0.999999999, -6.44199574e-08, 1, -4.1328704e-08, -0.999999999, 0, 0)} --C3
}

local currentIndex = 1

while true do
    -- Teleport to the current house
    humanoidRootPart.CFrame = houses[currentIndex][1]
    wait(0.1)
    humanoidRootPart.CFrame = houses[currentIndex][1]
    wait(0.5)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Right, false, game)
    wait(0.01)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Right, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "D", false, game)
    wait(1.29)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "D", false, game)
    wait(0.5)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
    wait(0.3)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "S", false, game)
    wait(0.6)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "S", false, game)
    
    -- Move to the next house index, and loop back if necessary
    currentIndex = currentIndex + 1
    if currentIndex > #houses then
        currentIndex = 1
    end
    
    -- Wait for 12 seconds
    wait(13)
end
