ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print("devTomić | Kladionica Pokrenuta!")

ESX.RegisterServerCallback('devtomic_kladionica:povuciutakmice', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica", {}, function(rezultat)
        local utakmicex = {}
        if rezultat then
            for i = 1, #rezultat, 1 do
                table.insert(utakmicex, {id = rezultat[i].id, tim1 = rezultat[i].tim1, tim2 = rezultat[i].tim2, kec = rezultat[i].kec, x = rezultat[i].x, dvojka = rezultat[i].dvojka, status = rezultat[i].status})
            end
            cb(utakmicex)
        end
    end)
end)

RegisterCommand("postaviutakmicu", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.Kladionica.VlasnikPosao then
        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil and tonumber(args[4]) ~= nil and tonumber(args[5]) ~= nil then
            xPlayer.showNotification("devTomić | Postavili ste novu utakmicu!")
            MySQL.Async.execute("INSERT INTO tomic_kladionica (tim1, tim2, kec, x, dvojka) VALUES (@tim1, @tim2, @kec, @x, @dvojka)", { ["@tim1"] = args[1], ["@tim2"] = args[2], ["@kec"] = tonumber(args[3]), ["@x"] = tonumber(args[4]), ["@dvojka"] = args[5] } )
        else
            xPlayer.showNotification("devTomić | Tim1, Tim2, [1-Kvota], [X-Kvota], [2-Kvota]")
        end
    else
        xPlayer.showNotification("devTomić | Niste gazda kladionice!")
    end
end)

RegisterCommand("zapocniutakmicu", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.Kladionica.VlasnikPosao then
        MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica WHERE id = @id", { ["@id"] = tonumber(args[1]) }, function(rezultat)
            if tonumber(args[1]) ~= nil then
                if rezultat then
                    for i = 1, #rezultat, 1 do
                        if rezultat[i].status == 'Nije Pocelo' then
                            if tonumber(args[1]) == tonumber(rezultat[i].id) then
                                xPlayer.showNotification("devTomić | Zapoceli ste utakmicu "..args[1].."!")
                                MySQL.Sync.execute("UPDATE tomic_kladionica SET status = @status WHERE id = @id", { ["@id"] = tonumber(args[1]), ["@status"] = 'U tijeku' })
                            else
                                xPlayer.showNotification("devTomić | Ta utakmica ne postoji!")
                            end
                        else
                            xPlayer.showNotification("devTomić | Utakmica je vec zapoceta!")
                        end
                    end
                else
                    xPlayer.showNotification("devTomić | Ta utakmica ne postoji!")
                end
            else
                xPlayer.showNotification("devTomić | ID Utakmice")
            end
        end)
    else
        xPlayer.showNotification("devTomić | Niste gazda kladionice!")
    end
end)

RegisterCommand("urediutakmicu", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.Kladionica.VlasnikPosao then
        MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica WHERE id = @id", { ["@id"] = tonumber(args[1]) }, function(rezultat)
            if rezultat then
                for i = 1, #rezultat, 1 do
                    if tonumber(args[1]) ~= nil and args[2] ~= nil and (args[2] == "X" or args[2] == "x" or args[2] == "1" or args[2] == "2") then
                        MySQL.Sync.execute("UPDATE tomic_kladionica SET status = @status WHERE id = @id", { ["@id"] = tonumber(args[1]), ["@status"] = args[2] })
                    else
                        xPlayer.showNotification("devTomić | ID, 1/X/2")
                    end
                end
            else
                xPlayer.showNotification("devTomić | Ta utakmica ne postoji!")
            end
        end)    
    else
        xPlayer.showNotification("devTomić | Niste gazda kladionice!")
    end
end)

