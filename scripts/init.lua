ENABLE_DEBUG_LOG = false
-- Items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/locationobjects.json")

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
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end