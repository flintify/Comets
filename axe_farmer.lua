local v1 = { os.time() }

print('[!] Axe Farmer Loaded in ' .. tostring(os.time() - v1[1] + math.random(4, 100) / math.random(90, 250)))
Settings = _G.Settings
local function u21(p20)
    return game:GetService('HttpService'):JSONEncode(p20)
end
local function u23(p22)
    return game:GetService('HttpService'):JSONDecode(p22)
end
local function v25(p24)
    return tonumber(p24:sub(1, -2)) * ({
        s = 1,
        m = 60,
        h = 3600,
        d = 86400
    })[p24:sub(-1)]
end
local function u28(p26, p27)
    game:GetService('TeleportService'):TeleportToPlaceInstance(p26, p27)
end
PLACE_ID = 0
if not Settings.Comets['Webhook URL']:match('https://discord.com/') then
    Settings.Comets['Webhook URL'] = nil
end
if string.lower(Settings.Mode) == 'normal' or string.lower(Settings.Mode) == 'n' then
    PLACE_ID = 6284583030
else
    PLACE_ID = 10321372166
end
local v29 = require(game:GetService('ReplicatedStorage'):WaitForChild('Library').Client.Network)
debug.setupvalue(v29.Invoke, 1, function()
    return true
end)
Invoke = v29.Invoke
debug.setupvalue(v29.Fire, 1, function()
    return true
end)
Fire = v29.Fire
repeat
    task.wait()
until game.Players.LocalPlayer
local localPlayer = game.Players.LocalPlayer
local discord = Settings.Discord
local u30 = v25(Settings.Statistics['Waiting Time'])
repeat
    task.wait()
