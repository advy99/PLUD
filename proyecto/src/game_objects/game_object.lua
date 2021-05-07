--
-- Clase GameObject
-- Todos los objetos serán un GameObject
--
--

local class = require "lib/middleclass"

GameObject = class("GameObject")


--
-- Constructor de GameObject
-- Necesitamos el mundo donde estará el objeto, y las posiciones x e y para
-- asignarle su body.
-- También tendrá un tipo que podrá ser "static" o "dynamic" para saber si
-- el objeto es estatico o dinámico
--
function GameObject:initialize(world, x, y, type)
	self.body = love.physics.newBody(world, x, y, type)
	self.x_speed = 0
	self.y_speed = 0
end
