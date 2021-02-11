------------------------------------------------------------------------------
-- Ancient map script
-- Sledmine
-- This script is intended to provide functions and features to ancient map
------------------------------------------------------------------------------
clua_version = 2.042

blam = require "blam"
tagClasses = blam.tagClasses
objectClasses = blam.objectClasses

-- Project modules
local core = require "features.core"

-- Local scope variables
local rotation = 0

function OnTick()
    if (rotation < 360) then
        rotation = rotation + 1
    else
        rotation = 0
    end
    local objects = blam.getObjects()
    for _, objectIndex in pairs(objects) do
        local tempObject = blam.object(get_object(objectIndex))
        if (tempObject and tempObject.type == objectClasses.weapon and tempObject.playerId ==
            0xFFFFFFFF) then
            core.rotateObject(objectIndex, rotation, 0, 0)
        end
    end
    return false
end

set_callback("tick", "OnTick")
