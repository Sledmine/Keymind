local abilities = {}

function abilities.thruster()
    local player = blam.biped(get_dynamic_player())
    if (player and player.flashlightKey and player.isOnGround) then
        player.zVel = player.zVel + 0.2
    end
end

return abilities