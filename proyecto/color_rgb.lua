ColorRGB = {}

function ColorRGB:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function ColorRGB:new (r, g, b)
	obj = {}
	obj.r = r or 1
	obj.g = g or 1
	obj.b = b or 1
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function ColorRGB:changeColor(r, g, b)
	self.r = r
	self.g = g
	self.b = b
end