RegisterCommand("obrisiutakmicu", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.Kladionica.VlasnikPosao then
        MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica WHERE id = @id", { ["@id"] = tonumber(args[1]) }, function(rezultat)
            if rezultat then
                for i = 1, #rezultat, 1 do
                    if tonumber(args[1]) ~= nil then
                        xPlayer.showNotification("devTomić | Obrisali ste utakmicu broj: "..tonumber(args[1]).."!")
                        MySQL.Async.execute("DELETE FROM tomic_kladionica WHERE id LIKE @id", {
                            ["@id"] = tonumber(args[1]),
                        })
                    else
                        xPlayer.showNotification("devTomić | ID Utakmice")
                    end
                end
            else
                xPlayer.showNotification("devTomić | Ta utakmica ne postoji!")
            end
        end)
    else
        xPlayer.showNotification("devTomić | Niste gazda kladionice!")
    end
end)

RegisterCommand("isplatiulog", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(args[1]) ~= nil then
        MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica WHERE id = @id", { ["@id"] = tonumber(args[1]) }, function(rezultat)
            if rezultat then
                for i = 1, #rezultat, 1 do
                    MySQL.Async.fetchAll("SELECT * FROM tomic_kladjenja WHERE igrac = @igrac ", { ["@igrac"] = xPlayer.identifier }, function(ulog)
                        if ulog then
                            for i = 1, #ulog, 1 do
                                if rezultat[i] then
                                    if rezultat[i].status ~= 'Nije Pocelo' and rezultat[i].status ~= 'U tijeku' then
                                        if ulog[i] then
                                            if rezultat[i].status == 'X' then
                                                if (rezultat[i].id and rezultat[i].status) == (ulog[i].tekma and ulog[i].x12) then
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                    xPlayer.addMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].x))
                                                    xPlayer.showNotification("devTomić | Isplatili ste $"..ESX.Math.Round(ulog[i].ulog * rezultat[i].x).." od utakmice: "..args[1].."!")
                                                    if Config.Kladionica.Society ~= false then
                                                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kladionica', function(account)
                                                            account.removeMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].x))
                                                        end)
                                                    end
                                                else
                                                    xPlayer.showNotification("devTomić | Niste dobili nista na kladionici. Izgubili ste $"..json.encode(ESX.Math.Round(tonumber(ulog[i].ulog))).."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                end
                                            elseif rezultat[i].status == 'x' then
                                                if (rezultat[i].id and rezultat[i].status) == (ulog[i].tekma and ulog[i].x12) then
                                                    xPlayer.addMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].x))
                                                    xPlayer.showNotification("devTomić | Isplatili ste $"..ESX.Math.Round(ulog[i].ulog * rezultat[i].x).." od utakmice: "..args[1].."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                    if Config.Kladionica.Society ~= false then
                                                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kladionica', function(account)
                                                            account.removeMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].x))
                                                        end)
                                                    end
                                                else
                                                    xPlayer.showNotification("devTomić | Niste dobili nista na kladionici. Izgubili ste $"..json.encode(ESX.Math.Round(tonumber(ulog[i].ulog))).."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                end
                                            elseif rezultat[i].status == '1' then
                                                if (json.encode(rezultat[i].id) and json.encode(rezultat[i].status)) == (json.encode(ulog[i].tekma) and json.encode(ulog[i].x12)) then
                                                    xPlayer.addMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].kec))
                                                    xPlayer.showNotification("devTomić | Isplatili ste $"..ESX.Math.Round(ulog[i].ulog * rezultat[i].kec).." od utakmice: "..args[1].."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                    if Config.Kladionica.Society ~= false then
                                                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kladionica', function(account)
                                                            account.removeMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].kec))
                                                        end)
                                                    end
                                                else
                                                    xPlayer.showNotification("devTomić | Niste dobili nista na kladionici. Izgubili ste $"..json.encode(ESX.Math.Round(tonumber(ulog[i].ulog))).."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                end
                                            elseif rezultat[i].status == '2' then
                                                if (rezultat[i].id and rezultat[i].status) == (ulog[i].tekma and ulog[i].x12) then
                                                    xPlayer.addMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].dvojka))
                                                    xPlayer.showNotification("devTomić | Isplatili ste $"..ESX.Math.Round(ulog[i].ulog * rezultat[i].dvojka).." od utakmice: "..args[1].."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                    if Config.Kladionica.Society ~= false then
                                                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kladionica', function(account)
                                                            account.removeMoney(ESX.Math.Round(ulog[i].ulog * rezultat[i].dvojka))
                                                        end)
                                                    end
                                                else
                                                    xPlayer.showNotification("devTomić | Niste dobili nista na kladionici. Izgubili ste $"..json.encode(ESX.Math.Round(tonumber(ulog[i].ulog))).."!")
                                                    MySQL.Async.execute('DELETE from tomic_kladjenja WHERE igrac = @igrac AND tekma = @tekma', {
                                                        ['@igrac'] = xPlayer.identifier,
                                                        ['@tekma'] = tonumber(args[1])
                                                    })
                                                end
                                            end
                                        end
                                    else
                                        xPlayer.showNotification("devTomić | Ne mozete isplatiti ulog jer utakmica nije zavrsena!")
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
    else
        xPlayer.showNotification("devTomić | ID Utakmice")
    end
