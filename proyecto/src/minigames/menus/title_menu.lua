require("src/minigames/menus/menu")
local class = require "lib/middleclass"


TitleMenu = Menu:subclass('TitleMenu')

function TitleMenu:initialize(num_players)

	Menu.initialize(self, "level_title", num_players)

	local game_name_image = love.graphics.newImage("img/lose_to_win_animated.png")
	self.sprite_width = 3000
	self.sprite_height = 2600
	self.title_animation = newAnimation(game_name_image, 0, self.sprite_width, self.sprite_height, 1)


end


function TitleMenu:update(dt)

	Menu.update(self, dt)

	self.title_animation.currentTime = (self.title_animation.currentTime + dt) % self.title_animation.duration


end


function TitleMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	local quad = math.floor(self.title_animation.currentTime / self.title_animation.duration * #self.title_animation.quads) + 1

	love.graphics.draw(self.title_animation.spriteSheet, self.title_animation.quads[quad], 480, 70, 0, 0.1, 0.1 )

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
