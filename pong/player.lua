Player = {}

function Player:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:new (x, y)
	obj = {}
	obj.x = x
	obj.y = y
	obj.width = 20
	obj.height = 100
	obj.speed = 500
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
  if move == 1 and self.y > 0 then
    self.y = self.y - self.speed * dt
 elseif move == -1 and self.y + self.height < love.graphics.getHeight() then
    self.y = self.y + self.speed * dt
  end
end

function Player:draw()
  love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)
end
