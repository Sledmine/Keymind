local abilities = {}
local thrusterAvailable = true
local jetpackHeat = 10
local player = blam.biped(get_dynamic_player())

function ResetThruster()
    console_out("Thruster Is Ready")
    thrusterAvailable = true
    return false
end

function JetpackHeated()
    if (player.jumpHold == false) then
        if (jetpackHeat < 10) then
            jetpackHeat = jetpackHeat + 0.1
            console_out("Jetpack Is Cooling")
        else
            console_out("Jetpack Is Ready")
        end
    end
    return false
end

function JetpackOverheat()
    if (player.jumpHold == false) then
        if (jetpackHeat < 10) then
            jetpackHeat = jetpackHeat + 0.1
            console_out("Jetpack Is Cooling")
        else
            console_out("Jetpack Is Ready")
        end
    end
    return false
end

function abilities.thrusterpack()
    if (player) then
        if (player.actionKey) then
            if (thrusterAvailable == true) then
                if (player.isOnGround) then
                    if (player.crouchHold) then
                        player.xVel = player.xVel * 5.5
                        player.yVel = player.yVel * 5.5
                    else
                        player.xVel = player.xVel * 3.5
                        player.yVel = player.yVel * 3.5
                    end
                else
                    player.xVel = player.xVel * 2.25
                    player.yVel = player.yVel * 2.25
                    if (player.jumpHold) then
                        player.zVel = player.zVel + 0.05
                    end
                    if (player.crouchHold) then
                        player.zVel = player.zVel - 0.05
                    end
                end
                thrusterAvailable = false
                set_timer(3000, "ResetThruster")
                console_out("Thruster Is Charging")
            else
                console_out("Thruster Isn't Ready")
            end
        end
    end
end

function abilities.jetpack()
    if (player) then
        if (player.jumpHold) then
            if (jetpackHeat > 0) then
                player.zVel = player.zVel + 0.0035
                jetpackHeat = jetpackHeat - 0.08
            else
                console_out("Jetpack Is Overheat")
            end
        elseif (jetpackHeat < 10) and (jetpackHeat > 0) then
            set_timer(3000, "JetpackHeated")
        end
        if (jetpackHeat <= 0) and (player.jumpHold == false) then
            set_timer(9000, "JetpackOverheat")
        end
    end
end

return abilities