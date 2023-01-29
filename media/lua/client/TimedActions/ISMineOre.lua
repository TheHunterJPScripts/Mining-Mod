ISMineOre = ISBaseTimedAction:derive("ISMineIron");

local function predicateNotBroken(item)
    return not item:isBroken()
end

function ISMineOre:isValid()
    return true;
end

function ISMineOre:waitToStart()
    self.character:faceThisObjectAlt(self.item)
    return self.character:shouldBeTurning()
end

function ISMineOre:start()
    self:setActionAnim("Mining")
    self.character:faceThisObject(self.thumpable)
    self.sound = self.character:playSound("Mining_Pickaxe");
end

function ISMineOre:update()
    self.character:faceThisObjectAlt(self.item)
end

function ISMineOre:stop()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end
    ISBaseTimedAction.stop(self);
end

function ISMineOre:perform()
    if self.sound then
        self.character:getEmitter():stopSound(self.sound)
        self.sound = nil
    end

    ISBaseTimedAction.perform(self);

    self.character:LoseLevel(Perks.MineEndurance);
    self.character:LoseLevel(Perks.MineEndurance);
    self.character:getXp():AddXP(Perks.MineEndurance, -120);
    self.character:getXp():AddXP(Perks.MetalWelding, 5);
    self.character:getStats():setEndurance(self.character:getStats():getEndurance() - 0.15);

    local oreType = self.oreData.mineType;

    for _, v in pairs(getModInstance().resources[oreType].lootTables) do
        self:processLoot(v)
    end
end

function ISMineOre:new(character, item, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;

    return o;
end

function ISMineOre:processLoot(loot)

    if loot.fixed then
        self:addItems(loot.item, loot.fixedAmount)
        return
    end

    local metalistLevel = self.character:getPerkLevel(Perks.MetalWelding)
    print("Level: " .. metalistLevel)

    if loot.requireLevel then
        for _, v in pairs(loot.amountPerLevel) do
            for _, level in pairs(v.levels) do
                if metalistLevel == level then
                    local extra = ZombRand(v.amounts.max - v.amounts.min + 1)
                    local finalAmount = v.amounts.min + extra

                    if finalAmount > 0 then
                        self:addItems(loot.item, finalAmount)
                    end
                    return
                end
            end
        end
    end
end

function ISMineOre:addItems(item, amount)
    local additional = 0;
    local isMiner = false; --self.character:HasTrait('miner');
    local isntMiner = false; --self.character:HasTrait('notminer');
    if isMiner then additional = 1 end
    if isntMiner then additional = -1 end

    self.character:getInventory():AddItems(item, amount + additional);
end
