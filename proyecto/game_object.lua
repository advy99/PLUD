--
-- Clase GameObject
-- Todos los objetos serán un GameObject
--
--



GameObject = {}

--
-- Creacion de la tabla vacia, para las clases base es necesario tener este
-- constructor, pero nunca se utilizará
--
function GameObject:new()
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

--
-- Constructor de GameObject
-- Necesitamos el mundo donde estará el objeto, y las posiciones x e y para
-- asignarle su body.
-- También tendrá un tipo que podrá ser "static" o "dynamic" para saber si
-- el objeto es estatico o dinámico
--
function GameObject:newGameObject(world, x, y, type)
	obj = {}
	obj.body = love.physics.newBody(world, x, y, type)
	obj.x_speed = 0
	obj.y_speed = 0
	setmetatable(obj, self)
	self.__index = self
	return obj
end
