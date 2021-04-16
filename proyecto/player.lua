require("game_object")
require("constants")
require("animations")

Player = GameObject:new()


function Player:newPlayer(world, x, y, id)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.width = 40
	obj.height = 50
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.fixture:setUserData(id)
	obj.x_speed = 700
	obj.jump_power = 500
	obj.max_speed = 500
	obj.body:setMass(1)
	obj.mode = "jumping"

	obj.animation = newAnimation(love.graphics.newImage("oldHero.png"), 16, 18, 1)

	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Player:move(dir_x, dir_y)

	self.body:applyForce(self.x_speed * dir_x, 0)

	local x, y = self.body:getLinearVelocity()

	if ( x > self.max_speed ) then
		self.body:setLinearVelocity(self.max_speed, y)
	elseif ( x < -self.max_speed ) then
		self.body:setLinearVelocity(-self.max_speed, y)
	end

	if Constants.DEBUG then
		x, y = self.body:getLinearVelocity()
		print(x, "\t", y)
	end

end

function Player:jump()
	if self.mode ~= "jumping" then
		self.mode = "jumping"
		local x, _ = self.body:getLinearVelocity()
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
	self.animation.currentTime = self.animation.currentTime + dt
	if self.animation.currentTime >= self.animation.duration then
		self.animation.currentTime = self.animation.currentTime - self.animation.duration
	end

	if Constants.DEBUG then
		print("Modo del jugador ", self.fixture:getUserData() ," : ", self.mode)
	end
end

function Player:draw()

	love.graphics.reset()
	local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1

	-- TODO : Change to left or right depending on player orientation
	love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], self.body:getX() - self.width / 2, self.body:getY() - self.height / 2, 0, 3, 3 )

	if Constants.SHOW_HITBOX then
		love.graphics.setLineWidth( 1 )
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end
end
