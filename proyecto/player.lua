require("game_object")


Player = GameObject:new()

function Player:new (obj)
	obj = obj or GameObject:new(obj)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:new (x, y, color)
	obj = GameObject:new(x, y, 50, 50, 500, true, color)
	setmetatable(obj, self)
	self.__index = self
	return obj
end


-- function Player:load()
--   self.x = 50
--   self.y = love.graphics.getHeight() / 2
-- end

function Player:update(dt)
  -- self:move(dt)
end

function Player:jump()

end

function Player:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b)

 	love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)
   love.graphics.circle("fill", self.x + self.width/2, self.y, self.width/2)

	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("fill", self.x + self.width/4, self.y - self.width/4, self.width/10)
	love.graphics.circle("fill", self.x + 3 * self.width/4, self.y - self.width/4, self.width/10)

end
