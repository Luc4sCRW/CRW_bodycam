local ESX = exports['es_extended']:getSharedObject()
local isCamActive = false
local currentName = ""

-- Zeitfunktion (Sicherer Ersatz für os.date)
local function GetCurrentTimestamp()
    local year, month, day, hour, minute, second = GetLocalTime()
    local dateString = ""
    local timeString = ""

    -- Zeit bauen
    if Config.IncludeSeconds then
        timeString = string.format("%02d:%02d:%02d", hour, minute, second)
    else
        timeString = string.format("%02d:%02d", hour, minute)
    end
    -- Datum je nach Config
    if Config.DateFormat == "US" then
        -- MM/DD/YYYY
        dateString = string.format("%02d/%02d/%04d", month, day, year)
    elseif Config.DateFormat == "EU" then
        -- DD.MM.YYYY
        dateString = string.format("%02d.%02d.%04d", day, month, year)
    elseif Config.DateFormat == "ISO" then
        -- YYYY-MM-DD (nice für Logs)
        dateString = string.format("%04d-%02d-%02d", year, month, day)
    else
        -- Fallback (EU)
        dateString = string.format("%02d.%02d.%04d", day, month, year)
    end
    return dateString .. " " .. timeString
end

RegisterNetEvent('cbodycam:toggle')
AddEventHandler('cbodycam:toggle', function(charName)
    currentName = charName
    
    -- Animation & Progressbar von ox_lib
    local success = lib.progressBar({
        duration = 2000,
        label = isCamActive and 'Bodycam wird deaktiviert...' or 'Bodycam wird angelegt...',
        useWhileDead = false,
        canCancel = true,
        disable = { move = false, car = false, combat = true },
        anim = { dict = 'clothingtie', clip = 'try_tie_neutral_a' }
    })

    if success then 
        isCamActive = not isCamActive
        
        if isCamActive then
            -- Sound (Axon Style Beep)
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

-- Haupt-Loop
CreateThread(function()
    while true do
        local sleep = 1000
        if isCamActive then
            -- Zeit an NUI
            SendNUIMessage({ 
                action = "updateTime", 
                time = GetCurrentTimestamp() 
            })
            
            -- Alle 5 Sekunden Item-Check
            if GetGameTimer() % 5000 < 1000 then
                ESX.TriggerServerCallback('cbodycam:checkItem', function(hasItem)
                    if not hasItem then
                        isCamActive = false
                        SendNUIMessage({ action = "close" })
                        PlaySoundFrontend(-1, "BEEP_ERROR", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                    end
                end)
            end
        else
            sleep = 2000
        end
        Wait(sleep)
    end
end)
