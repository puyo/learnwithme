local floatyshapes = {}
floatyshapes.shapes = {}
floatyshapes.maxSize = 400
floatyshapes.margin = 100

function floatyshapes.spawnShape()
  local newShape
  if math.random(2) == 1 then
    newShape = floatyshapes.newTriangle()
  else
    newShape = floatyshapes.newRectangle()
  end
  table.insert(floatyshapes.shapes, newShape)
end

function floatyshapes.minX() 
  return -floatyshapes.maxSize 
end

function floatyshapes.minY() 
  return -floatyshapes.maxSize 
end

function floatyshapes.maxX() 
  return love.graphics.getWidth() 
end

function floatyshapes.maxY() 
  return love.graphics.getHeight() 
end

function floatyshapes.randomDestX() 
  return math.random(floatyshapes.margin, love.graphics.getWidth() - floatyshapes.margin) 
end

function floatyshapes.randomDestY()
  return math.random(floatyshapes.margin, love.graphics.getHeight() - floatyshapes.margin)
end

function floatyshapes.randomColour()
  return { math.random(255), math.random(255), math.random(255) }
end

function floatyshapes.inbounds(shape)
  if (shape.x < floatyshapes.minX() or shape.x > floatyshapes.maxX()) or
    (shape.y < floatyshapes.minY() or shape.y > floatyshapes.maxY()) then
    return false
  else
    return true
  end
end

function floatyshapes.initShape(shape)
  if math.random(2) == 1 then -- top or bottom
    shape.x = math.random(0, love.graphics.getWidth() - shape:width())
    if math.random(2) == 1 then
      shape.y = -shape:height()
    else
      shape.y = floatyshapes.maxY()
    end
  else -- left or right
    shape.y = math.random(0, love.graphics.getHeight() - shape:height())
    if math.random(2) == 1 then
      shape.x = -shape:width()
    else
      shape.x = floatyshapes.maxX()
    end
  end

  shape.speed = math.random(2, 10)
  shape.dx = floatyshapes.randomDestX() - shape.x
  shape.dy = floatyshapes.randomDestY() - shape.y
  shape.colour = floatyshapes.randomColour()
end

--------------------------------------------------

function floatyshapes.newCircle() -- todo
  local self = {}

  self.w = math.random(floatyshapes.maxSize/3, floatyshapes.maxSize)
  self.h = math.random(floatyshapes.maxSize/3, floatyshapes.maxSize)

  self.points = {
    0, 0,
    0, self.h,
    self.w, self.h,
    self.w, 0,
  }

  function self:width()
    return self.w
  end

  function self:height()
    return self.h
  end

  function self:draw()
    love.graphics.setColor(self.colour[1], self.colour[2], self.colour[3])
    love.graphics.polygon('fill', {
      self.x + self.points[1], self.y + self.points[2], 
      self.x + self.points[3], self.y + self.points[4], 
      self.x + self.points[5], self.y + self.points[6], 
      self.x + self.points[7], self.y + self.points[8], 
    })
  end

  floatyshapes.initShape(self)

  return self
end
function floatyshapes.newRectangle()
  local self = {}

  self.w = math.random(floatyshapes.maxSize/3, floatyshapes.maxSize)
  self.h = math.random(floatyshapes.maxSize/3, floatyshapes.maxSize)

  self.points = {
    0, 0,
    0, self.h,
    self.w, self.h,
    self.w, 0,
  }

  function self:width()
    return self.w
  end

  function self:height()
    return self.h
  end

  function self:draw()
    love.graphics.setColor(self.colour[1], self.colour[2], self.colour[3])
    love.graphics.polygon('fill', {
      self.x + self.points[1], self.y + self.points[2], 
      self.x + self.points[3], self.y + self.points[4], 
      self.x + self.points[5], self.y + self.points[6], 
      self.x + self.points[7], self.y + self.points[8], 
    })
  end

  floatyshapes.initShape(self)

  return self
end

--------------------------------------------------

function floatyshapes.newTriangle()
  local self = {}
  self.points = {
    math.random(0, floatyshapes.maxSize), 0, 
    0, math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), 
    math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), math.random(floatyshapes.maxSize/3, floatyshapes.maxSize), 
  }

  function self:width()
    return math.max(self.points[1], self.points[5])
  end

  function self:height()
    return math.max(self.points[4], self.points[6])
  end

  function self:draw()
    love.graphics.setColor(self.colour[1], self.colour[2], self.colour[3])
    love.graphics.polygon('fill', {
      self.x + self.points[1], self.y + self.points[2], 
      self.x + self.points[3], self.y + self.points[4], 
      self.x + self.points[5], self.y + self.points[6], 
    })
  end

  floatyshapes.initShape(self)
  return self
end

--------------------------------------------------

function love.load()
  love.mouse.setVisible(false)	
end

function love.update(dt)
  local scale = 0.1
  for i, shape in ipairs(floatyshapes.shapes) do
    if floatyshapes.inbounds(shape) then
      shape.x = shape.x + shape.speed*shape.dx*dt*scale
      shape.y = shape.y + shape.speed*shape.dy*dt*scale
    else 
      table.remove(floatyshapes.shapes, i)
    end
  end
  --print(#floatyshapes.shapes)
end

function love.draw()
  for i, shape in ipairs(floatyshapes.shapes) do
    shape:draw()
  end
end

function love.keypressed(k)
  floatyshapes.spawnShape()
end
