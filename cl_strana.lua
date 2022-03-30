local ESX, PlayerData = nil, {}

CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(250) end
	while ESX.GetPlayerData().job == nil do Wait(250) end
	PlayerData = ESX.GetPlayerData()
end)

print("devTomić | Kladionica Pokrenuta!")

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
		
exports["qtarget"]:AddCircleZone("kladara", vector3(Config.Kladionica.Lokacija), 1.35, {
name="kladara",
debugPoly=false,
useZ=true,
}, {
options = {
                      {
                          event = "devtomic_kladionica:otvori",
                          icon = "fas fa-envelope",
                          label = "Otvori Kladaru",
                      },
                   },
                     distance = 2.5
            })                  
end)


RegisterNetEvent('devtomic_kladionica:otvori')
AddEventHandler('devtomic_kladionica:otvori', function()
    ESX.TriggerServerCallback('devtomic_kladionica:povuciutakmice', function(utakmicex)
        local tekme = {}
        if PlayerData.job and PlayerData.job.name == Config.Kladionica.VlasnikPosao then
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 0,
                    header = 'Danasnja ponuda || devTomić',
                    txt = ''
                },
            })

            if utakmicex ~= nil then
                for k, v in pairs(utakmicex) do
                    local IDUtakmice = v.id
                    table.insert(tekme, {
                        id = k,
                        header = 'ID: '..v.id..' | '..v.tim1..' - '..v.tim2..' | '..v.status..'!',
                        txt = '1: '..v.kec..' | X: '..v.x..' | 2: '..v.dvojka..'',
                        params = {
                            event = 'devtomic_kladionica:ulozi',
                            args = IDUtakmice,
                        }
                    })
                end
                if #tekme ~= 0 then
                    TriggerEvent('nh-context:sendMenu', tekme)
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+1,
                            header = '=================================',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+2,
                            header = 'Gazda Meni',
                            txt = 'Upravljajte kladionicom.',
                            params = {
                                event = 'devtomic_kladionica:otvoriBoss',
                            }
                        },
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+3,
                            header = 'Isplatite tikete!',
                            txt = '',
                            params = {
                                event = 'devtomic_kladionica:isplatiulog',
                            }
                        },
                    })
                else
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = 1,
                            header = 'Danas nema nikakvih ponuda!',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+1,
                            header = '=================================',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+2,
                            header = 'Gazda Meni',
                            txt = 'Upravljajte kladionicom.',
                            params = {
                                event = 'devtomic_kladionica:otvoriBoss',
                            }
                        },
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+3,
                            header = 'Isplatite tikete!',
                            txt = '',
                            params = {
                                event = 'devtomic_kladionica:isplatiulog',
                            }
                        },
                    })
                end
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'Danas nema nikakvih ponuda!',
                        txt = ''
                    }
                })
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = #tekme+1,
                        header = '=================================',
                        txt = ''
                    }
                })
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = #tekme+2,
                        header = 'Gazda Meni',
                        txt = 'Upravljajte kladionicom.',
                        params = {
                            event = 'devtomic_kladionica:otvoriBoss',
                        }
                    },
                })
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = #tekme+3,
                        header = 'Isplatite tikete!',
                        txt = '',
                        params = {
                            event = 'devtomic_kladionica:isplatiulog',
                        }
                    },
                })
            end
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
        else
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 0,
                    header = 'Danasnja ponuda || devTomić',
                    txt = ''
                },
            })
            
            if utakmicex ~= nil then
                for k, v in pairs(utakmicex) do
                    local IDUtakmice = v.id
                    table.insert(tekme, {
                        id = k,
                        header = 'ID: '..v.id..' | '..v.tim1..' - '..v.tim2..' | '..v.status..'!',
                        txt = '1: '..v.kec..' | X: '..v.x..' | 2: '..v.dvojka..'',
                        params = {
                            event = 'devtomic_kladionica:ulozi',
                            args = IDUtakmice,
                        }
                    })
                end
                if #tekme ~= 0 then
                    TriggerEvent('nh-context:sendMenu', tekme)
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+1,
                            header = '=================================',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+3,
                            header = 'Isplatite tikete!',
                            txt = '',
                            params = {
                                event = 'devtomic_kladionica:isplatiulog',
                            }
                        },
                    })
                else
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = 1,
                            header = 'Danas nema nikakvih ponuda!',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+1,
                            header = '=================================',
                            txt = ''
                        }
                    })
                    TriggerEvent('nh-context:sendMenu', {
                        {
                            id = #tekme+3,
                            header = 'Isplatite tikete!',
                            txt = '',
                            params = {
                                event = 'devtomic_kladionica:isplatiulog',
                            }
                        },
                    })
                end
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'Danas nema nikakvih ponuda!',
                        txt = ''
                    }
                })
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = #tekme+1,
                        header = '=================================',
                        txt = ''
                    }
                })
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = #tekme+3,
                        header = 'Isplatite tikete!',
                        txt = '',
                        params = {
                            event = 'devtomic_kladionica:isplatiulog',
                        }
                    },
                })
            end
        end
    end, utakmicex)
end)

