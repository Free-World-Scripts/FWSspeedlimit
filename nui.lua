local speedlimit = "N/A"
local dis = true
local currentspeed = 0

CreateThread(function()
    while true do
        local iPed = GetPlayerPed(-1)
        Wait(1000)
        local playerloc = GetEntityCoords(iPed)
        local streethash = GetStreetNameAtCoord(playerloc.x, playerloc.y, playerloc.z)
        street = GetStreetNameFromHashKey(streethash)
        if IsPedInAnyPlane(iPed) == 1 then
            dis = true
            SendNUIMessage({
                Speed = "",
                Display = dis
            })
        elseif IsPedInAnyHeli(iPed) == 1 then
            dis = true
            SendNUIMessage({
                Speed = "",
                Display = dis
            })
        elseif IsPedInAnyBoat(iPed) == 1 then
            dis = true
            SendNUIMessage({
                Speed = "",
                Display = dis
            })
        elseif IsPedInAnyVehicle(iPed) == 1 then
            dis = false
            if currentspeed ~= Config.Speedlimits[street] then
                SendNUIMessage({
                    Speed = speedlimit,
                    Display = dis
                })
                if Config.Speed == 'mph' then
                    if Config.Speedlimits[street] then
                        speedlimit = Config.Speedlimits[street]
                    else
                        speedlimit = "N/A"
                    end
                elseif Config.Speed == 'kph' then
                    if Config.Speedlimits[street] then
                        speedlimit = math.floor(Config.Speedlimits[street] * 1.609)
                    else
                        speedlimit = "N/A"
                    end
                else
                    if Config.Speedlimits[street] then
                        speedlimit = Config.Speedlimits[street]
                    else
                        speedlimit = "N/A"
                    end
                end
            end
        else
            dis = true
            SendNUIMessage({
                Speed = "",
                Display = dis
            })
        end
    end    
end)

RegisterNetEvent("hud:speed", function(toggled)
    local size
    local height
    local iPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(iPed) then
        size = tonumber(toggled)
        size = size/10
        height = size*2 
        SendNUIMessage({
            width = size,
            height = height
        })
    end
end)

RegisterCommand(Config.Command, function(source, args)
    local iPed = GetPlayerPed(-1)
    local mspeed = false
    if IsPedInAnyVehicle(iPed) then
        mspeed = not mspeed
        SetNuiFocus(mspeed, mspeed)
    end
end)

CreateThread(function()
    while mspeed do
        Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

RegisterNUICallback("exit", function(data)
    local iPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(iPed) then
        mspeed = false
        SetNuiFocus(mspeed, mspeed)
    end
end)
