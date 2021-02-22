local core = require "theflood.core"

local weapons = {}

local animatedCrosshairsTagsCommon = {
    core.findTag("smg_m7a", tagClasses.weaponHudInterface).path,
}

local animatedCrosshairsTagsLarger = {
    core.findTag("assault_rifle_ma38", tagClasses.weaponHudInterface).path,
}


    --Crosshair SMG
function weapons.animateCrosshairs()
    for crosshairNumber, crosshairTagPath in pairs(animatedCrosshairsTagsCommon) do
        local weaponHud = blam.weaponHudInterface(crosshairTagPath)
        local crosshairs = weaponHud.crosshairs
        local player = blam.biped(get_dynamic_player())
        if (player and weaponHud) then
            local newCrosshairs = weaponHud.crosshairs
            if (player.shooting == 1) then
                --local currentScale = {
                    --width = newCrosshairs[1].overlays[1].widthScale,
                    --height = newCrosshairs[1].overlays[1].heightScale
                --}
                --console_out("Dynamic Crosshair Working")
                newCrosshairs[1].overlays[1].x = -7
                newCrosshairs[2].overlays[1].x = 7
                newCrosshairs[3].overlays[1].y = -7
                newCrosshairs[4].overlays[1].y = 7
                newCrosshairs[5].overlays[1].widthScale = 0.235
                newCrosshairs[5].overlays[1].heightScale = 0.235
                newCrosshairs[6].overlays[1].widthScale = 0.135
                newCrosshairs[6].overlays[1].heightScale = 0.135
                weaponHud.crosshairs = newCrosshairs
            else
                --local currentScale = {
                    --width = newCrosshairs[1].overlays[1].widthScale,
                    --height = newCrosshairs[1].overlays[1].heightScale
                --}
                newCrosshairs[1].overlays[1].x = 0
                newCrosshairs[2].overlays[1].x = 0
                newCrosshairs[3].overlays[1].y = 0
                newCrosshairs[4].overlays[1].y = 0
                newCrosshairs[5].overlays[1].widthScale = 0.25
                newCrosshairs[5].overlays[1].heightScale = 0.25
                newCrosshairs[6].overlays[1].widthScale = 0.001
                newCrosshairs[6].overlays[1].heightScale = 0.001
            end
            weaponHud.crosshairs = newCrosshairs
        end     
    end
end

    --Crosshair Assaul Rifle
function weapons.animateCrosshairsAr()
    for crosshairNumber, crosshairTagPath in pairs(animatedCrosshairsTagsLarger) do
        local weaponHud = blam.weaponHudInterface(crosshairTagPath)
        local crosshairs = weaponHud.crosshairs
        local player = blam.biped(get_dynamic_player())
        if (player and weaponHud) then
            local newCrosshairs = weaponHud.crosshairs
            if (player.shooting == 1) then
                --local currentDisplace = {
                    --xMove = newCrosshairs[1].overlays[1].x
                    --yMove = newCrosshairs[1].overlays[1].y
                --}
                --console_out("Dynamic Crosshair Working")
                newCrosshairs[1].overlays[1].x = -10
                newCrosshairs[2].overlays[1].x = 10
                newCrosshairs[3].overlays[1].y = -10
                newCrosshairs[4].overlays[1].y = 10
                newCrosshairs[5].overlays[1].widthScale = 0.235
                newCrosshairs[5].overlays[1].heightScale = 0.235
                newCrosshairs[6].overlays[1].widthScale = 0.135
                newCrosshairs[6].overlays[1].heightScale = 0.135
                weaponHud.crosshairs = newCrosshairs
            else
                --local currentScale = {
                    --width = newCrosshairs[1].overlays[1].widthScale,
                    --height = newCrosshairs[1].overlays[1].heightScale
                --}
                newCrosshairs[1].overlays[1].x = 0
                newCrosshairs[2].overlays[1].x = 0
                newCrosshairs[3].overlays[1].y = 0
                newCrosshairs[4].overlays[1].y = 0
                newCrosshairs[5].overlays[1].widthScale = 0.25
                newCrosshairs[5].overlays[1].heightScale = 0.25
                newCrosshairs[6].overlays[1].widthScale = 0.001
                newCrosshairs[6].overlays[1].heightScale = 0.001
            end
            weaponHud.crosshairs = newCrosshairs
        end     
    end
end

local rotation = 0

function weapons.rotateWeaponsInPads() --Weapon Pad for Rotating weapons
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
