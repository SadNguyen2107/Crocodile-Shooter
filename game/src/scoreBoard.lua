local Object = require "lib.classic"

---@class ScoreBoard : Object
---@field player Player # Player to track
---@field missesLeft integer # The miss bullet can have
---@field currentPoint integer # The point to track
local ScoreBoard = Object:extend()

---To draw the bullet text
---@param player Player     # Player to track the bullet
function ScoreBoard:new(player)
    self.player = player
    self.currentPoint = 0
    self.missesLeft = 5
end

function ScoreBoard:drawBulletLeft()
    -- Draw the bullet board
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.print(
        "Bullet Left: " .. self.player.bulletLeft,
        50, 50
    )
end

function ScoreBoard:drawPoints()
    -- Draw the bullet board
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.print(
        "Points: " .. self.currentPoint,
        600, 50
    )
end

function ScoreBoard:drawMissesLeft()
    -- Draw the bullet board
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.print(
        "Misses Left: " .. self.missesLeft,
        50, 100
    )
end

function ScoreBoard:drawReset()
    -- Draw the Reset then reset after 5s
    if self.missesLeft < 1 then
        love.graphics.setFont(font) -- Set the font to the large font
        local text = "You Lose!"
        local textWidth = font:getWidth(text)
        local textHeight = font:getHeight()

        -- Center the text both horizontally and vertically
        love.graphics.print(
            text,
            love.graphics:getWidth() / 2 - textWidth / 2,
            love.graphics:getHeight() / 2 - textHeight / 2
        )
        tick.delay(love.load, 5)
    end
end

return ScoreBoard
