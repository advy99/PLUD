require("src/minigames/menus/menu")
local class = require "lib/middleclass"


PracticeMenu = Menu:subclass('PracticeMenu')

function PracticeMenu:initialize(num_players)

	Menu.initialize(self, "level_practice", num_players)

	self.game_name_image = love.graphics.newImage("img/lose_to_win.png")


end


function PracticeMenu:update(dt)

	Menu.update(self, dt)

end


function PracticeMenu:draw()
	love.graphics.reset()
	Menu.draw(self)


	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function PracticeMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function PracticeMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function PracticeMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)
end

function PracticeMenu:handleInternalEvent(event)
	Menu.handleInternalEvent(self, event)


end
