-- La table "Astre" correspond à l'objet astre, qui contiendra le constructeur, les getters, etc...
Astre = {}

-- il s'agit ici de la liste des astre qui ne doit pas être exposée hors du fichier
local astres = {"COUCOU", "TEST"}

-- Le getter de la liste des astres
function Astre:newAstre(name, radius, posX, posY)
  astre = {}
  astre.name = name
  astre.radius = radius
  astre.posX = posX
  astre.posY = posY

  table[name] = astre
end

-- Le getter de la liste des astres
function Astre:getAstres()
  return astres
end
