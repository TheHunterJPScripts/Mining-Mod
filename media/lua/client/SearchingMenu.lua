SearchingMenu = {}

local function predicateNotBroken(item)
  return not item:isBroken()
end

local function isIsoOre(isoObject)
  return true

  -- if not instanceof(isoObject, "IsoOre") then return false end

  -- return true
end

SearchingMenu.OnFillWorldObjectContextMenu = function(player, context, worldobjects, test)
  if getCore():getGameMode() == 'LastStand' then
    return
  end

  if test and ISWorldObjectContextMenu.Test then
    return true
  end

  local playerObj = getSpecificPlayer(player)
  if playerObj:getVehicle() then
    return
  end

  local ore = nil
  for _, v in pairs(worldobjects) do
    if isIsoOre(v) then
      ore = v
      break
    end
  end

  if not ore then return end

  SearchingMenu.TableMenuBuilder(context, worldobjects, player, ore)
end



-- CraftingEnhancedCore.canBuildObject = function(_tooltip, player, table)

--   local inv = getPlayer(player):getInventory()

--   if not inv:getFirstTypeEval(table.requireTool, predicateNotBroken) then
--     _tooltip.description = _tooltip.description .. ' <RGB:1,0,0>' ..
--         getText("ContextMenu_RequireTool") .. " " .. getItemNameFromFullType("Base." .. table.requireTool) .. ' <LINE>'
--   end

--   for _, material in pairs(table.recipe) do
--     local invItemCount = inv:getItemCountFromTypeRecurse(material.type)

--     if invItemCount >= material.amount or ISBuildMenu.cheat then
--       _tooltip.description = _tooltip.description ..
--           ' <RGB:1,1,1>' ..
--           getItemNameFromFullType(material.type) .. ' ' .. material.amount .. '/' .. material.amount .. ' <LINE>'
--     else
--       _tooltip.description = _tooltip.description ..
--           ' <RGB:1,0,0>' ..
--           getItemNameFromFullType(material.type) .. ' ' .. invItemCount .. '/' .. material.amount .. ' <LINE>'
--     end
--   end
-- end

SearchingMenu.getOreData = function(ore)
  return {
    menuName = getText("ContextMenu_Search"),
    menuTexture = "ore_textures_0",
    tooltipDescription = "",
    item = "",
  }
end

SearchingMenu.hasPickaxe = function(player)
  return true
end

SearchingMenu.TableMenuBuilder = function(context, worldobjects, player, ore)
  local oreData = SearchingMenu.getOreData(ore)
  local menuOption = context:addOption(oreData.menuName, worldobjects,
    SearchingMenu.Mine, player, oreData)
  local toolTip = ISToolTip:new()

  toolTip:initialise();
  toolTip:setVisible(false);
  toolTip:setName(oreData.menuName);
  toolTip:setTexture(oreData.menuTexture);
  toolTip.description = oreData.tooltipDescription

  if SearchingMenu.hasPickaxe(player) then
    toolTip.description = toolTip.description ..
        '<LINE> <RGB:1,0,0>' ..
        getText("Tooltip_Require_Pickaxe") .. ' <LINE>'
  end

  menuOption.toolTip = toolTip
end


SearchingMenu.Mine = function(player, oreData)
  if not SearchingMenu.hasPickaxe(player) then return end

  local playerObj = getPlayer(player)

  ISTimedActionQueue.add(ISSearch:new(playerObj, oreData.item, 500));
  --getPlayer():getBodyDamage():setUnhappynessLevel(player:getBodyDamage():getUnhappynessLevel() + 0.5);
  --getPlayer():getStats():setHunger(player:getStats():getHunger() + 0.005);
  --getPlayer():getStats():setThirst(player:getStats():getThirst() + 0.005);
  --	getPlayer():getStats():setFatigue(player:getStats():getFatigue() + 0.01);
  --getSoundManager():PlayWorldSound("TrashSearch", false, getPlayer():getCurrentSquare(), 0.2, 60, 0.2, false);

  -- getPlayer():getStats():setEndurance(playerObj:getStats():getEndurance() - 0.15);
  -- playerObj:LoseLevel(Perks.MineEndurance);
  -- playerObj:LoseLevel(Perks.MineEndurance);
  -- playerObj:LoseLevel(Perks.MineEndurance);
  -- if playerObj:HasTrait("FastLearner") then
  --   playerObj:getXp():AddXP(Perks.MineEndurance, (-180 / 1.3));
  -- elseif playerObj:HasTrait("SlowLearner") then
  --   playerObj:getXp():AddXP(Perks.MineEndurance, (-180 / 0.7));
  -- else
  --   playerObj:getXp():AddXP(Perks.MineEndurance, -180);
  -- end
end

Events.OnFillWorldObjectContextMenu.Add(SearchingMenu.OnFillWorldObjectContextMenu)
