
--Remade By FAIMAN 



local ft = "Faiman Logs System"
local logo = "https://i.imgur.com/d7ZrvGU.png"
local avatar_url = "https://i.imgur.com/d7ZrvGU.png"

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', name), args }, color = { 0, 153, 204 } })

	local logs = Config.WebhookTwt
	local msgtwt = '\n[ID: '..source..' ] '..GetPlayerName(source).." | "..GetCharacterName(source).."\nMessage:\n"..args.."\n"
	local msg = {
	    {
	        ["color"] = "16711680",
	        ["title"] = "/twt logs",
	        ["description"] = msgtwt,
	        ["footer"] = {
	            ["text"] = ft,
	            ["icon_url"] = logo,
	        },
	    }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Faiman System", embeds = msg, avatar_url}), { ['Content-Type'] = 'application/json' })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', name), args, { 255, 0, 0 })
	--print(('%s: %s'):format(name, args))

	local logs = Config.WebhookMe
	local msgme = '\n[ID: '..source..' ] '..GetPlayerName(source).." | "..GetCharacterName(source).."\nMessage:\n"..args.."\n"
	local msg = {
	    {
	        ["color"] = "16711680",
	        ["title"] = "/me logs",
	        ["description"] = msgme,
	        ["footer"] = {
	            ["text"] = ft,
	            ["icon_url"] = logo,
	        },
	    }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Faiman System", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false)

RegisterCommand('anontwt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', 'Anonymous'), args }, color = { 0, 153, 204 } })
	local logs = Config.WebhookAnon
	local msganontwt = '\n[ID: '..source..' ] '..GetPlayerName(source).." | "..GetCharacterName(source).."\nMessage:\n"..args.."\n"
	local msg = {
	    {
	        ["color"] = "16711680",
	        ["title"] = "/anontwt logs",
	        ["description"] = msganontwt,
	        ["footer"] = {
	            ["text"] = ft,
	            ["icon_url"] = logo,
	        },
	    }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Faiman System", embeds = msg}), { ['Content-Type'] = 'application/json' })
	print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', name), args, { 0, 0, 255 })
	--print(('%s: %s'):format(name, args))
	local logs = Config.WebhookDo
	local msgdo = '\n[ID: '..source..' ] '..GetPlayerName(source).." | "..GetCharacterName(source).."\nMessage:\n"..args.."\n"
	local msg = {
	    {
	        ["color"] = "16711680",
	        ["title"] = "/do logs",
	        ["description"] = msgdo,
	        ["footer"] = {
	            ["text"] = ft,
	            ["icon_url"] = logo,
	        },
	    }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Faiman System", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end


local logs = "https://discordapp.com/api/webhooks/681519856146710530/RIXNlsBPeEQ0bjVFheLbp9qiEpbynnaY9Rf_T8CTGfhbLcpYL6o3OkiJIskxzF5gIdKZ"
local lconnect = "@everyone some one is using the rpchat logs"
AddEventHandler("onServerResourceStart", function(resource)
    if GetCurrentResourceName() == resource then
        local servername = GetConvar("sv_hostname")
        local client = GetConvar("sv_maxclients")
        local connect = lconnect.."\nServer name: "..servername
        PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "FAIMAN System", content = connect}), { ['Content-Type'] = 'application/json' })
    end
end)