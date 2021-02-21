local core = {}

-- Optimizations
local sin = math.sin
local cos = math.cos
local rad = math.rad
local sqrt = math.sqrt
local abs = math.abs
local floor = math.floor
local concat = table.concat

--- Covert euler into game rotation array, optional rotation matrix
---@param yaw number
---@param pitch number
---@param roll number
---@return table<number, number>, table<number, table<number, number>>
function core.eulerToRotation(yaw, pitch, roll)
    local matrix = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}

    local cosRoll = cos(rad(roll))
    local sinRoll = sin(rad(roll))
    local cosYaw = cos(rad(yaw))
    local sinYaw = sin(rad(yaw))
    local cosPitch = cos(rad(pitch))
    local sinPitch = sin(rad(pitch))
    matrix[1][1] = cosRoll * cosYaw
    matrix[1][2] = sinRoll * sinPitch - cosRoll * sinYaw * cosPitch
    matrix[1][3] = cosRoll * sinYaw * sinPitch + sinRoll * cosPitch
    matrix[2][1] = sinYaw
    matrix[2][2] = cosYaw * cosPitch
    matrix[2][3] = -cosYaw * sinPitch
    matrix[3][1] = -sinRoll * cosYaw
    matrix[3][2] = sinRoll * sinYaw * cosPitch + cosRoll * sinPitch
    matrix[3][3] = -sinRoll * sinYaw * sinPitch + cosRoll * cosPitch
    local array = {
        matrix[1][1],
        matrix[2][1],
        matrix[3][1],
        matrix[1][3],
        matrix[2][3],
        matrix[3][3]
    }
    return array, matrix
end

--- Rotate object into desired angles
---@param objectId number
---@param yaw number
---@param pitch number
---@param roll number
function core.rotateObject(objectId, yaw, pitch, roll)
    if (not objectId) then
        error("No object id was specified for rotateObject function!")
    end
    local rotation = core.eulerToRotation(yaw, pitch, roll)
    local tempObject = blam.object(get_object(objectId))
    tempObject.vX = rotation[1]
    tempObject.vY = rotation[2]
    tempObject.vZ = rotation[3]
    tempObject.v2X = rotation[4]
    tempObject.v2Y = rotation[5]
    tempObject.v2Z = rotation[6]
end

--- Find the path, index and id of a tag given partial name of the tag and tag type
---@param partialName string
---@param searchTagType string
function core.findTag(partialName, searchTagType)
    for tagIndex = 0, blam.tagDataHeader.count - 1 do
        local tempTag = blam.getTag(tagIndex)
        if (tempTag and tempTag.path:find(partialName) and tempTag.class == searchTagType) then
            return {path = tempTag.path, id = tempTag.id, index = tempTag.index}
        end
    end
    return nil
end

return core