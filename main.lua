Body = require("body")
HUD  = require("hud")

TIME_SPEED = 1
ZOOM = 0.05
GLOBAL_ANGLE = 0

SCREEN_WIDTH = love.graphics.getWidth()
SCREEN_HEIGHT = love.graphics.getHeight()

CENTER = {}
CENTER.x = SCREEN_WIDTH / ZOOM /2
CENTER.y = SCREEN_HEIGHT / ZOOM /2



function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function love.load()

  math.randomseed(os.time())

  --http://www.astrosurf.com/borealis/distances.html

  sun = Body.new("Sun", {r=255, g=196, b=0}, 500)

  mercury = Body.new("Mercury", {r=173, g=173, b=173}, 45, sun, 2000)
  venus = Body.new("Venus", {r=255, g=238, b=161}, 65, sun, 3500)
  earth = Body.new("Earth", {r=0, g=140, b=255}, 70, sun, 5000)
  moon = Body.new("Moon", {r=130, g=130, b=130}, 15, earth, 300)
  mars = Body.new("Mars", {r=255, g=99, b=15}, 55, sun, 7500)

  jupiter = Body.new("Jupiter", {r=255, g=227, b=186}, 550, sun, 26000)
  saturn = Body.new("Saturn", {r=255, g=242, b=186}, 500, sun, 47500)
  uranus = Body.new("Uranus", {r=201, g=255, b=228}, 300, sun, 95000)
  neptune = Body.new("Neptune", {r=66, g=135, b=245}, 250, sun, 150000)

  Body.setFocus(sun)

  timer = 0

  background = love.graphics.newImage("images/space.png")

  theme = love.audio.newSource("sounds/Kevin MacLeod - Impact Lento.mp3", "stream")
  theme:setVolume(0.4)
  theme:play()

  --font = love.graphics.newFont("fonts/BondiFont/Bondi.otf", 20)
  mainFont = love.graphics.newFont(12)
  love.graphics.setFont(mainFont)

end


function love.update(dt)

  Body.update(dt)
end

function love.draw()

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(background, 0, 0, 0, 1/(background:getWidth()/SCREEN_WIDTH), 1/(background:getHeight()/SCREEN_HEIGHT))

  Body.draw()
  HUD.draw()

end



-- CLAVIER ET SOURIS

function love.keypressed(key, scancode, isrepeat)
  if key == "pageup" then
    TIME_SPEED = TIME_SPEED *2
  elseif key == "pagedown" then
    TIME_SPEED = TIME_SPEED/2
  end
end

function love.wheelmoved(x, y)

  local _zoomIncrement = 1.1

    if y > 0 then
      ZOOM = ZOOM *_zoomIncrement
    elseif y < 0 then
      ZOOM = ZOOM/_zoomIncrement
    end

    if ZOOM < 0.003 then
      ZOOM = 0.003
    elseif ZOOM > 0.65 then
      ZOOM = 0.65
    end

    CENTER.x = SCREEN_WIDTH / ZOOM /2
    CENTER.y = SCREEN_HEIGHT / ZOOM /2
end

local lastclick = 0
local clickInterval = 0.1 --Number of seconds between double clicks

function love.mousepressed(x,y,button)
    if button == 1 then --Left click
        local time = os.time()
        if time <= lastclick + clickInterval then
            --Double click
            local _bodyUnderCursor = Body.getCursonOn()
            if _bodyUnderCursor ~= nil then
              print(_bodyUnderCursor.name)
              Body.setFocus(_bodyUnderCursor)
            end
        else
            lastclick = time
        end
    end
end

function love.mousemoved( x, y, dx, dy, istouch )
	if love.mouse.isDown(2) then
    print("RORATE")

    local _relativeX = CENTER.x - x
    local _relativeY = CENTER.y - y

    local angleToCenter = math.atan2(_relativeY, _relativeX) * 180/ math.pi

    --GLOBAL_ANGLE = angleToCenter
  end
end
