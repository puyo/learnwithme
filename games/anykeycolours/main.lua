function love.load()
    love.mouse.setVisible(false)	
end

function love.keypressed(k)
    love.graphics.setBackgroundColor(math.random(255), math.random(255), math.random(255))
end
