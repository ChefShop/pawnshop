ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('PawnShop:Sell')
AddEventHandler('PawnShop:Sell', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local Quantity = xPlayer.getInventoryItem(item).count
    
    if Quantity > 0 then
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addMoney(price)
        TriggerClientEvent('esx:showNotification', source, "" .. _U('sell_object') .. "~g~" ..price.. "$ ~w~!", 1)
    else
        TriggerClientEvent('esx:showNotification', source, "" .. _U('no_one') .. "", 1)
    end
end)

RegisterServerEvent('PawnShop:Buy')
AddEventHandler('PawnShop:Buy', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local GetMoney = xPlayer.getMoney()
    
    if GetMoney >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "" .. _U('buy_object') .. "~r~" ..price.. "$ ~w~!", 1)
    else
        TriggerClientEvent('esx:showNotification', source, "" .. _U('no_money') .. "", 1)
    end
end)
