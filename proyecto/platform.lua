require("game_object")


Platform = GameObject:new()

function Platform:new (obj)
	obj = obj or GameObject:new(obj)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Platform:new (x, y, width, height, color)
	obj = GameObject:new(x, y, width, height, 0, false, color)
	setmetatable(obj, self)
	self.__index = self
	return obj
end


-- function Platform:load()
--   self.x = 50
--   self.y = love.graphics.getHeight() / 2
-- end

function Platform:update(dt)
  -- self:move(dt)
end

function Platform:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b)

 	love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)
end
