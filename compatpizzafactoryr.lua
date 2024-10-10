-- CSWC REMIX 9/10/24
getupvalues = getupvalues or debug.getupvalues
setupvalue = setupvalue or debug.setupvalue

-- Check executor level
local level = printidentity()  -- This prints the current identity level

-- Default to assuming some features might be unavailable
local advancedExecutor = false

if level >= 7 then
    -- Level 7+ has access to advanced functions
    if getrawmetatable and getupvalues and setupvalue and (getreg or debug.getregistry) then
        advancedExecutor = true
    end
else
    -- Lower levels cannot run advanced functionality
    local h = Instance.new("Hint", workspace)
    h.Text = "Advanced features disabled for lower executor levels."
    wait(3)
    h:Destroy()
end

-- Settings for the script
local settings = {refill_at=20, refill_end=80, deliver_at=16, stay_in_kitchen=true}
local doCashier, doBoxer, doCook, doSupplier, doDelivery = false, false, false, false, false

if readfile then
    pcall(function()
        local new = game:GetService("HttpService"):JSONDecode(readfile("PizzaFarm.txt"))
        -- Cleanup and overwrite settings
        local doOverwrite = false
        for k, v in pairs(new) do
            if settings[k] == nil then
                doOverwrite = true
                new[k] = nil
            end
        end
        for k, v in pairs(settings) do
            if new[k] == nil then
                doOverwrite = true
                new[k] = v
            end
        end
        -- Write updated settings
        if doOverwrite then
            warn("Settings overwritten")
            writefile("PizzaFarm.txt", game:GetService("HttpService"):JSONEncode(new))
        end
        settings = new
    end)
end

if getconnections then
    for _, c in next, getconnections(game:GetService("ScriptContext").Error) do
        c:Disable()
    end
end

local player = game:GetService("Players").LocalPlayer
local ffc = game.FindFirstChild
local RNG = Random.new()
local network
local character, root, humanoid

if advancedExecutor then
    -- Execute advanced functionality only for high-level executors
    local reg = (getreg or debug.getregistry)()
    for i = 1, #reg do
        local f = reg[i]
        if type(f) == "function" then
            for k, v in next, getupvalues(f) do
                if typeof(v) == "Instance" then
                    if v.Name == "CashOut" then
                        setupvalue(f, k, {MouseButton1Click = {wait = function() end, Wait = function() end}})
                    elseif v.Name == "StickerName" then
                        setupvalue(f, k, nil)
                    end
                end
            end
            if tostring(getfenv(f)) == "Music" then
                local consts = getconstants(f)
                local loc = false
                for ci, c in next, consts do
                    if c == "location changed" then
                        loc = true
                    elseif loc and c == "SendData" then
                        setconstant(f, ci, "ExplodeString")
                        break
                    end
                end
            end
        end
    end
else
    -- Disable advanced functionality with a warning if not enough permissions
    warn("Limited functionality due to lower executor level")
end
