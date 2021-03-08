local encounters = {}

local hsc = require "hsc"

--[[
This is a template string that can be formatted later
%s will be replaced by a string value later, example:

local encounterNameTemplate = "Oleada%s_Op%s"

console_out(encounterNameTemplate:format("1", "A"))

Will result into:

console_out("Oleada1_OpA")

]]
--local encounterNameTemplate = "encounter_block_%s"
local encounterNameTemplate = "Oleada%s_Op%s"
local uglyHack = {"A", "B", "C"}


function encounters.gimmecovies()
    local player = blam.biped(get_dynamic_player())
    if (player) then
        if (player.actionKey) then
            local randomEncounterIndex = math.random(1, 3)
            local randomEncounterName = encounterNameTemplate:format(randomEncounterIndex, uglyHack[math.random(1,3)])
            console_out(randomEncounterName)
            hsc.aiPlace(randomEncounterName)
            --hsc.aiMagicallySeePlayers("drones")
        end
    end
end

return encounters
