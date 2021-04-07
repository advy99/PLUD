GameObject = {}

function GameObject:new()
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function GameObject:newGameObject(world, x, y, type)
	obj = {}
	obj.body = love.physics.newBody(world, x, y, type)
	obj.x_speed = 0
	obj.y_speed = 0
	setmetatable(obj, self)
	self.__index = self
	return obj
end
