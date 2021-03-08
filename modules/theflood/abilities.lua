local abilities = {}
local thrusterAvailable = true
local jetpackHeat = 10
local player = blam.biped(get_dynamic_player())

--[[
    Review by Sled:

    These are global functions stored in a module that has local functions it does not make sense
    In general modules should not have global functions at all, the idea behind a module is to
    isolate functions among the module, so creating a global function is not following this pattern

    Functions used internally by the module should be local non exposed functions, example:

    local function ResetThruster()
    
    end


    And called where needed this way:

    ResetThruster()


    In order use them in a exposed function they should be called like this:

    function abilities.myPublicFunction()
        ResetThruster()
    end



    If you need to expose a public function then the function should be like this:

    function abilities.ResetThruster()
    end

]]
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