until Invoke('Comets: Get Data')
local function u55(p31)
    -- block 23
    local v32 = 'Axe_Hop.txt'
    local v33 = not isfile(v32) and {} or game.HttpService:JSONDecode(readfile(v32))
    task.wait(Settings.Comets['Server Hop Wait'])
    if p31 ~= nil and string.len(p31) > 10 then
        u28(PLACE_ID, p31)
    end
    local pLACEID = PLACE_ID
    local u34 = 'https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100'
    local function v36()
        local v35 = string.format(u34, pLACEID)
        return game.HttpService:JSONDecode(game:HttpGet(v35)).data
    end
    local pLACEID2 = pLACEID
    local function v38(p37)
        return type(p37.playing) == 'number' and (type(p37.maxPlayers) == 'number' and p37.playing < p37.maxPlayers)
    end
    local function v45(p39, p40)
        local v41, v42, v43 = ipairs(p40)
        while true do
            local v44
            v43, v44 = v41(v42, v43)
            if v43 == nil then
                break
            end
            if p39.id == v44.id then
                return true
            end
        end
        return false
    end
    goto l20
    ::l16::
    table.sort(v53, function(p46, p47)
        return p46.playing < p47.playing
    end)
    if #v53 > 0 then
        local v48 = v53[1]
        v33[#v33 + 1] = v48
        writefile(v32, game.HttpService:JSONEncode(v33))
        u28(pLACEID2, v48.id)
    end
    wait(1)
    ::l20::
    local v49 = v36()
    local v50, v51, v52 = ipairs(v49)
    local v53 = {}
    ::l9::
    local v54
    v52, v54 = v50(v51, v52)
    if v52 == nil then
        goto l16
    end
    if v38(v54) and not v45(v54, v33) then
        table.insert(v53, v54)
    end
    goto l9
end
local function u59(p56)
    local v57, v58 = next(p56, nil)
    if v57 == nil then
        return false
    end
    if v57 ~= nil and v58 ~= nil then
        return true
    end
end
local function u61(p60)
    if p60 >= 1000000000000 then
        return string.format('%.2fT', p60 / 1000000000000)
    elseif p60 >= 1000000000 then
        return string.format('%.2fB', p60 / 1000000000)
    elseif p60 >= 1000000 then
        return string.format('%.2fM', p60 / 1000000)
    elseif p60 >= 1000 then
        return string.format('%.2fK', p60 / 1000)
    else
        return tostring(p60)
    end
end
local function u62()
    Fire('Activate Boost', 'Triple Damage')
end
local function u63()
    Fire('Activate Boost', 'Triple Coins')
end
local function u84(p64)
    local v65 = string.format('`%s` Mini / `%s` Massive Comets was Found', p64.Comets['Mini Comet'], p64.Comets['Massive Comet'])
    local v66 = (discord['Set Username Private'] or not tonumber(discord['Discord ID'])) and '' or string.format('<@!%s>', discord['Discord ID'])
    local accounts = u23(readfile('Axe_Farmer.json')).accounts
    local v67, v68, v69 = pairs(accounts)
    local v70 = 0
    while true do
        local v71
        v69, v71 = v67(v68, v69)
        if v69 == nil then
            break
        end
        v70 = v70 + 1
    end
    local v72 = string.format('>>> **Earned** \226\128\162 `%s` <:Diamonds:1092979426561642556>', u61(p64.Diamonds))
    local v73, v74, v75 = pairs(p64.Boosts)
    local v76 = '>>> '
    while true do
        local v77
        v75, v77 = v73(v74, v75)
        if v75 == nil then
            break
        end
        v76 = v76 .. string.format('**%s** \226\128\162 `%s` %s', v75, v77, p64.Emojis[v75]) .. '\n'
    end
    local v78 = string.format('>>> *Took* `%s` *seconds to break comets*\n*Accounts* `%s`', os.time() - p64.Time, v70)
    local v79 = u23(readfile('Axe_Farmer.json')).accounts[localPlayer.Name]
    local v80 = u61(v79.Diamonds)
    local miniComets = v79['Mini Comets']
    local massiveComets = v79['Massive Comets']
    local v81 = string.format('>>> **Earned:** `%s` <:Diamonds:1092979426561642556>\n**Mini Comets:** `%s`\n**Massive Comets:** `%s`', v80, miniComets, massiveComets)
    local v82 = {
        content = v66,
        embeds = {
            {
                author = {
                    name = 'Axe Farmer',
                    icon_url = 'https://i.imgur.com/umWAUYV.png'
                },
                title = v65,
                description = '',
                timestamp = os.date('%Y-%m-%dT%H:%M:%S.000Z', os.time()),
                type = 'rich',
                color = 10903264,
                thumbnail = {
                    url = p64['Massive Egg']
                },
                fields = {
                    {
                        name = '<:Diamonds:1092979426561642556> `Diamonds`',
                        value = v72,
                        inline = true
                    },
                    {
                        name = '<:Bundle:1092985443689185330> `Boosts`',
                        value = v76,
                        inline = false
                    },
                    {
                        name = '<:Stars:1093749435462320209> `Current Statistics`',
                        value = v78,
                        inline = true
                    },
                    {
                        name = '<:Comet:1094009796111388772> `Lifetime Statistics`',
                        value = v81,
                        inline = false
                    }
                }
            }
        }
    }
    local v83 = game:GetService('HttpService'):JSONEncode(v82);
    (http_request or request or (HttpPost or syn.request))({
        Url = Settings.Comets['Webhook URL'],
        Body = v83,
        Method = 'POST',
        Headers = {
            ['content-type'] = 'application/json'
        }
    })
end
local function u93(_, p85, p86, p87)
    local v88 = string.format('Statistics per %s', Settings.Statistics['Waiting Time'])
    local v89 = string.format('>>> **Earned** \226\128\162 `%s` <:Diamonds:1092979426561642556>', u61(p85))
    local v90 = string.format('>>> **Mini Comets: **`%s`\n**Massive Comets: **`%s`', p86, p87)
    local v91 = {
        content = content,
        embeds = {
            {
                author = {
                    name = 'Axe Farmer',
                    icon_url = 'https://i.imgur.com/umWAUYV.png'
                },
                title = v88,
                description = '',
                timestamp = os.date('%Y-%m-%dT%H:%M:%S.000Z', os.time()),
                type = 'rich',
                color = 10903264,
                fields = {
                    {
                        name = '<:Diamonds:1092979426561642556> `Diamonds`',
                        value = v89,
                        inline = true
                    },
                    {
                        name = '<:Stars:1093749435462320209> `Comets`',
                        value = v90,
                        inline = false
                    }
                }
            }
        }
    }
    local v92 = game:GetService('HttpService'):JSONEncode(v91);
    (http_request or request or (HttpPost or syn.request))({
        Url = Settings.Statistics['Webhook URL'],
        Body = v92,
        Method = 'POST',
        Headers = {
            ['content-type'] = 'application/json'
        }
    })
end
local function v96()
    local v94 = {
        ['Comet Found'] = {
            ['Server ID'] = ''
        },
        Diamonds = 0,
        ['Mini Comets'] = 0,
        ['Massive Comets'] = 0
    }
    local v95 = {
        Data = {
            Diamonds = 0,
            ['Mini Comets'] = 0,
            ['Massive Comets'] = 0
        },
        ['Start Time'] = os.time(),
        ['End Time'] = os.time() + u30
    }
    v94.Stats = v95
    return v94
end
if isfile('Axe_Farmer.json') then
    local v97 = u23(readfile('Axe_Farmer.json'))
    local u98 = false
    pcall(function()
        u98 = true
    end)
    if not u98 then
        v97.accounts[localPlayer.Name] = v96()
        writefile('Axe_Farmer.json', u21(v97))
    end
else
    local v99 = {
        accounts = {
            [localPlayer.Name] = v96()
        }
    }
    writefile('Axe_Farmer.json', u21(v99))
end
local function u105()
    local accounts = u23(readfile('Axe_Farmer.json')).accounts
    local v100, v101, v102 = pairs(accounts)
    local v103, v104 = v100(v101, v102)
    return v103 == nil and 'None' or (v104['Comet Found']['Server ID'] == '' and 'None' or v104['Comet Found']['Server ID'])
end
local function v108(p106)
    local v107 = u23(readfile('Axe_Farmer.json'))
    v107.accounts[localPlayer.Name]['Comet Found']['Server ID'] = u105(v107, p106)
    writefile('Axe_Farmer.json', u21(v107))
end
local function u112(p109, p110)
    local miniComet = p110['Mini Comet']
    local massiveComet = p110['Massive Comet']
    local v111 = u23(readfile('Axe_Farmer.json'))
    v111.accounts[localPlayer.Name].Diamonds = (v111.accounts[localPlayer.Name].Diamonds or 0) + p109
    v111.accounts[localPlayer.Name]['Mini Comets'] = (v111.accounts[localPlayer.Name]['Mini Comets'] or 0) + miniComet
    v111.accounts[localPlayer.Name]['Massive Comets'] = (v111.accounts[localPlayer.Name]['Massive Comets'] or 0) + massiveComet
    v111.accounts[localPlayer.Name].Stats.Data.Diamonds = (v111.accounts[localPlayer.Name].Stats.Data.Diamonds or 0) + p109
    v111.accounts[localPlayer.Name].Stats.Data['Mini Comets'] = (v111.accounts[localPlayer.Name].Stats.Data['Mini Comets'] or 0) + miniComet
    v111.accounts[localPlayer.Name].Stats.Data['Massive Comets'] = (v111.accounts[localPlayer.Name].Stats.Data['Massive Comets'] or 0) + massiveComet
    if os.time() > v111.accounts[localPlayer.Name].Stats['End Time'] then
        u93(v111.accounts[localPlayer.Name].Stats['End Time'] - v111.accounts[localPlayer.Name].Stats['Start Time'], v111.accounts[localPlayer.Name].Stats.Data.Diamonds, v111.accounts[localPlayer.Name].Stats.Data['Mini Comets'], v111.accounts[localPlayer.Name].Stats.Data['Massive Comets'])
        v111.accounts[localPlayer.Name].Stats = {
            ['Start Time'] = os.time(),
            ['End Time'] = os.time() + u30,
            Data = {
                Diamonds = 0,
                ['Mini Comets'] = 0,
                ['Massive Comets'] = 0
            }
        }
    end
    writefile('Axe_Farmer.json', u21(v111))
end
u112(0, {
    ['Mini Comet'] = 0,
    ['Massive Comet'] = 0
})
task.spawn(function()
    while task.wait(0.1) do
        if Settings.Boosts['Enable Triple Damage'] and not game:GetService('Players').LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild('Triple Damage') then
            u62()
        elseif Settings.Boosts['Enable Triple Coins'] and not game:GetService('Players').LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild('Triple Coins') then
            u63()
        end
    end
end)
if not u59(Invoke('Comets: Get Data')) then
    if u105() == 'None' or not Settings['Alt Joiner'] then
        u55('None')
    else
        u55(u105())
    end
end
v108(game.JobId)
local u113 = require(game:GetService('ReplicatedStorage'):WaitForChild('Library'))
local function u121(p114, p115)
    if not game:GetService('Workspace').__MAP.Teleports:FindFirstChild(p114) then
        local v116 = set_thread_identity or (syn and syn.set_thread_identity or fluxus and fluxus.set_thread_identity or (setthreadidentity or setidentity))
        v116(2)
        u113.WorldCmds.Load(p114)
        v116(7)
    end
    repeat
        task.wait()
    until game:GetService('Workspace')
    local v117, v118, v119 = pairs(game:GetService('Workspace').__MAP.Teleports:GetChildren())
    while true do
        local v120
        v119, v120 = v117(v118, v119)
        if v119 == nil then
            break
        end
        if v120.Name:match(p115) then
            localPlayer.Character.HumanoidRootPart.CFrame = v120.CFrame
        end
    end
end
local function u126()
    local tHINGS = game:GetService('Workspace').__THINGS
    local v122, v123, v124 = pairs(tHINGS.Lootbags:GetChildren())
    while true do
        local v125
        v124, v125 = v122(v123, v124)
        if v124 == nil then
            break
        end
        task.wait(0.15)
        v125.CFrame = localPlayer.Character.HumanoidRootPart.CFrame
    end
end
local function u132()
    local v127, v128, v129 = pairs(u113.Save.Get().PetsEquipped)
    local v130 = {}
    while true do
        local v131
        v129, v131 = v127(v128, v129)
        if v129 == nil then
            break
        end
        table.insert(v130, v129)
    end
    return v130
end
local function u138(p133)
    u132()
    local v134, v135, v136 = pairs(u113.Save.Get().PetsEquipped)
    while true do
        local v137
        v136, v137 = v134(v135, v136)
        if v136 == nil then
            break
        end
        Invoke('Join Coin', p133, { v136 })
        Fire('Farm Coin', p133, v136)
    end
end
task.spawn(function()
    comet_data = {
        Diamonds = 0,
        Boosts = {
            ['Triple Damage'] = 0,
            ['Triple Coins'] = 0,
            ['Ultra Lucky'] = 0,
            ['Super Lucky'] = 0
        },
        Emojis = {
            ['Triple Damage'] = '<:TripleBoost:1092979111019946037>',
            ['Triple Coins'] = '<:TripleCoins:1093773082361073714>',
            ['Ultra Lucky'] = '<:UltraLucky:1093773271608066078>',
            ['Super Lucky'] = '<:SuperLucky:1093773167840985109>'
        },
        Time = os.time(),
        Comets = {
            ['Mini Comet'] = 0,
            ['Massive Comet'] = 0
        },
        ['Massive Egg'] = ''
    }
    while true do
        if not u59(Invoke('Comets: Get Data')) then
            u112(comet_data.Diamonds, comet_data.Comets)
            if Settings.Comets['Send Notification'] then
                u84(comet_data)
            end
            u55()
            return
        end
        task.wait()
        Comets_Data = Invoke('Comets: Get Data')
        local v139, v140, v141 = pairs(Comets_Data)
        while true do
            local v142
            v141, v142 = v139(v140, v141)
            if v141 == nil or not u59(Invoke('Comets: Get Data')) then
                break
            end
            comet_data.Comets[v142.Type] = comet_data.Comets[v142.Type] + 1
            u121(v142.WorldId, v142.AreaId)
            local diamonds = u113.Save.Get().Diamonds
            local boostsInventory = u113.Save.Get().BoostsInventory
            local v143, _ = next(Comets_Data, nil)
            local v144 = false
            repeat
                v144 = v142.Type:match('Massive') and true or v144
                task.wait()
                u138(v142.CoinId)
                Comets_Data = Invoke('Comets: Get Data')
            until type(Comets_Data[v143]) ~= 'table' or v142.Type:match('Massive') and FindFirstChild(game:GetService('Workspace').__THINGS.Comets, 'Massive Comet Broken')
            pet_icon = ''
            if v144 then
                task.wait(5)
                Fire('Open Egg', 'Comet Egg')
                task.spawn(function()
                    while task.wait(1) do
                        game:GetService('Players').LocalPlayer.PlayerGui.Inventory.Enabled = true
                        game:GetService('Players').LocalPlayer.PlayerGui.Inventory.Enabled = false
                    end
                end)
                local normal = game:GetService('Players').LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal
                pet_sent = false
                pet_id = ''
                normal.ChildAdded:Connect(function(p145)
                    pet_id = p145
                    pet_sent = false
                end)
                while task.wait() do
                    if pet_id ~= '' and not pet_sent then
                        pet_sent = true
                        break
                    end
                end
                pet_icon = game:GetService('Players').LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.Normal[pet_id].PetIcon.Image
                pet_icon = game:HttpGet(string.format('https://thumbnails.roblox.com/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=150x150&format=Png&isCircular=true', pet_icon))
                pet_icon = u23(pet_icon).data.imageUrl
                comet_data['Massive Egg'] = pet_icon
            end
            task.wait(1.5)
            for _ = 1, 3 do
                task.wait(1)
                u126()
            end
            comet_data.Diamonds = comet_data.Diamonds + (u113.Save.Get().Diamonds - diamonds)
            local v146, v147, v148 = pairs(u113.Save.Get().BoostsInventory)
            while true do
                local v149, v150 = v146(v147, v148)
                if v149 == nil then
                    break
                end
                local v151, v152, v153 = pairs(boostsInventory)
                v148 = v149
                while true do
                    local v154
                    v153, v154 = v151(v152, v153)
                    if v153 == nil then
                        break
                    end
                    if v149 == v153 then
                        comet_data.Boosts[v149] = comet_data.Boosts[v149] + (v150 - v154)
                        break
                    end
                end
            end
        end
    end
end)