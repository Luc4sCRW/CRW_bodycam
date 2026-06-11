local ESX = exports['es_extended']:getSharedObject()

exports('useBodycam', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local source = inventory.id
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if not xPlayer then return false end

        -- Job Check
        if Config.AllowedJobs[xPlayer.job.name] then
            local name = xPlayer.getName()
            TriggerClientEvent('CRW_bodycam:toggle', source, name)
            return false 
        else
            TriggerClientEvent('ox_lib:notify', source, {
                type = 'error', 
                description = _U('dialog_permission')
            })
            return false
        end
    end
end)

-- Callback für den Item Check // Callback for the item check
ESX.RegisterServerCallback('CRW_bodycam:checkItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end
        
    local item = xPlayer.getInventoryItem(Config.ItemName)
    if item and item.count > 0 then
        cb(true)
    else
        cb(false)
    end
end)