end)

RegisterCommand("kladise", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM tomic_kladionica WHERE id = @id", { ["@id"] = args[1] }, function(rezultat)
        if rezultat then
            MySQL.Async.fetchAll("SELECT * FROM tomic_kladjenja WHERE igrac = @igrac ", { ["@igrac"] = xPlayer.identifier }, function(ulog)
                if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil and args[3] ~= nil and (args[3] == "X" or args[3] == "x" or args[3] == "1" or args[3] == "2") then
                    for i = 1, #rezultat, 1 do
                        if tonumber(args[1]) == rezultat[i].id then
                            if rezultat[i].status == 'Nije Pocelo' then
                                local max = MySQL.Sync.fetchScalar("SELECT COUNT(tekma) FROM tomic_kladjenja WHERE tekma = @tekma AND igrac = @igrac", { ["@tekma"] = tonumber(args[1]), ["@igrac"] = xPlayer.identifier} )
                                if max < 1 then
                                    if tonumber(args[2]) <= Config.Kladionica.MaxUlog and tonumber(args[2]) >= Config.Kladionica.MinUlog then
                                        if xPlayer.getMoney() >= tonumber(args[2]) then
                                            xPlayer.removeMoney(ESX.Math.Round(tonumber(args[2])))
                                            MySQL.Async.execute("INSERT INTO tomic_kladjenja (igrac, imeigraca, tekma, ulog, x12) VALUES (@igrac, @imeigraca, @tekma, @ulog, @x12)", { ["@igrac"] = xPlayer.identifier, ["@imeigraca"] = GetPlayerName(xPlayer.source), ["@tekma"] = tonumber(args[1]), ["@ulog"] = tonumber(args[2]), ["@x12"] = args[3] } )
                                            xPlayer.showNotification("devTomić | Stavili ste $"..tonumber(args[2]).." na "..args[3]..", utakmica broj: "..tonumber(args[1]).."!")
                                            if Config.Kladionica.Society ~= false then
                                                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..Config.Kladionica.Society, function(account)
                                                    account.addMoney(ESX.Math.Round(tonumber(args[2])))
                                                end)
                                            end
                                        else
                                            xPlayer.showNotification("devTomić | Nemate dovoljno novca!")
                                        end
                                    else
                                        xPlayer.showNotification("devTomić | Ulog ne moze biti manji od $100 i veci od $50000!")
                                    end
                                else
                                    xPlayer.showNotification("devTomić | Vec ste se kladili na tu utakmicu!")
                                end
                            else
                                xPlayer.showNotification("devTomić | Ne mozete se trenutno kladiti na ovu utakmicu!")
                            end
                        else
                            xPlayer.showNotification("devTomić | Ta utakmica ne postoji!")
                        end
                    end
                else
                    xPlayer.showNotification("devTomić | ID Utakmice, Kolicina, 1/X/2!")
                end
            end)
        end
    end)
end)