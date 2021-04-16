require("game_object")
require("constants")

Player = GameObject:new()


function Player:newPlayer(world, x, y, id)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.fixture:setUserData(id)
	obj.x_speed = 1000
	obj.y_speed = 1000
	obj.body:setMass(1)
	obj.mode = "jumping"
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)
	self.body:applyForce(self.x_speed * dir_x, self.y_speed * -dir_y)
end

function Player:jump()
	if self.mode ~= "jumping" then
		self.mode = "jumping"
		self.body:applyLinearImpulse(0, -500)
	end
end

function Player:setMode(mode)
	self.mode = mode
end

function Player:getMode()
	return self.mode
end

function Player:update(dt)
	print("Modo del jugador: ", self.mode)
end

function Player:draw()
	love.graphics.setColor(1, 1, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

	if Constants.DEBUG then
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end
end
