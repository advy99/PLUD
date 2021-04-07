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

	-- Si algun color no esta en el rango [0, 1] (nos lo dan entre [0,255])
	-- lo ponemos en [0, 1]
	if obj.r > 1 then
		obj.r = obj.r / 255
	end

	if obj.g > 1 then
		obj.g = obj.g / 255
	end

	if obj.b > 1 then
		obj.b = obj.b / 255
	end

	setmetatable(obj, self)
	self.__index = self
	return obj
end

function ColorRGB:changeColor(r, g, b)
	self.r = r
	self.g = g
	self.b = b
end


local index = {
    red = ColorRGB:new(255, 0, 0),
    orange = ColorRGB:new(255, 119, 0),
    yellow = ColorRGB:new(255, 250, 0),
    green = ColorRGB:new(0, 255, 0),
    blue = ColorRGB:new(0, 0, 255),
    purple = ColorRGB:new(187, 0, 255),
    pink = ColorRGB:new(255, 0, 187),
    redorange = ColorRGB:new(255, 46, 0),
    orangeyellow = ColorRGB:new(255, 157, 0),
    yellowgreen = ColorRGB:new(221, 255, 0),
    aqua = ColorRGB:new(0, 255, 153),
    brightblue = ColorRGB:new(0, 178, 255),
    violetblue = ColorRGB:new(0, 42, 255),
    darkgreen = ColorRGB:new(9, 119, 7),
    teal = ColorRGB:new(7, 119, 117),
    navyblue = ColorRGB:new(3, 27, 76),
    darkred = ColorRGB:new(112, 6, 6),
    brown = ColorRGB:new(94, 18, 4),
    apricot = ColorRGB:new(229, 127, 66),
    white = ColorRGB:new(255, 255, 255),
    lightgray = ColorRGB:new(98, 198, 198),
    grey = ColorRGB:new(132, 132, 132),
    mediumgrey = ColorRGB:new(94, 94, 94),
    darkgrey = ColorRGB:new(53, 53, 53),
    black = ColorRGB:new(0, 0, 0)
}


Color = function(color)
    return index[color]
end
