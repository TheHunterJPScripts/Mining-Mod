MiningRummaging = {}

MiningRummaging.NAME = 'Minning & Rummaging'
MiningRummaging.AUTHOR = 'TheHunterJP'
MiningRummaging.VERSION = '1.0.0'

MiningRummaging.init = function()
    print('Mod Loaded: ' ..
        MiningRummaging.NAME ..
        ' by ' .. MiningRummaging.AUTHOR .. ' (v' .. MiningRummaging.VERSION .. ')')
end

function getModInstance()
    return MiningRummaging
end

Events.OnGameStart.Add(MiningRummaging.init)
