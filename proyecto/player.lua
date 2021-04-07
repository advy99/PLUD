require("game_object")

Player = GameObject:new()


function Player:newPlayer(world, x, y)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.x_speed = 1000
	obj.y_speed = 380
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)
	self.body:applyForce(self.x_speed * dir_x, self.y_speed * -dir_y)
end

function Player:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
