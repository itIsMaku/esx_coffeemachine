ESX                           = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        local sleepThread = 1000
        local entity, entityDst = ESX.Game.GetClosestObject(Config.Machines)

        if DoesEntityExist(entity) and entityDst <= 1.5 then
            sleepThread = 5

            local binCoords = GetEntityCoords(entity)

            ESX.Game.Utils.DrawText3D(binCoords + vector3(0.0, 0.0, 0.5), "~w~Press ~r~E ~w~for buy coffee!", 0.7)

            if IsControlJustReleased(0, 38) then
				ESX.TriggerServerCallback('esx_coffeemachine:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						ZapnoutAutomat()
					else
						ESX.ShowNotification('You do not have $' .. Config.Price .. ' to buy coffee.')
					end
				end)
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

function ZapnoutAutomat()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
    Citizen.Wait(6000)
    TriggerServerEvent("esx_coffeemachine:pay")
    ClearPedTasks(PlayerPedId())
end
