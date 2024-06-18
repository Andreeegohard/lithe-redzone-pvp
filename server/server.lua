print("Lithe Redzone Started UP")


RegisterNetEvent('redzone:serversideimportant')
AddEventHandler('redzone:serversideimportant', function()
    local src = source
    TriggerClientEvent('redzone:clientsideimportant', src, true)
end)
