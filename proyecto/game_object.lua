require("color_rgb")

GameObject = {}

function GameObject:new (obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function GameObject:new (x, y, width, height, speed, has_gravity, color)
	obj = {}
	obj.x = x
	obj.y = y
	obj.width = width
	obj.height = height
	obj.speed = speed
	obj.has_gravity = has_gravity
	obj.color = color
	obj.mass = 50
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
