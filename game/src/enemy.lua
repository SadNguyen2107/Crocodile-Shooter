local MovingObject = require "src.movingObject"

---@class Enemy : MovingObject
local Enemy = MovingObject:extend()

--- TODO: Maybe can optimize this function of checking if touch the edge further more
--- Update the position of the enemy
--- @param dt number # Delta time for smooth movement
function Enemy:update(dt)
    -- If the enemy reach the end of the left --> Turn right
    -- If the enemy reach the end of the right --> Turn left
    if self:isTouchTheEdge() then
        -- Reverse the speed
        self.speed = -self.speed
    end

    self.x = self.x + self.speed * dt
end

function Enemy:isTouchTheEdge()
    local isTouchRightEdge = self.x + self.ox >= love.graphics.getWidth()
    local isTouchLeftEdge = self.x - self.ox <= 0

    return isTouchRightEdge or isTouchLeftEdge
end

return Enemy
