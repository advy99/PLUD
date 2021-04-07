require("color_rgb")

GameObject = {}

function GameObject:new()
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function GameObject:newGameObject(world, x, y, type)
	obj = {}
	obj.body = love.physics.newBody(world, x, y, type)
	setmetatable(obj, self)
	self.__index = self
	return obj
end


function GameObject:move(move, dt)      -- Move the Platform if it is inside the screen boundaries
  if move == -1 then
    self.x = self.x - self.speed * dt
 elseif move == 1 then
    self.x = self.x + self.speed * dt
  end
end
