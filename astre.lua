-- La table "Astre" correspond à l'objet astre, qui contiendra le constructeur, les getters, etc...
Astre = {}

-- il s'agit ici de la liste des astres qui ne doit pas être exposée hors du fichier
local _allAstres = {}

local _globalSpeed = 2

-- Le constructeur
function Astre:newAstre(name, radius, distanceFromParent, parentAstre)
  astre = {}
  astre.name = name
  astre.radius = radius
  astre.satellites = {}
  astre.angle = 0
  astre.speed = _globalSpeed/distanceFromParent
  astre.distanceFromParent = distanceFromParent


  if parentAstre ~= nil then
    astre.focusOn = false
    astre.posX = parentAstre.posX + distanceFromParent
    astre.posY = parentAstre.posY
    parentAstre.satellites[name] = astre
  else
    astre.focusOn = true
    astre.posX = love.graphics.getWidth()/2
    astre.posY = love.graphics.getHeight()/2
    _allAstres[name] = astre
  end

  return astre
end

-- Le getter de la liste des astres
function Astre:getAstres()
  return _allAstres
end

-- Mise à jour de la position des astres
local function _update(dt, astres, parentAstre)
  for astreName, astre in pairs(astres) do
    if parentAstre ~= nil then
      if astre.angle + astre.speed > 2*math.pi then
        astre.angle = 0
      else
        astre.angle = astre.angle + astre.speed -- en radians
      end
      astre.posX = parentAstre.posX + math.cos(astre.angle) * astre.distanceFromParent
      astre.posY = parentAstre.posY - math.sin(astre.angle) * astre.distanceFromParent
    end
    _update(dt, astre.satellites, astre)
  end
end

-- Mise à jour de la position des astres | Fonction exposée à l'extérieur
function Astre:update(dt)
  _update(dt, _allAstres)
end

-- Dessine la hiérarchie des astres avec une indentation
local function _drawHierarchy(astres, offsetX, offsetY)
  local offsetX = offsetX;
  local offsetY = offsetY;

  for astreName, astre in pairs(astres) do
    love.graphics.print(astre.name, 10+offsetX, 10+offsetY)
    offsetY = offsetY + 15
    -- Si j'ai des satellites, je doit aussi boucler sur eux
    _drawHierarchy(astre.satellites, offsetX+10, offsetY)

  end
end

-- Dessine la hiérarchie des astres avec une indentation | Fonction exposée à l'extérieur
function Astre:drawHierarchy(offsetX, offsetY)
  _drawHierarchy(_allAstres, offsetX, offsetY)
end

-- Dessine les astres à leurs positions respectives
local function _draw(astres, parentAstre)
  for astreName, astre in pairs(astres) do

    -- Si j'ai un astre parent, je commence par dessiner l'orbite
    if parentAstre ~= nil then
      love.graphics.circle("line", parentAstre.posX, parentAstre.posY, astre.distanceFromParent, 64)
    end

    -- Je dessine mon astre
    love.graphics.circle("fill", astre.posX, astre.posY, astre.radius, 32)

    _draw(astre.satellites, astre)
  end
end

-- Dessine les astres à leurs positions respectives  | Fonction exposée à l'extérieur
function Astre:draw()
  _draw(_allAstres)
end
