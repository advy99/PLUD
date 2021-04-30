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

	obj.width = width
	obj.height = height
	obj.shapes = {}
	obj.shapes[0] = love.physics.newRectangleShape(width, height)

	obj.fixtures = {}
	obj.fixtures[0] = love.physics.newFixture(obj.body, obj.shapes[0], 1)

	obj.fixtures[0]:setFriction(0.8)

	obj.number_fixtures = 1

	setmetatable(obj, self)
	self.__index = self

	return obj
end


-- function Platform:load()
--   self.x = 50
--   self.y = love.graphics.getHeight() / 2
-- end

function Platform:addSensor(position)
	-- +1 and -1 in shape width to avoid lateral collisions
	-- up by default
	local sensor_x1, sensor_y1, sensor_x2, sensor_y2 = -self.width / 2 + 1, -self.height / 2, self.width / 2 - 1, -self.height / 2

	if position == "down" then
		sensor_x1, sensor_y1, sensor_x2, sensor_y2 = -self.width / 2 + 1, self.height / 2, self.width / 2 - 1, self.height / 2
	elseif position == "left" then
		sensor_x1, sensor_y1, sensor_x2, sensor_y2 = -self.width / 2, (-self.height / 2) + 1 , -self.width / 2, (self.height / 2) - 1
	elseif position == "right" then
		sensor_x1, sensor_y1, sensor_x2, sensor_y2 = self.width / 2, (-self.height / 2) + 1, self.width / 2, (self.height / 2) - 1
	end


	self.shapes[self.number_fixtures] = love.physics.newEdgeShape(sensor_x1, sensor_y1, sensor_x2, sensor_y2)
	self.fixtures[self.number_fixtures] = love.physics.newFixture(obj.body, obj.shapes[self.number_fixtures], 1)
	self.fixtures[self.number_fixtures]:isSensor(true)

	self.fixtures[self.number_fixtures]:setCategory(Constants.PLATFORM_CATEGORY)
	-- self.fixtures[self.number_fixtures]:setUserData(id)

	obj.fixtures[self.number_fixtures]:setFriction(0.8)

	self.number_fixtures = self.number_fixtures + 1

end

function Platform:update(dt)
  -- self:move(dt)
end

function Platform:draw()
	love.graphics.setLineWidth( 1 )
	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shapes[0]:getPoints()))

	if Constants.SHOW_HITBOX then
		love.graphics.setLineWidth( 1 )
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shapes[0]:getPoints()))

		for i = 1, self.number_fixtures - 1, 1
		do
			love.graphics.setLineWidth( 2 )
			love.graphics.setColor(0, 0, 1) -- set the drawing color to blue for the sensor
			love.graphics.line(self.body:getWorldPoints(self.shapes[i]:getPoints()))
		end
	end
end
