-- Function to smoothly teleport to a given CFrame position
local function smoothTP(cf)
    local success, err = pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    end)

    if not success then
        warn("Teleportation failed: " .. tostring(err))
    end
end

-- Main function to loop through all house addresses (House1 to House12)
local function main()
    for i = 1, 12 do
        local houseAddress = "House" .. i  -- Generate house address (e.g., "House1", "House2", etc.)
        local house = workspace.Houses:FindFirstChild(houseAddress)

        -- Error check: If the house is not found
        if not house then
            warn("Error: House " .. houseAddress .. " not found!")
            continue  -- Skip to the next house
        end

        -- Find the first child (house type) within the house
        local houseType = house:FindFirstChildOfClass("Model")  -- Get the first child that is a Model (the type of house)
        
        -- Check if a valid house type was found
        if not houseType then
            warn("Error: No valid house type found in " .. houseAddress)
            continue  -- Skip to the next house
        end

        -- Get the front door's ClickDetector
        local frontDoor = houseType:FindFirstChild("Doors") and houseType.Doors:FindFirstChild("FrontDoorMain")
        local clickDetector = frontDoor and frontDoor:FindFirstChild("ClickDetector")

        -- Error check: If the ClickDetector is not found
        if not clickDetector then
            warn("Error: ClickDetector not found for house address: " .. houseAddress)
            continue  -- Skip to the next house
        end

        -- Teleport to the porch (adjusting the height to be on the porch)
        local doorPosition = frontDoor.Position  -- Get position of the door
        smoothTP(doorPosition + Vector3.new(0, 7, 0))  -- Offset by 7 on Y-axis to be above the porch
        wait(1)  -- Small wait after teleporting

        -- Fire the ClickDetector to trigger the trick-or-treat event
        local success, err = pcall(function()
            clickDetector.Detector:FireServer()
        end)

        if not success then
            warn("Failed to fire ClickDetector for house address: " .. houseAddress .. ": " .. tostring(err))
        else
            print("ClickDetector fired for house address: " .. houseAddress)
        end

        -- Wait 5 seconds before moving to the next house
        wait(5)
    end

    print("Finished processing all houses.")
end

-- Start the main process
main()
