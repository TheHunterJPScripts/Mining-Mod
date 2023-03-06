if not getMiningModInstance then
    require('MiningMod')
end

MiningMod = getMiningModInstance()

MiningMod.resources["Stone Mine"] = {
    mineType = "Stone Mine",
    menuName = getText("ContextMenu_Stone_Mine"),
    menuAction = getText("ContextMenu_Mine_Stone"),
    textures = { "mines_5", "mines_4" },
    lootTables = {
        {
            item = "Base.Stone",
            requireLevel = false,
            fixed = true,
            fixedAmount = 1,
        },
        {
            item = "Mining.MM_Limestone",
            requireLevel = true,
            fixed = false,
            amountPerLevel = {
                {
                    levels = { 0, 1 },
                    amounts = {
                        min = 0,
                        max = 1
                    }
                },
                {
                    levels = { 2, 3 },
                    amounts = {
                        min = 1,
                        max = 3
                    }
                },
                {
                    levels = { 4, 5 },
                    amounts = {
                        min = 2,
                        max = 4
                    }
                },
                {
                    levels = { 6, 7, 8, 9, 10 },
                    amounts = {
                        min = 3,
                        max = 6
                    }
                }
            }
        },
    }
}
