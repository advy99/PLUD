require("game_object")

Player = GameObject:new()


function Player:newPlayer(world, x, y)
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	obj.shape = love.physics.newRectangleShape(50, 50)
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setRestitution(1)
	setmetatable(obj, self)
	self.__index = self
	return obj
end


-- function Player:load()
--   self.x = 50
--   self.y = love.graphics.getHeight() / 2
-- end

function Player:update(dt)
  -- self:move(dt)
end

function Player:jump()

end

function Player:draw()
	love.graphics.setColor(1, 0, 0)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
