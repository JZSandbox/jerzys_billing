local QBCore = exports['qb-core']:GetCoreObject()

function closeMenu()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeMenu'
    })
end

if(Config.useCommand == true) then
    RegisterCommand('jzBilling', function ()
        local xPlayer = QBCore.Functions.GetPlayerData()
        TriggerEvent('jerzys_billing:client:openEvent', xPlayer)
    end)
    RegisterNetEvent('jerzys_billing:client:openEvent', function (data)
        local xPlayer = data;
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openMenu',
            player = xPlayer,
        })
    end)
end

if(Config.useTarget == true) then
    RegisterNetEvent('jerzys_billing:client:openBillingMenu', function ()
        local xPlayer = QBCore.Functions.GetPlayerData()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openMenu',
            player = xPlayer,
        })
    end)
end

RegisterNUICallback('hideMenu', function ()
    closeMenu()
end)

RegisterNUICallback('error', function ()
    QBCore.Functions.Notify('Please look at the Billing again!', 'error', 5000)
end)

RegisterNUICallback('submitBilling', function (data, cb)

    local playerId = data.player
    local ammount = data.ammount
    local title = data.title
    local text = data.text

    TriggerServerEvent('jerzys_billing:server:sendBilling', {playerId, ammount, title, text})

end)


RegisterNetEvent('jerzys_billing:client:sendBilling', function (ammount, title, text, name, cId)
    local data = {}
    data = {ammount = ammount, cid = cId}
    TriggerServerEvent('qb-phone:server:sendNewMail', {
    sender = name,
    subject = title,
    message = string.format([[
        <div class="jerzys_billing_text">%s</div><div class="jerzys_billing_ammount"> Amount: %s $</div> <br>You can accept and decline by using the buttons on the bottom
        ]],text,ammount),
    button = {
        enabled = true,
        buttonEvent = 'jerzys_billing:client:confirm',
        buttonData = data;
        }
    })

end)

RegisterNetEvent('jerzys_billing:client:confirm',function(data)
    TriggerServerEvent('jerzys_billing:server:doneBilling', data)
end)


-- Error Handler
RegisterNetEvent('jerzys_billing:client:error', function(data)
    if data.error == "online" then
        QBCore.Functions.Notify('Player is currenlty not online!', 'error', 5000)
    end

    if data.error == "player" then
        QBCore.Functions.Notify('Who are you?', 'error', 5000)
    end
end)