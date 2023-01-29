MiningRummaging = {}

MiningRummaging.NAME = 'Minning & Rummaging'
MiningRummaging.AUTHOR = 'TheHunterJP'
MiningRummaging.VERSION = '1.0.0'

MiningRummaging.resources = {}

function getModInstance()
    return MiningRummaging
end

MiningRummaging.init = function()
    print('Mod Loaded: ' ..
        MiningRummaging.NAME ..
        ' by ' .. MiningRummaging.AUTHOR .. ' (v' .. MiningRummaging.VERSION .. ')')
end

MiningRummaging.AddLevel = function()
    local player = getPlayer();
    if player:getPerkLevel(Perks.MineEndurance) < 10 then
        player:getXp():AddXP(Perks.MineEndurance, 10);
    end
end

Events.EveryTenMinutes.Add(MiningRummaging.AddLevel);
Events.OnGameStart.Add(MiningRummaging.init)

local function addLevel(keypressed)
    local key = keypressed
    local playerObj = getPlayer()

    if key == Keyboard.KEY_K then
        print("Add Level")
        playerObj:getXp():AddXP(Perks.MineEndurance, 60);
    end
end

Events.OnKeyPressed.Add(addLevel)
