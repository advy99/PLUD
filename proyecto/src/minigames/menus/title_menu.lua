require("src/minigames/menus/menu")
local class = require "lib/middleclass"


TitleMenu = Menu:subclass('TitleMenu')

function TitleMenu:initialize(num_players)

	Menu.initialize(self, "level_title", num_players)

	self.lose_to_image = love.graphics.newImage("img/lose_to.png")
	self.lose_to_rotation = 0
	self.win_image = love.graphics.newImage("img/win.png")
	self.win_rotation = 0

	self.rotation_speed = 0.4
	self.MAX_ROTATION = math.rad(5)


end


function TitleMenu:update(dt)

	Menu.update(self, dt)

	self.lose_to_rotation = self.lose_to_rotation + self.rotation_speed * dt
	self.win_rotation = self.win_rotation - self.rotation_speed * dt

	if self.lose_to_rotation > self.MAX_ROTATION or self.win_rotation > self.MAX_ROTATION then
		self.rotation_speed = -self.rotation_speed
	end


end


function TitleMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

 	love.graphics.draw(self.lose_to_image, 480 + self.lose_to_image:getWidth()/2 * 0.1, 70, self.lose_to_rotation, 0.1, 0.1, self.lose_to_image:getWidth()/2, 0)
	love.graphics.draw(self.win_image, 480 + self.win_image:getWidth()/2 * 0.1, 200, self.win_rotation, 0.1, 0.1, self.win_image:getWidth()/2, 0)


end

function TitleMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function TitleMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function TitleMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)
end

function TitleMenu:handleInternalEvent(event)
	Menu.handleInternalEvent(self, event)


end
