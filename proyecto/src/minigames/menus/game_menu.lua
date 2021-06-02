require("src/minigames/menus/menu")
local class = require "lib/middleclass"


GameMenu = Menu:subclass('GameMenu')

function GameMenu:initialize()

	Menu.initialize(self, "level_title")

end


function GameMenu:update(dt)

	Menu.update(self, dt)

end


function GameMenu:draw()
	love.graphics.setColor(1, 1, 1)
	Menu.draw(self)


	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function GameMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function GameMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
