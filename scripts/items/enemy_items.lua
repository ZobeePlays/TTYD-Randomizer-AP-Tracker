ScriptHost:LoadScript("scripts/items/enemy_data.lua")

local function CanProvideCodeFunc(self, code)
    return code == self.ItemState.Code
end

local function EnemySaveFunc(self)
    if self.ItemState.Code == "Goomba" then
        return {
            CODE = self.ItemState.Code,
            ENEMYLOCATIONS = self.ItemState.EnemyLocations,
            ENEMYDICT = ENEMY_DICT
        }
    else
        return {
            CODE = self.ItemState.Code,
            ENEMYLOCATIONS = self.ItemState.EnemyLocations
        }
    end
end

local function EnemyLoadFunc(self, data)
    if self.ItemState.Code == data.CODE then
        if data.CODE == "Goomba" then
            ENEMY_DICT = data.ENEMYDICT
            self.ItemState.EnemyLocations = data.ENEMYLOCATIONS
        else
            self.ItemState.EnemyLocations = data.ENEMYLOCATIONS
        end
    end
end

function ClearText(self)
    for i=0,13 do
        local code = "text_item_" .. tostring(i)
        local text_item = Tracker:FindObjectForCode(code)
        text_item.BadgeText = ""
    end
    for i=1,2 do
        local code = "button_item_" .. tostring(i)
        local button_item = Tracker:FindObjectForCode(code)
        button_item.BadgeText = ""
        local enemy = button_item.ItemState.Enemy
        button_item.ItemState.Enemy = nil
    end
end

local function NextPage(self)
    local enemy = self.ItemState.Enemy
    local page = self.ItemState.Page
    if #(enemy.ItemState.EnemyLocations) > 13 * page then
        ClearText(nil)
        for i = 1, 2 do
            local code = "button_item_" .. tostring(i)
            local button_item = Tracker:FindObjectForCode(code)
            button_item.ItemState.Enemy = enemy
            button_item.ItemState.Page = page + 1
            if i == 2 then
                if #(enemy.ItemState.EnemyLocations) > 13 * (page + 1) then
                    button_item.BadgeText = "next..."
                end
            else
                button_item.BadgeText = "prev..."
            end
        end
        for i = 0, 13 do
            local code = "text_item_" .. tostring(i)
            local text_item = Tracker:FindObjectForCode(code)
            if i > 0 then
                if i + 13 * page <= #(enemy.ItemState.EnemyLocations) then
                    local location_code = enemy.ItemState.EnemyLocations[i + 13 * page]
                    local location_name = location_code
                    
                    location_code = location_code .. " Dummy"

                    local location_obj = Tracker:FindObjectForCode(location_code)
                    if location_obj then
                        if location_obj.AccessibilityLevel == AccessibilityLevel.None then
                            text_item.BadgeTextColor = "#FF0000"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.SequenceBreak then
                            text_item.BadgeTextColor = "#FFFF00"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.Inspect then
                            text_item.BadgeTextColor = "#0000FF"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.Normal then
                            text_item.BadgeTextColor = "#00FF00"
                        else
                            text_item.BadgeTextColor = "#FFFFFF"
                            print(location_code .. " has an unexpected accessibility level: " .. tostring(location_obj.AccessibilityLevel) .. ".")
                        end
                    else
                        text_item.BadgeTextColor = "#FFFFFF"
                        print(location_code .. " was not found, defaulting to white text.")
                    end

                    for str in string.gmatch(location_name, "([^/]+)") do
                        location_name = str
                    end
                    for str in string.gmatch(location_name, "([^-]+)") do
                        location_name = str
                        break
                    end
                    text_item.BadgeText = location_name
                end
            else
                text_item.BadgeText = enemy.Name .. " is near:"
            end
        end
    end
end

