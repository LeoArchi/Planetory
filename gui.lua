Gui = {}

local buttons = {}
buttons[1] = {Nom="Pause"}
buttons[2] = {Nom="Play"}

local function _drawControlBar(startX, startY, buttonSize)

  local offset = 0

  for key, value in pairs(buttons) do
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", startX + offset, startY, buttonSize, buttonSize, buttonSize*0.1, buttonSize*0.1, 16)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("line", startX + offset, startY, buttonSize, buttonSize, buttonSize*0.1, buttonSize*0.1, 16)

    offset = offset + buttonSize + 10
  end
end

function Gui:draw()
  love.graphics.setColor(1, 1, 1)

  love.graphics.print("FPS  : " .. fps, 10, 10)
  love.graphics.print("ZOOM : " .. scale, 10, 25)

  _drawControlBar(20, love.graphics.getHeight()-120, 100)

end
