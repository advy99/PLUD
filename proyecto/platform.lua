require("game_object")


Platform = GameObject:new()

function Platform:new (obj)
	obj = obj or GameObject:new(obj)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Platform:newPlatform(world, x, y, width, height)
	obj = GameObject:newGameObject(world, x, y , "static")
	obj.shape = love.physics.newRectangleShape(width, height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
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
	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