local function PrevPage(self)
    local enemy = self.ItemState.Enemy
    local page = self.ItemState.Page
    if page > 1 then
        ClearText(nil)
        for i = 1, 2 do
            local code = "button_item_" .. tostring(i)
            local button_item = Tracker:FindObjectForCode(code)
            button_item.ItemState.Enemy = enemy
            button_item.ItemState.Page = page - 1
            if i == 2 then
                button_item.BadgeText = "next..."
            else
                if page > 2 then
                    button_item.BadgeText = "prev..."
                end
            end
        end
        for i = 0, 13 do
            local code = "text_item_" .. tostring(i)
            local text_item = Tracker:FindObjectForCode(code)
            if i > 0 then
                if i + 13 * (page - 2) <= #(enemy.ItemState.EnemyLocations) then
                    local location_code = enemy.ItemState.EnemyLocations[i + 13 * (page - 2)]
                    local location_name = location_code

                    location_code = location_code .. " Dummy"

                    local location_obj = Tracker:FindObjectForCode(location_code)
                    if location_obj then
                        if location_obj.AccessibilityLevel == AccessibilityLevel.None then
                            text_item.BadgeTextColor = "#FF0000"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.SequenceBreak then
                            text_item.BadgeTextColor = "#FFFF00"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.Inspect then
                            text_item.BadgeTextColor = "#0000FF"
                        elseif location_obj.AccessibilityLevel == AccessibilityLevel.Normal then
                            text_item.BadgeTextColor = "#00FF00"
                        else
                            text_item.BadgeTextColor = "#FFFFFF"
                            print(location_code .. " has an unexpected accessibility level: " .. tostring(location_obj.AccessibilityLevel) .. ".")
                        end
                    else
                        text_item.BadgeTextColor = "#FFFFFF"
                        print(location_code .. " was not found, defaulting to white text.")
                    end

                    for str in string.gmatch(location_name, "([^/]+)") do
                        location_name = str
                    end
                    for str in string.gmatch(location_name, "([^-]+)") do
                        location_name = str
                        break
                    end
                    text_item.BadgeText = location_name
                end
            else
                text_item.BadgeText = enemy.Name .. " is near:"
            end
        end
    end
end

local function CompareAccessibility(a, b)
    local a_obj = Tracker:FindObjectForCode(a)
    local b_obj = Tracker:FindObjectForCode(b)
    if a_obj == nil then
        return false
    elseif b_obj == nil then
        return true
    else
        return a_obj.AccessibilityLevel > b_obj.AccessibilityLevel
    end
end

local function StableSort(location_table, cmp_func)
    local len = #(location_table)
    local temp
    for i=1,(len-1) do
        for j=i,1,-1 do
            if cmp_func(location_table[j+1],location_table[j]) then
                temp = location_table[j+1]
                location_table[j+1] = location_table[j]
                location_table[j] = temp
            end
        end
    end
end

local function SetText(self)
    ClearText(nil)
    for i=1,2 do
        local code = "button_item_" .. tostring(i)
        local button_item = Tracker:FindObjectForCode(code)
        button_item.ItemState.Enemy = self
        button_item.ItemState.Page = 1
        if i == 2 then
            if #(self.ItemState.EnemyLocations) > 13 then
                button_item.BadgeText = "next..."
            end
        end
    end
    table.sort(self.ItemState.EnemyLocations)
    StableSort(self.ItemState.EnemyLocations,CompareAccessibility)
    for i=0,13 do
        local code = "text_item_" .. tostring(i)
        local text_item = Tracker:FindObjectForCode(code)
        if i > 0 then
            if i <= #(self.ItemState.EnemyLocations) then
                local location_code = self.ItemState.EnemyLocations[i]
                local location_name = location_code

                location_code = location_code .. " Dummy"

                local location_obj = Tracker:FindObjectForCode(location_code)
                if location_obj then
                    if location_obj.AccessibilityLevel == AccessibilityLevel.None then
                        text_item.BadgeTextColor = "#FF0000"
                    elseif location_obj.AccessibilityLevel == AccessibilityLevel.SequenceBreak then
                        text_item.BadgeTextColor = "#FFFF00"
                    elseif location_obj.AccessibilityLevel == AccessibilityLevel.Inspect then
                        text_item.BadgeTextColor = "#0000FF"
                    elseif location_obj.AccessibilityLevel == AccessibilityLevel.Normal then
                        text_item.BadgeTextColor = "#00FF00"
                    else
                        text_item.BadgeTextColor = "#FFFFFF"
                            print(location_code .. " has an unexpected accessibility level: " .. tostring(location_obj.AccessibilityLevel) .. ".")
                    end
                else
                    text_item.BadgeTextColor = "#FFFFFF"
                    print(location_code .. " was not found, defaulting to white text.")
                end

                for str in string.gmatch(location_name, "([^/]+)") do
                    location_name = str
                end
                for str in string.gmatch(location_name, "([^-]+)") do
                    location_name = str
                    break
                end
                text_item.BadgeText = location_name
            end
        else
            text_item.BadgeText = self.Name .. " is near:"
        end
    end
