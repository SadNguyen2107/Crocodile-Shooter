local Player = require "src.player"
local Enemy = require "src.enemy"
local ScoreBoard = require "src.scoreBoard"

font = nil
tick = require "lib.tick"

function love.load()
    font = love.graphics.newFont("assets/CURLZ.TTF", 40)
    love.graphics.setFont(font)

    player = Player("assets/elephant.png",
        love.graphics:getWidth() / 2, 100, 0,
        1, 1,
        nil, nil,
        nil, nil,
        200,
        5
    )
    enemy = Enemy("assets/crocodile.png",
        100, 500, 0,
        1, 1,
        nil, nil,
        nil, nil,
        100
    )

    scoreBoard = ScoreBoard(player)
end

function love.update(dt)
    player:update(dt, scoreBoard)
    enemy:update(dt)
    tick.update(dt)
end

function love.draw()
    player:draw()
    enemy:draw()

    -- Draw the scoreBoard
    scoreBoard:drawPoints()
    scoreBoard:drawBulletLeft()
    scoreBoard:drawMissesLeft()
    scoreBoard:drawReset()
end

function love.keypressed(key)
    player:keypressed(key)
end
