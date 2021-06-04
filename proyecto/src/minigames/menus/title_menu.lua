require("src/minigames/menus/menu")
local class = require "lib/middleclass"


TitleMenu = Menu:subclass('TitleMenu')

function TitleMenu:initialize(num_players)

	Menu.initialize(self, "level_title", num_players)


end


function TitleMenu:update(dt)

	Menu.update(self, dt)

end


function TitleMenu:draw()
	love.graphics.setColor(1, 1, 1)
	Menu.draw(self)


	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

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
