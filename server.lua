ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_coffeemachine:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_coffeemachine:pay')
AddEventHandler('esx_coffeemachine:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	math.randomseed(os.time())
    local rozbiti = math.random(1, 3)
	if rozbiti == 3 then
        TriggerClientEvent("esx:showNotification", source, "Coffee Machine was break and your money is gone.  🦀")
		xPlayer.removeMoney(Config.Price)
    elseif rozbiti == 2 or rozbiti == 1 then
		TriggerClientEvent('esx:showNotification', source, 'You paid $' .. Config.Price .. ' to machine.')
		TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
		xPlayer.removeMoney(Config.Price)
    end
	

	--[[if Config.GiveSocietyMoney then
		TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society, function(account)
			account.addMoney(Config.Price)
		end)
	end]]
end)
