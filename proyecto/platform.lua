require("game_object")
require("constants")

Platform = GameObject:new()

function Platform:new (obj)
	obj = obj or GameObject:new(obj)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Platform:newPlatform(world, x, y, width, height, id)
	obj = GameObject:newGameObject(world, x, y , "static")
	obj.shape = love.physics.newRectangleShape(width, height)

	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)

	-- +1 and -1 in shape width to avoid lateral collisions
	obj.sensor_shape = love.physics.newEdgeShape(-width / 2 + 1, -height / 2, width / 2 - 1, -height / 2)
	obj.sensor = love.physics.newFixture(obj.body, obj.sensor_shape, 1)
	obj.sensor:isSensor(true)

	obj.sensor:setCategory(Constants.PLATFORM_CATEGORY)
	obj.sensor:setUserData(id)
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

	if Constants.DEBUG then
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
		love.graphics.setColor(0, 0, 1) -- set the drawing color to blue for the sensor
		love.graphics.line(self.body:getWorldPoints(self.sensor_shape:getPoints()))
	end
end
