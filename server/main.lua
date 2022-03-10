local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('jerzys_billing:server:sendBilling', function (data)
    local src = source

    -- Data where to send Billing & what
    local playerId = data[1]
    local ammount = data[2]
    local title = data[3]
    local text = data[4]

    -- Get Current Player and Player to send Billing
    local billedPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
    local currentPlayer = QBCore.Functions.GetPlayer(source)

    -- Assets you need
    local name = currentPlayer.PlayerData.charinfo.firstname..' '..currentPlayer.PlayerData.charinfo.lastname
    local cId  = currentPlayer.PlayerData.citizenid
    
    -- Check Current Player & Player
    if currentPlayer ~= nil then
        if billedPlayer ~= nil then
            TriggerClientEvent('jerzys_billing:client:sendBilling', playerId, ammount, title, text, name, cId)
            else
            TriggerClientEvent('jerzys_billing:client:error', src, {error = 'online'})
        end
    else
        TriggerClientEvent('jerzys_billing:client:error', src, {error = 'player'})
    end

end)

RegisterNetEvent('jerzys_billing:server:doneBilling',function(data)
    
    -- Data
    local ammount = data["ammount"];

    -- Getting Billed / Billed
    local currentPlayer = QBCore.Functions.GetPlayer(source)
    local paidPlayer = QBCore.Functions.GetPlayerByCitizenId(data["cid"])
    local currentPlayerFirstName = currentPlayer.PlayerData.charinfo.firstname
    
    -- Bank & Cash
    local getBank = currentPlayer.PlayerData.money["bank"]
    local getCash = currentPlayer.PlayerData.money["cash"]

    -- Check Money & Pay player
    if(Config.useCash == true) then
        if currentPlayer ~= nil then
            if getCash - ammount >= 0 then
                currentPlayer.Functions.RemoveMoney("cash", ammount, "jerzys_billing-paid")
                if paidPlayer ~= nil then
                    paidPlayer.Functions.AddMoney("cash", ammount, "jerzys_billing-paid");
                    TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "You have recived $"..ammount.."$ from: "..currentPlayerFirstName.." cash!", "success")
                end
            else
                TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "Player doesnt have money to pay the bill!", "success")
                TriggerClientEvent("QBCore:Notify", currentPlayer.PlayerData.source, "You don't have enough Cash!", "error")
            end
        end
    else
        if currentPlayer ~= nil then
            if getBank - ammount >= 0 then
                currentPlayer.Functions.RemoveMoney("bank", ammount, "jerzys_billing-paid")
                if paidPlayer ~= nil then
                    paidPlayer.Functions.AddMoney("bank", ammount, "pjerzys_billing-paid");
                    TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "You have recived $"..ammount.."$ from: "..currentPlayerFirstName.." bank!", "success")
                end
            else
                TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "Player doesnt have money to pay the bill!", "success")
                TriggerClientEvent("QBCore:Notify", currentPlayer.PlayerData.source, "You don't have enough Bank!", "error")
            end
        end
    end
end)
