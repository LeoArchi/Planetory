require 'astre'

function love.load()
  sun = Astre:newAstre("Sun", 80, 0)

  mercury = Astre:newAstre("Mercury", 15, 150, sun)

  venus = Astre:newAstre("Venus", 23, 300, sun)

  earth = Astre:newAstre("Earth", 25, 500, sun)
  moon = Astre:newAstre("Moon", 5, 50, earth)

  fps = nil
  scale = 1
end

function love.update(dt)

  if fpsTimeBuffer == nil or fpsTimeBuffer >=1 then
    fpsTimeBuffer = 0
    fps = math.floor(1/dt)
  else
    fpsTimeBuffer = fpsTimeBuffer + dt
  end

  Astre:update(dt)
end

function love.wheelmoved(x, y)
    if y > 0 and scale<3 then
        -- Mouse wheel moved up
        scale = scale + 0.1
    elseif y < 0 and scale>0 then
        -- Mouse wheel moved down
        scale = scale - 0.1
    end
end

function love.draw()

  love.graphics.print("FPS  : " .. fps, 10, 10)
  love.graphics.print("ZOOM : " .. scale, 10, 25)
  Astre:draw()

  --Astre:drawHierarchy(10, 10)

end
