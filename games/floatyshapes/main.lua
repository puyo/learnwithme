local floatyshapes = {}
floatyshapes.shapes = {}
floatyshapes.maxSize = 400

function floatyshapes.spawnShape()
    local newShape = floatyshapes.newTriangle()
    table.insert(floatyshapes.shapes, newShape)
end

--------------------------------------------------

function floatyshapes.newTriangle()
    local self = {}
    self.points = {
        math.random(0, floatyshapes.maxSize), 0, 
        0, math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), 
        math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), 
    }

    -- start position
    local minX = -floatyshapes.maxSize
    local minY = -floatyshapes.maxSize
    local maxX = love.graphics.getWidth() + floatyshapes.maxSize
    local maxY = love.graphics.getHeight() + floatyshapes.maxSize
    local margin = 100
    local destX = math.random(margin, love.graphics.getWidth() - margin)
    local destY = math.random(margin, love.graphics.getHeight() - margin)
    
    if math.random(2) == 1 then -- random x
        self.x = math.random(minX, maxX)
        if math.random(2) == 1 then
            self.y = minY
        else
            self.y = maxY
        end
    else -- random y
        self.y = math.random(minY, maxY)
        if math.random(2) == 1 then
            self.x = minX
        else
            self.x = maxX
        end
    end
    self.speed = math.random(1, 10)
    self.dx = destX - self.x
    self.dy = destY - self.y
    self.colour = { math.random(255), math.random(255), math.random(255) }

    function self:draw()
        love.graphics.setColor(self.colour[1], self.colour[2], self.colour[3])
        love.graphics.polygon('fill', {
            self.x + self.points[1], self.y + self.points[2], 
            self.x + self.points[3], self.y + self.points[4], 
            self.x + self.points[5], self.y + self.points[6], 
        })
    end

    return self
end

--------------------------------------------------

function love.load()
    love.mouse.setVisible(false)	
end

function love.update(dt)
    local scale = 0.1
    for i, shape in ipairs(floatyshapes.shapes) do
        shape.x = shape.x + shape.speed*shape.dx*dt*scale
        shape.y = shape.y + shape.speed*shape.dy*dt*scale
    end
end

function love.draw()
    for i, shape in ipairs(floatyshapes.shapes) do
        shape:draw()
    end
end

function love.keypressed(k)
    floatyshapes.spawnShape()
end
