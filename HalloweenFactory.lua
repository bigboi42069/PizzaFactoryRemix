-- Made by Zingorr, Added to PizzaFactoryRemix by CSWC - 10/23/24
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.9692764, 7.01014566, -443.712738, -0.0368146226, -1.18420891e-08, 0.999322116, 3.6141059e-09, 1, 1.19832642e-08, -0.999322116, 4.05281542e-09, -0.0368146226)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local ffc = game.FindFirstChild

-- **Rough** List of houses with their CFrame coordinates
local houses = {
    House1 = CFrame.new(199.163635, 7.01033974, -460.003845, 0.0424888767, -7.35253947e-09, -0.99909693, -5.85680926e-09, 1, -7.6082598e-09, 0.99909693, 6.17478646e-09, 0.0424888767), -- A1 house
    House2 = CFrame.new(206.516586, 7.00039196, -652.140869, -0.0121296728, -1.33467935e-07, -0.999926448, 1.25846589e-09, 1, -1.33493018e-07, 0.999926448, -2.87759994e-09, -0.0121296728), -- A2 house
    House3 = CFrame.new(206.499451, 7.00038719, -824.087158, -0.00081102812, -1.29714621e-07, -0.999999642, 2.65890012e-08, 1, -1.29736222e-07, 0.999999642, -2.66942131e-08, -0.00081102812), -- A3 house
    House4 = CFrame.new(-30.9692764, 7.01014566, -443.712738, -0.0368146226, -1.18420891e-08, 0.999322116, 3.6141059e-09, 1, 1.19832642e-08, -0.999322116, 4.05281542e-09, -0.0368146226), -- B1 house
    House5 = CFrame.new(40.7544098, 7.00028086, -475.953979, 0.0381280482, -2.33444997e-08, -0.999272883, -1.13426379e-08, 1, -2.37942732e-08, 0.999272883, 1.22416193e-08, 0.0381280482), -- B2 house
    House6 = CFrame.new(-38.2014313, 7.00008202, -615.995056, -0.0416988395, 2.57220822e-08, 0.999130249, 8.83105855e-08, 1, -2.20588205e-08, -0.999130249, 8.73139498e-08, -0.0416988395), -- B3 house
    House7 = CFrame.new(34.1237526, 7.01029873, -651.582153, 0.0159797575, -5.28993631e-08, -0.999872327, -4.59601708e-08, 1, -5.36406439e-08, 0.999872327, 4.68114649e-08, 0.0159797575), -- B4 house
    House8 = CFrame.new(-42.5083694, 6.76008797, -790.086792, -0.00298523437, 1.41309314e-07, 0.99999553, -2.14661044e-09, 1, -1.41316349e-07, -0.99999553, -2.56846344e-09, -0.00298523437), -- B5 house
    House9 = CFrame.new(40.8492317, 7.00034046, -835.990112, 0.0188666377, -1.63969738e-09, -0.999822021, 4.10826484e-09, 1, -1.56246638e-09, 0.999822021, -4.07805523e-09, 0.0188666377), -- B6 house
    House10 = CFrame.new(-202.378128, 6.99999475, -435.736633, -0.129333273, 7.54850493e-09, 0.991601169, -9.92029072e-08, 1, -2.05513491e-08, -0.991601169, -1.01027695e-07, -0.129333273), -- C1 house
    House11 = CFrame.new(-202.514328, 7.00004816, -621.020203, -0.0151044987, 4.5285109e-08, 0.999885917, 1.10043779e-08, 1, -4.51240396e-08, -0.999885917, 1.03215463e-08, -0.0151044987),  -- C2 house
    House12 = CFrame.new(-206.497513, 6.76011705, -789.92749, -0.00557949999, 5.80615939e-16, 0.999984443, 1.10123509e-07, 1, 6.14443108e-10, -0.999984443, 1.10125228e-07, -0.00557949999) -- C3 house
}

local function typeofHouse(houses[h], num)
    local t = ffc(houses[h])
    return t
end

local function teleportToHouses()
    local args1 = {
        [1] = game:GetService("Players").LocalPlayer.Character.Head.face,
        [2] = "http://www.roblox.com/asset/?id=144080495"
    }
    workspace.Main.ChangeFace:FireServer(unpack(args1))
    wait(0.1)
    
    local args2 = {
        [1] = "ToolHold"
    }
    workspace.Animation.AnimationStarted:FireServer(unpack(args2))
    wait(0.1)
    
    local num = 0
    for h, houseCFrame in pairs(houses) do -- Use pairs instead of ipairs
        character.HumanoidRootPart.CFrame = houseCFrame
        num = num + 1
        
        local t = typeofHouse(h, num)
        
        -- Check if all properties exist before calling FireServer
        local door = workspace.Houses.houses[h]
        if door and door.t and door.Doors and door.Doors.FrontDoorMain and door.Doors.FrontDoorMain.ClickDetector then
            door.Doors.FrontDoorMain.ClickDetector.Detector:FireServer()
        else
            warn("One of the properties does not exist for house: " .. h)
        end
        
        wait(8) -- Wait for 8 seconds
    end
end

-- Start
teleportToHouses()
