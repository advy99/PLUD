require("game_object")

Player = GameObject:new()


function Player:newPlayer(world, x, y, id)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setCategory(1)
	obj.fixture:setUserData(id)
	obj.x_speed = 1000
	obj.y_speed = 1000
	obj.body:setMass(1)
	obj.jumping = true
	obj.grounded = false
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)
	self.body:applyForce(self.x_speed * dir_x, self.y_speed * -dir_y)
end

function Player:jump()
	if not self.jumping and self.grounded then
		self.jumping = true
		self.grounded = false
		self.body:applyLinearImpulse(0, -500)
	end
end

function Player:endJump()
	self.jumping = false
	self.grounded = true
end

function Player:update(dt)

end

function Player:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
