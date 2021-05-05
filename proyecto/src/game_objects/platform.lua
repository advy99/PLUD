require("src/game_objects/game_object")
require("src/enums/constants")

Platform = GameObject:subclass('Platform')

function Platform:initialize(world, x, y, width, height, id)
	GameObject.initialize(self, world, x, y , "static")

	self.width = width
	self.height = height
	self.shapes = {}
	self.shapes[0] = love.physics.newRectangleShape(width, height)

	self.fixtures = {}
	self.fixtures[0] = love.physics.newFixture(self.body, self.shapes[0], 1)

	self.fixtures[0]:setFriction(0)

	self.number_fixtures = 1
end

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
	self.fixtures[self.number_fixtures] = love.physics.newFixture(self.body, self.shapes[self.number_fixtures], 1)
	self.fixtures[self.number_fixtures]:isSensor(true)

	self.fixtures[self.number_fixtures]:setCategory(Constants.PLATFORM_CATEGORY)
	-- self.fixtures[self.number_fixtures]:setUserData(id)

	self.fixtures[self.number_fixtures]:setFriction(0.8)

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