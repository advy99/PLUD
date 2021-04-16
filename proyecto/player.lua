require("game_object")
require("constants")

Player = GameObject:new()


function Player:newPlayer(world, x, y, id)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.fixture:setUserData(id)
	obj.x_speed = 500
	obj.jump_power = 500
	obj.max_speed = 500
	obj.body:setMass(1)
	obj.mode = "jumping"
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)

	if Constants.DEBUG then
		x, y = self.body:getLinearVelocity()
		print(x, "\t", y)
	end

	x, y = self.body:getLinearVelocity()
	self.body:applyForce(self.x_speed * dir_x, 0)

	if ( math.abs(x) > self.max_speed ) then
		self.body:setLinearVelocity(self.max_speed * dir_x, y)
	end

end

function Player:jump()
	if self.mode ~= "jumping" then
		self.mode = "jumping"
		x, _ = self.body:getLinearVelocity()
		self.body:setLinearVelocity(x, 0)
		self.body:applyLinearImpulse(0, -self.jump_power)
	end
end

function Player:setMode(mode)
	self.mode = mode
end

function Player:getMode()
	return self.mode
end

function Player:update(dt)
	if Constants.DEBUG then
		print("Modo del jugador ", self.fixture:getUserData() ," : ", self.mode)
	end
end

function Player:draw()
	love.graphics.setLineWidth( 1 )
	love.graphics.setColor(1, 1, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

	if Constants.SHOW_HITBOX then
		love.graphics.setLineWidth( 1 )
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end
end