RegisterNetEvent('devtomic_kladionica:otvoriBoss')
AddEventHandler('devtomic_kladionica:otvoriBoss', function()
    ESX.TriggerServerCallback('devtomic_kladionica:povuciutakmice', function(utakmicex)
        if PlayerData.job and PlayerData.job.name == Config.Kladionica.VlasnikPosao then
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 0,
                    header = 'Gazda Meni || devTomić',
                    txt = ''
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'Zapocnite utakmicu',
                    txt = 'Pokrenite utakmicu.',
                    params = {
                        event = 'devtomic_kladionica:pokreniteutakmicu',
                    }
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 2,
                    header = '=================================',
                    txt = '',
                    params = {
                        event = '',
                    }
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 3,
                    header = 'Dodajte utakmicu',
                    txt = 'Dodajte novu utakmicu na ponudu.',
                    params = {
                        event = 'devtomic_kladionica:novautakmica',
                    }
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 4,
                    header = 'Uredite utakmicu',
                    txt = 'Uredite rezultat.',
                    params = {
                        event = 'devtomic_kladionica:urediteutakmicu',
                    }
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 5,
                    header = 'Obrisite utakmicu',
                    txt = 'Sklonite utakmicu s ponude.',
                    params = {
                        event = 'devtomic_kladionica:obrisiteutakmicu',
                    }
                },
            })

            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 6,
                    header = '< Natrag',
                    txt = '',
                    params = {
                        event = 'devtomic_kladionica:otvori',
                    }
                },
            })
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
            ------------------------------------------------------------------------------------------
        else
            ESX.ShowNotification("devTomić | Niste gazda kladionice!")
        end
    end, utakmicex)
end)

RegisterNetEvent('devtomic_kladionica:novautakmica')
AddEventHandler('devtomic_kladionica:novautakmica', function()
    local novautakmica = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "Tim 1"
            },
            {
                id = 1, 
                txt = "Tim 2"
            },
            {
                id = 2, 
                txt = "1 [Kvota]"
            },
            {
                id = 3, 
                txt = "X [Kvota]"
            },
            {
                id = 4, 
                txt = "2 [Kvota]"
            },
        }
    })
    if novautakmica ~= nil then
        -- print(novautakmica[1].input)
        if novautakmica[1].input == nil or novautakmica[2].input == nil or novautakmica[3].input == nil or novautakmica[4].input == nil or novautakmica[5].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("postaviutakmicu "..novautakmica[1].input.." "..novautakmica[2].input.." "..novautakmica[3].input.." "..novautakmica[4].input.." "..novautakmica[5].input.."")
        end
    end
end)

RegisterNetEvent('devtomic_kladionica:isplatiulog')
AddEventHandler('devtomic_kladionica:isplatiulog', function()
    local isplatiulog = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "ID Utakmice"
            },
        }
    })
    if isplatiulog ~= nil then
        -- print(isplatiulog[1].input)
        if isplatiulog[1].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("isplatiulog "..isplatiulog[1].input.."")
        end
    end
end)

RegisterNetEvent('devtomic_kladionica:urediteutakmicu')
AddEventHandler('devtomic_kladionica:urediteutakmicu', function()
    local urediteutakmicu = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "ID Utakmice"
            },
            {
                id = 1, 
                txt = "1 / X / 2"
            },
        }
    })
    if urediteutakmicu ~= nil then
        -- print(urediteutakmicu[1].input)
        if urediteutakmicu[1].input == nil or urediteutakmicu[2].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("urediutakmicu "..urediteutakmicu[1].input.." "..urediteutakmicu[2].input.."")
        end
    end
end)

RegisterNetEvent('devtomic_kladionica:obrisiteutakmicu')
AddEventHandler('devtomic_kladionica:obrisiteutakmicu', function()
    local obrisiteutakmicu = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "ID Utakmice"
            },
        }
    })
    if obrisiteutakmicu ~= nil then
        -- print(obrisiteutakmicu[1].input)
        if obrisiteutakmicu[1].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("obrisiutakmicu "..obrisiteutakmicu[1].input.."")
        end
    end
end)

RegisterNetEvent('devtomic_kladionica:pokreniteutakmicu')
AddEventHandler('devtomic_kladionica:pokreniteutakmicu', function()
    local pokreniteutakmicu = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "ID Utakmice"
            },
        }
    })
    if pokreniteutakmicu ~= nil then
        -- print(pokreniteutakmicu[1].input)
        if pokreniteutakmicu[1].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("zapocniutakmicu "..pokreniteutakmicu[1].input.."")
        end
    end
end)

RegisterNetEvent('devtomic_kladionica:ulozi')
AddEventHandler('devtomic_kladionica:ulozi', function(IDUtakmice)
    -- print(IDUtakmice)
    local ovastvar = exports['zf_dialog']:DialogInput({
        header = "Kladionica", 
        rows = {
            {
                id = 0, 
                txt = "1 / X / 2"
            },
            {
                id = 1, 
                txt = "Kolicina? ($100 - $50.000)"
            },
        }
    })
    if ovastvar ~= nil then
        if ovastvar[1].input == nil or ovastvar[2].input == nil then
            ESX.ShowNotification('devTomić | Neispravan unos.')
        else
            ExecuteCommand("kladise "..IDUtakmice.." "..ovastvar[2].input.." "..ovastvar[1].input.."")
        end
    end
end)
