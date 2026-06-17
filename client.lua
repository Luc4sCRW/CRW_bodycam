local ESX = exports['es_extended']:getSharedObject()
local isCamActive = false
local currentName = ""
local _U = i18n

-- Zeit // time
local function GetCurrentTimestamp()
    local year, month, day, hour, minute, second = GetLocalTime()
    local dateString = ""
    local timeString = ""

    if Config.IncludeSeconds then
        timeString = string.format("%02d:%02d:%02d", hour, minute, second)
    else
        timeString = string.format("%02d:%02d", hour, minute)
    end

    if Config.DateFormat == "US" then
        dateString = string.format("%02d/%02d/%04d", month, day, year)
    elseif Config.DateFormat == "EU" then
        dateString = string.format("%02d.%02d.%04d", day, month, year)
    elseif Config.DateFormat == "ISO" then
        dateString = string.format("%04d-%02d-%02d", year, month, day)
    else
        -- Fallback
        dateString = string.format("%02d.%02d.%04d", day, month, year)
    end
    return dateString .. " " .. timeString
end

RegisterNetEvent('CRW_bodycam:toggle', function(charName)
    currentName = charName
    
    -- Animation and ox_lib
    local success = lib.progressBar({
        duration = 2000,
        label = isCamActive and _U('dialog_deactivated') or _U('dialog_activated'),
        useWhileDead = false,
        canCancel = true,
        disable = { move = false, car = false, combat = true },
        anim = { dict = 'clothingtie', clip = 'try_tie_neutral_a' }
    })

    if success then
        isCamActive = not isCamActive
            
        if isCamActive then
            PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
            SendNUIMessage({
                action = "open",
                title = Config.BodycamTitle,
                name = currentName,
                logo = Config.LogoPath
            })
        else
            PlaySoundFrontend(-1, "On_Call_Player_Leave", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
            SendNUIMessage({ action = "close" })
        end
    end
end)

CreateThread(function()
    local lastTime = ""
    local lastCheck = 0
        
    while true do
        if isCamActive then
            local time = GetCurrentTimestamp()
            if time ~= lastTime then
                lastTime = time
                SendNUIMessage({
                    action = "updateTime",
                    time = time
                })
            end
                
            -- Alle 5 Sekunden das Item überprüfen (ob es noch im Inventar existiert) // Check the item every 5 seconds (to see if it's still in the inventory)
            if GetGameTimer() - lastCheck >= 5000 then
                lastCheck = GetGameTimer()
                ESX.TriggerServerCallback('CRW_bodycam:checkItem', function(hasItem)
                    if not hasItem then
                        isCamActive = false
                        SendNUIMessage({ action = "close" })
                        PlaySoundFrontend(-1, "BEEP_ERROR", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                    end
                end)
            end
            Wait(500)
        else
            Wait(2000)
        end
    end
end)
