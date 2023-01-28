ISMineOre = ISBaseTimedAction:derive("ISMineIron");

function ISMineOre:isValid()
    return true;
end

function ISMineOre:update()
end

function ISMineOre:start()
    self:setActionAnim("Mining")
    self.sound = self.character:playSound("TrashSearch");
    local radius = 20
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), radius, radius)
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
    -- local mineiron = ZombRand(5)
    -- self.character:getXp():AddXP(Perks.MetalWelding, 10);
    -- if mineiron == 4 or (mineiron == 2 and self.character:HasTrait('miner')) or
    --     (mineiron == 1 and self.character:HasTrait('miner')) then
    --     self.character:getInventory():AddItems("NHM.IronOre", 2);
    -- else
    --     self.character:getInventory():AddItem("NHM.IronOre");
    -- end
    self.character:getInventory():AddItems("Base.Stone", 1);
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
