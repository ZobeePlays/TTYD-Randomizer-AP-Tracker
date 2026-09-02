ENABLE_DEBUG_LOG = false
-- Items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/badges.json")
Tracker:AddItems("items/locationobjects.json")
Tracker:AddItems("items/settings.json")
ScriptHost:LoadScript("scripts/items/enemy_items.lua")

-- Logic
ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")

-- Maps
Tracker:AddMaps("maps/maps.json")

-- Layout
ScriptHost:LoadScript("scripts/layouts_import.lua")

-- Locations
ScriptHost:LoadScript("scripts/locations_import.lua")

-- AutoTracking for Poptracker
ScriptHost:LoadScript("scripts/autotracking.lua")