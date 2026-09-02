STARS = {"DiamondStar", "EmeraldStar", "GoldStar", "RubyStar", "SapphireStar", "GarnetStar", "CrystalStar"}
STAR_LOCATIONS = {"@Magical Map/Hooktail's Castle/Hooktail's Castle Hooktail's Room - Diamond Star",
"@Magical Map/Great Tree/Great Tree Entrance - Emerald Star",
"@Magical Map/Glitzpit/Glitzville Arena - Gold Star",
"@Magical Map/Creepy Steeple/Creepy Steeple Upper Room - Ruby Star",
"@Magical Map/Pirate's Grotto/Pirate's Grotto Cortez' Hoard - Sapphire Star",
"@Magical Map/Poshley Heights/Poshley Heights Sanctum Altar - Garnet Star",
"@Magical Map/X-Naut Fortress/X-Naut Fortress Boss Room - Crystal Star"}

function stars(AMOUNT)
	AMOUNT = tonumber(AMOUNT)
	local req = AMOUNT
	local count = 0
	for _, item in pairs(STARS) do
		if has(item) then
			count = count + 1
		end
	end
return count >= req
end

function chapters(AMOUNT)
	AMOUNT = tonumber(AMOUNT)
	local req = AMOUNT
	local count = 0
	for _, location in pairs(STAR_LOCATIONS) do
		if can_reach(location .. " Dummy") then
			count = count + 1
		end
	end
return count >= req
end

function enemy_rando(ENEMY_NAME)
    local enemy_rando_obj = Tracker:FindObjectForCode("enemy_randomizer")
    if enemy_rando_obj then
        if enemy_rando_obj.CurrentStage == "0" then
			print("Enemy rando disabled")
            return AccessibilityLevel.None
        end
	else
		print("Enemy rando object not found")
		return AccessibilityLevel.None
    end
	ENEMY_NAME = "Tattle: " .. ENEMY_NAME
	print("Finding access level for " .. ENEMY_NAME)
	local location_ids = ENEMY_DICT[ENEMY_NAME]
	if location_ids then
		local highest_access = AccessibilityLevel.None
		for _, id in pairs(location_ids) do
			local location_array = LOCATION_MAPPING[id]
			if not location_array then
				print("location ID " .. tostring(id) .. " not found in location mapping")
			else
				for _, code in pairs(location_array) do
					local current_access = get_access_level(code .. " Dummy")
					if current_access > highest_access then
						print("New highest access level: " .. tostring(current_access) .. " at " .. code)
						highest_access = current_access
						if current_access >= AccessibilityLevel.Normal then
							return highest_access
						end
					end
				end
			end
		end
		return highest_access
	else
		print("location ids not found")
		return AccessibilityLevel.None
	end
end

-- Access Functions

function tube()
	return has("PaperCurse") and has("TubeCurse")
	end

function yoshi()
	return has("Yoshi") or has("Gyoshi") or has("RYoshi") or has("BYoshi") or has("OYoshi") or has("PYoshi") or has("DYoshi") or has("WYoshi")
	end

function westside()
	return (has("ContactLens") or has("Bobbery") or (tube()) or has("UltraHammer")) or has("west_open")
	end

function bogglywoods()
	return has("PaperCurse") or (has("Superhammer") and has("SuperBoots") and has("pipe_on"))
	end

function pit()
	return (has("PaperCurse") and has("PlaneCurse")) or (has("ContactLens") and has("PaperCurse") and has("Flurrie")) or(has("Bobbery") and has("Flurrie")) or ((tube())and has("Flurrie")) or (has("UltraHammer") and has("Flurrie")) or (sewerwestground() and has "Flurrie")
	end

function sewerwest()
	return ((has("ContactLens") or has("west_open")) and has("PaperCurse")) or (has("UltraHammer") and has("PaperCurse")) or (tube()) or (has("Bobbery")) or ((has("UltraBoots")) and (has("UltraHammer")) and (yoshi()))
	end

function sewerwestground()
	return ((has("ContactLens") or has("west_open")) and has("PaperCurse")) or has("UltraHammer") or (tube()) or (has("Bobbery"))
	end

