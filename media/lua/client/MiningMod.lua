MiningMod = {}

MiningMod.NAME = 'Minning & Rummaging'
MiningMod.AUTHOR = 'TheHunterJP'
MiningMod.VERSION = '1.0.0'

MiningMod.resources = {}

function getMiningModInstance()
    return MiningMod
end

MiningMod.init = function()
    print('Mod Loaded: ' ..
    MiningMod.NAME ..
    ' by ' .. MiningMod.AUTHOR .. ' (v' .. MiningMod.VERSION .. ')')
end

MiningMod.AddLevel = function()
    local player = getPlayer();
    if player:getPerkLevel(Perks.MineEndurance) < 10 then
        player:getXp():AddXP(Perks.MineEndurance, 10);
    end
end

Events.EveryTenMinutes.Add(MiningMod.AddLevel);
Events.OnGameStart.Add(MiningMod.init)

local function addLevel(keypressed)
    local key = keypressed
    local playerObj = getPlayer()

    if key == Keyboard.KEY_K then
        print("Add Level")
        playerObj:getXp():AddXP(Perks.MineEndurance, 60);
    end
end

Events.OnKeyPressed.Add(addLevel)
