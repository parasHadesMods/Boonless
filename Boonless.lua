ModUtil.RegisterMod("Boonless")

-- In normal configuration, Devotion (trial of the gods)
-- rewards will never appear, because they require 2
-- interacted gods (and you will have zero).
local config = {
  ModName = "Boonless",
  ReplaceRoomBoonsWithOnions = true,
  ReplaceChaosWithOnions = true,
  ReplaceStoreBoonsWithOnions = true
}

if ModConfigMenu then
  ModConfigMenu.Register(config)
end

Boonless.ReplaceRoomItemNames = {
  "Boon",
  "HermesUpgrade"
}

ModUtil.WrapBaseFunction("ChooseRoomReward", function(baseFunc, ...)
  local normalReward = baseFunc(...)
  if config.ReplaceRoomBoonsWithOnions and Contains( Boonless.ReplaceRoomItemNames, normalReward ) then
    return "RoomRewardConsolationPrize"
  elseif config.ReplaceChaosWithOnions and normalReward == "TrialUpgrade" then
    return "RoomRewardConsolationPrize"
  else
    return normalReward
  end
end)

Boonless.ReplaceStoreItemNames = {
  "BlindBoxLoot",
  "HermesUpgradeDrop",
  "RandomLoot"
}

ModUtil.WrapBaseFunction("FillInShopOptions", function(baseFunc, ...)
  local store = baseFunc(...)
  for _,item in pairs(store.StoreOptions) do
    if config.ReplaceStoreBoonsWithOnions and Contains( Boonless.ReplaceStoreItemNames, item.Name ) then
      item.Name = "StoreRewardConsolationDrop"
      item.Type = "Consumable"
    end
  end
  return store
end)
