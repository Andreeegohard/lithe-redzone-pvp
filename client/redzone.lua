local Zones = {}

function AddPolyZone(name, points, options)
    Zones[name] = PolyZone:Create(points, options)
end

function IsPlayerInRedZone(playerPed)
    if playerPed then
        local playerPos = GetEntityCoords(playerPed)
        for zoneName, polyZone in pairs(Zones) do
            if polyZone:isPointInside(playerPos) then
                return true, zoneName
            end
        end
    end
    return false, nil
end


function ManageWeapons(playerPed)
    local isInRedZone, zoneName = IsPlayerInRedZone(playerPed)
    if isInRedZone then
        local zoneData = RedzoneConfig[zoneName]
        if not zoneData then return end

        local allowedWeapon = zoneData.allowedWeapon
        local allowedWeaponHash = GetHashKey(allowedWeapon)

        for i = 1, 12 do  
            local weaponHash = GetHashKey(GetWeapontypeGroup(i))
            if weaponHash ~= allowedWeaponHash then
                RemoveWeaponFromPed(playerPed, weaponHash)
            end
        end

        if not HasPedGotWeapon(playerPed, allowedWeaponHash, false) then
            GiveWeaponToPed(playerPed, allowedWeaponHash, 1000, false, true)
        end

        SetPedAmmo(playerPed, allowedWeaponHash, 1000)

        local currentWeapon = GetSelectedPedWeapon(playerPed)
        if currentWeapon ~= allowedWeaponHash then
            SetPlayerCanDoDriveBy(PlayerId(), false)
            DisableControlAction(0, 24, true) 
        else
            SetPlayerCanDoDriveBy(PlayerId(), true)
        end
    else

        for i = 1, 12 do
            local weaponHash = GetHashKey(GetWeapontypeGroup(i))
            RemoveWeaponFromPed(playerPed, weaponHash)
        end
    end
end

function getRandomPointInRedzone(zoneName)
    local zoneData = RedzoneConfig[zoneName]
    if not zoneData then return nil end
    local randomIndex = math.random(1, #zoneData.RespawnCoords)
    local selectedCoord = zoneData.RespawnCoords[randomIndex]
    local x = selectedCoord.x
    local y = selectedCoord.y
    local z = selectedCoord.z
    local groundZ = nil
    local attempts = 10
    local maxRange = 1000.0 
    for i = 1, attempts do
        local success, foundZ = GetGroundZFor_3dCoord(x, y, maxRange - (i - 1) * 100)

        if success then
            if foundZ and foundZ >= 29.4697418212 and foundZ <= 38.0 then
                groundZ = foundZ
                break
            end
        end
    end
    if not groundZ then
        groundZ = z
    end

    return vector3(x, y, groundZ)
end

function teleportPlayerToRedzone(zoneName)
    local playerPed = PlayerPedId()
    local respawnPoint = getRandomPointInRedzone(zoneName)
    if not respawnPoint then return end
    TriggerEvent(Config.TriggerRevive, respawnPoint)
end

RegisterNetEvent("redzone:revive")
AddEventHandler("redzone:revive", function(respawnPoint)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, respawnPoint.x, respawnPoint.y, respawnPoint.z)
    NetworkResurrectLocalPlayer(respawnPoint.x, respawnPoint.y, respawnPoint.z, GetEntityHeading(playerPed), true, false)
    SetEntityHealth(playerPed, 200)
    SetEntityVisible(playerPed, true, false)
end)

Citizen.CreateThread(function()
    for zoneName, zoneData in pairs(RedzoneConfig) do
        AddPolyZone(zoneName, zoneData.coords, {
            name = zoneName,
            minZ = zoneData.minZ,
            maxZ = zoneData.maxZ,
            debugGrid = zoneData.debug, 
            gridDivisions = 25
        })
    end

    while true do
        Citizen.Wait(1000) 
        local playerPed = PlayerPedId()
        if IsEntityDead(playerPed) then
            local isInRedZone, currentZone = IsPlayerInRedZone(playerPed)
            if isInRedZone then
                teleportPlayerToRedzone(currentZone)
            end
        end
        ManageWeapons(playerPed) 
    end
end)

RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    SetEntityVisible(PlayerPedId(), true, false)
end)

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
    local playerPed = PlayerPedId()
    local isInRedZone, _ = IsPlayerInRedZone(playerPed)
    if isInRedZone then
        SetEntityVisible(playerPed, false, false)
    end
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
    local playerPed = PlayerPedId()
    local isInRedZone, _ = IsPlayerInRedZone(playerPed)
    if isInRedZone then
        SetEntityVisible(playerPed, false, false)
    end
end)



local serverPresent = false

RegisterNetEvent('redzone:clientsideimportant')
AddEventHandler('redzone:clientsideimportant', function(response)
    serverPresent = response
end)

Citizen.CreateThread(function()
    TriggerServerEvent('redzone:serversideimportant')
    
    Citizen.Wait(5000) 

    if not serverPresent then
        return
    end


end)
