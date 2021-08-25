require 'astre'
require 'gui'

function love.load()
  sun = Astre:newAstre("Sun", 65, 0, nil, "#fcba03")

  mercury = Astre:newAstre("Mercury", 15, 150, sun, "#615945")

  venus = Astre:newAstre("Venus", 23, 260, sun, "#f7d574")

  earth = Astre:newAstre("Earth", 25, 370, sun, "#26a1ff")
  moon = Astre:newAstre("Moon", 5, 50, earth, "#a8a8a8")

  mars = Astre:newAstre("Mars", 18, 470, sun, "#f04705")

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

  -- Dessin des astres
  Astre:draw()
  --Astre:drawHierarchy(10, 10)

  -- Dessin du GUI
  Gui:draw()

end
