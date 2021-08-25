require 'astre'

function love.load()
  sun = Astre:newAstre("Sun", 80, 0)
  earth = Astre:newAstre("Earth", 25, 500, sun)
  venus = Astre:newAstre("Venus", 23, 300, sun)
end

function love.update(dt)
  Astre:update(dt)
end

function love.draw()
  --Astre:drawHierarchy(10, 10)
  Astre:draw()
end
