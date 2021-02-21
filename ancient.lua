------------------------------------------------------------------------------
-- Ancient map script
-- Sledmine
-- This script is intended to provide functions and features to ancient map
------------------------------------------------------------------------------
clua_version = 2.056

blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

-- Project modules
local core = require "theflood.core"
local weapons = require "theflood.weapons"

function OnTick()
    weapons.animateCrosshairs()
    weapons.rotateWeaponsInPads()
end

set_callback("tick", "OnTick")
