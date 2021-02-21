local core = require "theflood.core"

local weapons = {}

local animatedCrosshairsTags = {
    core.findTag("fuel_rod", tagClasses.weaponHudInterface).path,
    core.findTag("shotgun_m90", tagClasses.weaponHudInterface).path
}

function weapons.animateCrosshairs()
    for crosshairNumber, crosshairTagPath in pairs(animatedCrosshairsTags) do
        local weaponHud = blam.weaponHudInterface(crosshairTagPath)
        local crosshairs = weaponHud.crosshairs
        local player = blam.biped(get_dynamic_player())
        if (player and weaponHud) then
            local newCrosshairs = weaponHud.crosshairs
            if (player.shooting == 1) then
                local currentScale = {
                    width = newCrosshairs[1].overlays[1].widthScale,
                    height = newCrosshairs[1].overlays[1].heightScale
                }
                newCrosshairs[1].overlays[1].widthScale = currentScale.width * 1.2
                newCrosshairs[1].overlays[1].heightScale = currentScale.height * 1.2
            else
                local currentScale = {
                    width = newCrosshairs[1].overlays[1].widthScale,
                    height = newCrosshairs[1].overlays[1].heightScale
                }
                newCrosshairs[1].overlays[1].widthScale = 0.25
                newCrosshairs[1].overlays[1].heightScale = 0.25
            end
            weaponHud.crosshairs = newCrosshairs
        end
    end
end

local rotation = 0

function weapons.rotateWeaponsInPads()
    -- Local scope variables
    if (rotation < 360) then
        rotation = rotation + 1
    else
        rotation = 0
    end
    local objects = blam.getObjects()
    for _, objectIndex in pairs(objects) do
        local tempObject = blam.object(get_object(objectIndex))
        if (tempObject and tempObject.type == objectClasses.weapon and
            blam.isNull(tempObject.playerId)) then
            core.rotateObject(objectIndex, rotation, 0, 0)
        end
    end
end



return weapons
