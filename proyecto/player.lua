require("color_rgb")

Player = {}

function Player:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:new (x, y, color)
	obj = {}
	obj.x = x
	obj.y = y
	obj.width = 20
	obj.height = 100
	obj.speed = 500
	obj.color = color or ColorRGB:new()
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

function Player:move(move, dt)      -- Move the player if it is inside the screen boundaries
  if move == -1 and self.x > 0 then
    self.x = self.x - self.speed * dt
 elseif move == 1 and self.x + self.width < love.graphics.getWidth() then
    self.x = self.x + self.speed * dt
  end
end

function Player:jump()

end

function Player:draw()
	love.graphics.setColor(self.color.r, self.color.g, self.color.b)
 	love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)
end
