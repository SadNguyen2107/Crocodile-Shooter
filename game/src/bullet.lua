local MovingObject = require "src.movingObject"

---@class Bullet : MovingObject
local Bullet = MovingObject:extend()

function Bullet:new(filename, x, y, r, sx, sy, ox, oy, kx, ky, speed)
    Bullet.super.new(self, filename, x, y, r, sx, sy, ox, oy, kx, ky, speed)
end

function Bullet:update(dt)
    -- Move the bullet downwards
    self.y = self.y + self.speed * dt
end

---If this bullet collide with enemy --> Make enemy go faster
---@param obj MovingObject
---@return boolean
function Bullet:isCollideWithObj(obj)
    local isCollide = false

    local self_left = self.x - (self.ox * self.sx)
    local self_right = self.x + (self.ox * self.sx)
    local self_top = self.y - (self.oy * self.sy)
    local self_bottom = self.y + (self.oy * self.sy)

    local obj_left = obj.x - (obj.ox * obj.sx)
    local obj_right = obj.x + (obj.ox * obj.sx)
    local obj_top = obj.y - (obj.oy * obj.sy)
    local obj_bottom = obj.y + (obj.oy * obj.sy)

    -- Check if collide
    isCollide = (self_right > obj_left)
        and (self_left < obj_right)
        and (self_bottom > obj_top)
        and (self_top < obj_bottom)

    if isCollide then
        -- Remove this bullet
        isCollide = true

        -- Make the enemy speed faster
        local Enemy = require "src.enemy"
        if obj:is(Enemy) then
            obj.speed = obj.speed + 50 * self:getSign(obj.speed)
        end
    end

    return isCollide
end

function Bullet:isReachTheEnd()
    -- Check if out of screen
    local self_top = self.y - (self.oy * self.sy)
    return self_top >= love.graphics.getHeight()
end

---To get the sign of a number
---@param num number
---@return integer
function Bullet:getSign(num)
    if num > 0 then
        return 1
    elseif num < 0 then
        return -1
    else
        return 0
    end
end

return Bullet
