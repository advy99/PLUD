require("game_object")


Player = {}

function Player:new (obj)
	obj = GameObject:new(obj)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:new (x, y, color)
	obj = GameObject:new(x, y, 50, 50, 500, color)
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
   love.graphics.circle("fill", self.x + self.width/2, self.y, self.width/2)

	love.graphics.setColor(1, 1, 1)
	love.graphics.circle("fill", self.x + self.width/4, self.y - self.width/4, self.width/10)
	love.graphics.circle("fill", self.x + 3 * self.width/4, self.y - self.width/4, self.width/10)

end
