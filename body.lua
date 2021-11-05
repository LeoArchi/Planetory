local _focusedBody
local allBodies = {}
local _cursorOnBody

local function _getCoordonnees(angle, distance, reference)

  local _coordonnees = {}

  _coordonnees.x = math.cos(angle * math.pi / 180) * distance + reference.x
  _coordonnees.y = math.sin(angle * math.pi / 180) * distance + reference.y

  return _coordonnees
end

local function _updateAngle(angle, dt, distance)
  local _angle = angle - dt * 1/distance * 100 * TIME_SPEED

  if _angle <= 0 then
    _angle = 360 - _angle
  end

  return _angle
end

local function _inverseAngle(angle)
  local _angle = angle + 180

  if _angle <= 0 then
    _angle = 360 - _angle
  end

    return _angle
end

local function _convertHexColor(r, g, b, aplha)
  return r/255, g/255, b/255, aplha
end

local function _updateChildren(dt, body, bufferedChild)
  for childName, child in pairs(body.children) do

    if child ~= bufferedChild or bufferedChild == nil then

      child.angleWithParent = _updateAngle(child.angleWithParent, dt, child.distanceFromParent)
      local _coordonnees = _getCoordonnees(child.angleWithParent, child.distanceFromParent, body)

      child.x = _coordonnees.x
      child.y = _coordonnees.y

      body.children[childName] = child

      if tablelength(child.children) > 0 then
        _updateChildren(dt, child)
      end

    end
  end
end

local function _updateParents(dt, body)

  if body.parent ~= nil then

    -- Calculer position du parent
    body.angleWithParent = _updateAngle(body.angleWithParent, dt, body.distanceFromParent)
    local _coordonnees = _getCoordonnees(_inverseAngle(body.angleWithParent), body.distanceFromParent, body)

    body.parent.x = _coordonnees.x
    body.parent.y = _coordonnees.y

    -- Calculer position de tous les enfants (et les enfants...) du parent SAUF le corps actuel (body)
    bufferedChild = body
    _updateChildren(dt, body.parent, bufferedChild)

    -- On calcule la position du parent du parent actuel
    _updateParents(dt, body.parent)

  end

end

Body = {

  new = function(name, color, radius, parent, distance)
    local _body = {}
    _body.name = name
    _body.radius = radius
    _body.children = {}
    _body.color = color

    if _focusedBody == nil then
      _focusedBody = _body
      _body.x = CENTER.x
      _body.y = CENTER.y
    end

    if parent ~= nil then

      parent.children[_body.name] = _body

      _body.parent = parent
      _body.distanceFromParent = distance
      _body.angleWithParent = math.random(0,359)

    end

    table.insert(allBodies, _body)

    return _body

  end,

  setFocus = function(body)
    _focusedBody = body
    _focusedBody.x = CENTER.x
    _focusedBody.y = CENTER.y
  end,

  getFocusedBody = function()
    return _focusedBody
  end,

  getCursonOn = function()
    return _cursorOnBody
  end,

  update = function(dt)

    _focusedBody.x = CENTER.x
    _focusedBody.y = CENTER.y

    _updateChildren(dt, _focusedBody)
    _updateParents(dt, _focusedBody)

    _cursorOnBody = nil

    for index, body in ipairs(allBodies) do
      local _distance = math.sqrt(math.pow(love.mouse.getX()/ZOOM-body.x, 2) + math.pow(love.mouse.getY()/ZOOM-body.y, 2))


      -- OLD if _distance <= body.radius then
      -- Si la souris se trouve dans la "hitbox" fixe de l'astre OU  dans l'astre lui même, ALORS il est focus
      if _distance <= 10/ZOOM or _distance <= body.radius then
        _cursorOnBody = body
      end
    end
  end,



  draw = function()

    love.graphics.setColor(1,1,1)

    love.graphics.push()

    -- Application de la rotation
    love.graphics.translate(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
  	love.graphics.rotate(GLOBAL_ANGLE * math.pi / 180)
  	love.graphics.translate(-SCREEN_WIDTH/2, -SCREEN_HEIGHT/2)

    -- Application du Zoom
    love.graphics.scale(ZOOM, ZOOM)

    for index, body in ipairs(allBodies) do

      if body.parent ~= nil then
        love.graphics.setColor(1,1,1, 0.5)
        love.graphics.circle('line', body.parent.x, body.parent.y, body.distanceFromParent, 256)
      end

      -- On dessine la planète
      love.graphics.setColor(_convertHexColor(body.color.r, body.color.g, body.color.b, 1))
      love.graphics.circle("fill", body.x, body.y, body.radius, 32)

      -- On dessine la "hitbox"
      love.graphics.setColor(_convertHexColor(body.color.r, body.color.g, body.color.b, 0.5))
      love.graphics.circle("fill", body.x, body.y, 10/ZOOM, 32)

    end

    love.graphics.pop()

  end

}



return Body
