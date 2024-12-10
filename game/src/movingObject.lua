local Object = require "lib.classic"

---@class MovingObject : Object
---@field x number  # The x-coordinate of the object
---@field y number  # The y-coordinate of the object
---@field image love.Image # The image associated with the object
---@field r number # The rotation of the object (in radians)
---@field sx number # The scaling factor along the x-axis
---@field sy number # The scaling factor along the y-axis
---@field ox number # The origin offset on the x-axis for rotation/scaling
---@field oy number # The origin offset on the y-axis for rotation/scaling
---@field kx number # The shear factor along the x-axis
---@field ky number # The shear factor along the y-axis
---@field speed number # The speed at which the object moves
local MovingObject = Object:extend()

--- Constructor for the MovingObject
--- @param self MovingObject # The instance of the MovingObject class
--- @param filename string # The filename of the image to load
--- @param x number # The x-coordinate of the object
--- @param y number # The y-coordinate of the object
--- @param r number # The rotation of the object (in radians)
--- @param sx number # The scaling factor along the x-axis
--- @param sy number # The scaling factor along the y-axis
--- @param ox number|nil # The origin offset on the x-axis for rotation/scaling
--- @param oy number|nil # The origin offset on the y-axis for rotation/scaling
--- @param kx number|nil # The shear factor along the x-axis
--- @param ky number|nil # The shear factor along the y-axis
--- @param speed number # The speed at which the object moves
function MovingObject:new(filename, x, y, r, sx, sy, ox, oy, kx, ky, speed)
    -- Load the image
    self.image = love.graphics.newImage(filename)
    self.x = x or 0
    self.y = y or 0
    self.r = r or 0
    self.sx = sx or 1
    self.sy = sy or 1
    self.ox = ox or self.image:getWidth() / 2
    self.oy = oy or self.image:getHeight() / 2
    self.kx = kx or 0
    self.ky = ky or 0
    self.speed = speed or 0 -- Default speed is 0 if not provided
end

--- Draw the moving object
function MovingObject:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y, self.r, self.sx, self.sy, self.ox, self.oy, self.kx, self.ky)

    -- Draw the origin
    -- love.graphics.setColor(1, 0, 0, 1) -- Red color, fully opaque
    -- love.graphics.setPointSize(10)     -- Makes the point 10 pixels in diameter
    -- love.graphics.points(self.x, self.y)
end

--- Returns a string representation of the MovingObject
--- @param self MovingObject # The instance of the MovingObject class
function MovingObject:__tostring()
    return string.format(
        "MovingObject(x: %.2f, y: %.2f, rotation: %.2f, scaleX: %.2f, scaleY: %.2f, speed: %.2f)",
        self.x, self.y, self.r, self.sx, self.sy, self.speed
    )
end

return MovingObject