end

local function CreateLuaEnemyItems(enemy_dict)
    for _, enemy in pairs(enemy_dict) do
        local enemy_item =  ScriptHost:CreateLuaItem()
        enemy_item.Name = enemy["name"]
        enemy_item.Icon = ImageReference:FromPackRelativePath(enemy["img"])
        enemy_item.ItemState = {
            Code = enemy["code"],
            EnemyLocations = {}
        }
        enemy_item.CanProvideCodeFunc = CanProvideCodeFunc
        enemy_item.ProvidesCodeFunc = CanProvideCodeFunc
        enemy_item.OnLeftClickFunc = SetText
        enemy_item.OnRightClickFunc = ClearText
        enemy_item.SaveFunc = EnemySaveFunc
        enemy_item.LoadFunc = EnemyLoadFunc
    end
end

local function CreateLuaTextItems()
    for i=0,13 do
        local text_item = ScriptHost:CreateLuaItem()
        text_item.Name = ""
        text_item.Icon = ImageReference:FromPackRelativePath("images/items/BlackBox.png")
        text_item.ItemState = {
            Code = "text_item_" .. tostring(i)
        }

        if Tracker.ActiveVariantUID == "var_OGSpritesWithMapSmall" or Tracker.ActiveVariantUID == "var_SwitchRemakeNoOutlinesWithMapSmall" then
            text_item:SetOverlayFontSize(10)
        else
            text_item:SetOverlayFontSize(20)
        end
        
        text_item:SetOverlayAlign("left")
        text_item.CanProvideCodeFunc = CanProvideCodeFunc
        text_item.ProvidesCodeFunc = CanProvideCodeFunc
    end
end

local function CreateLuaButtonItems()
    for i=1,2 do
        local button_item = ScriptHost:CreateLuaItem()
        button_item.Name = ""
        button_item.Icon = ImageReference:FromPackRelativePath("images/items/BlackBox.png")
        button_item.ItemState = {
            Code = "button_item_" .. tostring(i),
            Enemy = nil,
            Page = 1
        }
        
        if Tracker.ActiveVariantUID == "var_OGSpritesWithMapSmall" or Tracker.ActiveVariantUID == "var_SwitchRemakeNoOutlinesWithMapSmall" then
            button_item:SetOverlayFontSize(10)
        else
            button_item:SetOverlayFontSize(20)
        end
        
        button_item:SetOverlayAlign("left")
        button_item.CanProvideCodeFunc = CanProvideCodeFunc
        button_item.ProvidesCodeFunc = CanProvideCodeFunc
        if i == 1 then
            button_item.OnLeftClickFunc = PrevPage
        else
            button_item.OnLeftClickFunc = NextPage
        end
    end
end

CreateLuaEnemyItems(ENEMY_DICT)
CreateLuaTextItems()
CreateLuaButtonItems()