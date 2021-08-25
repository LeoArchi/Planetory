require 'astre'

function love.load()
  Astre.newAstre("Sun", 70, love.graphics.getWidth()/2, love.graphics.getHeight()/2)
end


function love.update(dt)

end

function love.draw()

  for astreName, astre in pairs(Astre:getAstres()) do
    love.graphics.circle("fill", astre.posX, astre.posY, astre.radius, 32)
  end

end

function newAstre(name, mass, radius, distanceFromParent, parent)

  local astre = {}
  astre.name = name
  astre.mass = mass
  astre.radius = radius
  astre.distanceFromParent = distanceFromParent
  astre.satellites = {}

 -- Si l'astre parent est renseigné, alors ajouter l'astre actuel à la liste des satellites du parent
  if parent ~= nil then
    table.insert(parent.satellites, astre)
  end

  -- On ajoute l'astre actuel à la liste des astres
  astres[name] = astre

  return astre
end
