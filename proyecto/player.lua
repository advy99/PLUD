require("game_object")

Player = GameObject:new()


function Player:newPlayer(world, x, y)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.x_speed = 1000
	obj.y_speed = 1000
	obj.body:setMass(1)
	obj.jumping = true
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)
	self.body:applyForce(self.x_speed * dir_x, self.y_speed * -dir_y)
end

function Player:jump()
	if not self.jumping then
		self.jumping = true
		self.body:applyLinearImpulse(0, -500)
	end
end

function Player:update(dt)
	self.jumping = self:checkIfJumping()
	_, y = self.body:getLinearVelocity()
end

function iguales(x, y)
	return math.abs(y - x) < 0.005
end

function Player:checkIfJumping()
	_, y = self.body:getLinearVelocity()

	return not iguales(y, 0)
end

function Player:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
