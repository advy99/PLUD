ColorRGB = {}

function ColorRGB:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function ColorRGB:new (r, g, b)
	obj = {}
	obj.r = r or 255
	obj.g = g or 255
	obj.b = b or 255
	setmetatable(obj, self)
	self.__index = self
	return obj
end
