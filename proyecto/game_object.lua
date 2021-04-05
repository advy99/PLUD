require("color_rgb")

GameObject = {}

function GameObject:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function GameObject:new (x, y, width, height, speed, color)
	obj = {}
	obj.x = x
	obj.y = y
	obj.width = width
	obj.height = height
	obj.speed = speed
	obj.color = color or ColorRGB:new()
	setmetatable(obj, self)
	self.__index = self
	return obj
end