function ttyd()
	return has("PlaneCurse") or has("SuperHammer") or (has("Flurrie") and has("Bobbery")) or (has("Flurrie") and(tube())) or (has("ContactLens") and has("PaperCurse") and has("Flurrie"))
	end

function twilight_town()
	return (sewerwest() and yoshi()) or (has("UltraBoots") and sewerwestground())
	end

function steeple()
	return ((twilight_town()) and has("Flurrie") and (has("SuperBoots"))) and (tube())
	end

function keelhaul_key()
	return ((yoshi()) and (tube()) and (has("OldLetter"))) or (has("UltraHammer") and has("SuperBoots") and has("pipe_on"))
	end

function general_white()
	return ((has("Bobbery") and has("PlaneCurse")) or (has("Bobbery") and has("SuperHammer") and has("SuperBoots"))) and (twilight_town()) and (keelhaul_key()) and (westside()) and has("BlimpTicket") and (bogglywoods()) and(fahr_outpost()) and has("Flurrie") and (twilight_town())
	end

function moon()
	return has("Bobbery") and has("GoldbobGuide") and (fahr_outpost())
	end

function riverside()
	return has("Vivian") and has("Autograph") and has("RaggedDiary") and has("Blanket") and has("VitalPaper") and has ("TrainTicket") and westside()
	end

function fahr_outpost()
	return (twilight_town()) and has("UltraHammer")
	end

function pirates_grotto()
	return has("Bobbery") and has("SkullGem") and (yoshi()) and has("SuperBoots")
	end

function poshley_heights() -- General regional access to Poshley Heights, not the Sanctum.
	return ((poshleysanctum())) or (has("UltraHammer") and has("SuperBoots") and has("pipe_on"))
	end

function poshleysanctum()  -- Access to the Sanctum is gated by the chapter 6 story, which is required to access the sanctum, as opposed to poshley_heights.
	return has("TrainTicket") and (westside()) and (riverside()) and has("StationKey1") and has("ElevatorKey") and has("UltraBoots")
	end

function htcastle()
	return ((has("PlaneCurse")) or (yoshi())) and has("SunStone") and has("MoonStone")
	end

function invisible()
	return false
	end

function riddle_tower()
	return (has("Vivian") or (tube())) and has("PalaceKey1") and has("BoatCurse") and has("Bobbery")
	end

function palaceright()
	return (riddle_tower()) and has("StarKey") and has("PalaceKey(RiddleTower)8")
	end

function palace()
	return (ttyd()) and (((stars(0)) and has("Chapter0")) or ((stars(1)) and has("Chapter1")) or ((stars(2)) and has("Chapter2")) or ((stars(3)) and has("Chapter3")) or ((stars(4)) and has("Chapter4")) or ((stars(5)) and has("Chapter5")) or ((stars(6)) and has("Chapter6")) or ((stars(7)) and has("Chapter7")))
	end

function tenpunis()
	return has("PuniOrb") and (has("RedKey") or has("BlueKey"))
	end

function ninetypunis()
	return has("PuniOrb") and has("BlueKey")
	end

function hundredpunis()
	return has("PuniOrb") and has("RedKey") and has("BlueKey")
	end

function HRGlvl1()
	return has("GlitchedLogic")
	end

function HRGlvl2()
	return (has("SuperBoots") and has("GlitchedLogic"))
	end

function HRG_twilight_town()
	return ((has("UltraBoots") or (has("PaperCurse") and yoshi())) and has("GlitchedLogic"))
	end

function HRG_sewerwest()
	return ((has("PaperCurse") or (has("UltraBoots") and yoshi())) and has("GlitchedLogic"))
	end

function HRG_palace()
	return (has("Flurrie") and has("GlitchedLogic")) and (((stars(0)) and has("Chapter0")) or ((stars(1)) and has("Chapter1")) or ((stars(2)) and has("Chapter2")) or ((stars(3)) and has("Chapter3")) or ((stars(4)) and has("Chapter4")) or ((stars(5)) and has("Chapter5")) or ((stars(6)) and has("Chapter6")) or ((stars(7)) and has("Chapter7")))
	end



