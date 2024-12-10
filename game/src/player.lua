local Bullet = require "src.bullet"
local MovingObject = require "src.movingObject"

---@class Player : MovingObject
---@field bulletLeft integer # The bullet left the player can shoot
---@field maximumBullet integer # The maximum bullet the player can shoot
---@field listOfBullets Bullet[] # To store the bullet that the player shoot
local Player = MovingObject:extend()

function Player:new(filename, x, y, r, sx, sy, ox, oy, kx, ky, speed, maximumBullet)
    Player.super.new(self, filename, x, y, r, sx, sy, ox, oy, kx, ky, speed)

    if maximumBullet > 0 then
        self.maximumBullet = maximumBullet
    else
        self.maximumBullet = 5
    end

    self.bulletLeft = self.maximumBullet
    self.listOfBullets = {}
end

--- Update the position of the player
--- @param dt number # Delta time for smooth movement
--- @field scoreBoard ScoreBoard    # The ScoreBoard to track the point
function Player:update(dt, scoreBoard)
    -- If pressed left
    if love.keyboard.isDown("left", "a") and self:canMoveLeft() then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right", "d") and self:canMoveRight() then
        self.x = self.x + self.speed * dt
    end

    -- Update the bullet
    if self.listOfBullets then
        for index, bullet in ipairs(self.listOfBullets) do
            bullet:update(dt)

            -- Check collision for enemy
            local isCollideWIthEnemy = bullet:isCollideWithObj(enemy)
            local isReachTheEnd = bullet:isReachTheEnd()

            -- TODO: If Reach the End --> Restarts Game
            if isReachTheEnd then
                table.remove(self.listOfBullets, index)

                -- Update the bulletLeft
                self.bulletLeft = self.bulletLeft + 1

                -- Update the misses
                scoreBoard.missesLeft = scoreBoard.missesLeft - 1
            end

            -- If collide --> dead
            if isCollideWIthEnemy then
                table.remove(self.listOfBullets, index)

                -- Update the bulletLeft
                self.bulletLeft = self.bulletLeft + 1

                -- Update the score
                scoreBoard.currentPoint = scoreBoard.currentPoint + 1
            end
        end
    end
end

---Draw the Player
function Player:draw()
    -- Draw the player
    Player.super.draw(self)

    -- Draw the bullet
    if self.listOfBullets then
        for _, bullet in ipairs(self.listOfBullets) do
            bullet:draw()
        end
    end
end

---Shoot Bullet if pressed space
---@param key any
function Player:keypressed(key)
    if (key == "space") and (self.bulletLeft > 0) then
        self:shootBullet()
    end
end

---To check whether the player can move right
---@return boolean
function Player:canMoveRight()
    return self.x + self.ox <= love.graphics.getWidth()
end

---To check wether the player can move left
---@return boolean
function Player:canMoveLeft()
    return self.x - self.ox >= 0
end

---To shoot a bullet
---@return Bullet
function Player:shootBullet()
    local bullet = Bullet("assets/bullet.png",
        self.x, self.y + 100, 0,
        0.05, 0.05,
        nil, nil,
        nil, nil,
        200
    )

    table.insert(self.listOfBullets, bullet)

    -- Update the current bullet
    self.bulletLeft = self.bulletLeft - 1

    return bullet
end

return Player
