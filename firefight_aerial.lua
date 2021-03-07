clua_version = 2.056

blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

local abilities = require "theflood.abilities"
-- local elevators = require "theflood.elevators"
local encounters = require "theflood.encounters"
local weapons = require "theflood.weapons"

function OnTick()
    --abilities.thrusterpack()
    --abilities.jetpack()
    --elevators.elevate()
    encounters.gimmecovies()
    weapons.animateCrosshairs()
    weapons.animateCrosshairsAr()
end

set_callback("tick", "OnTick")
