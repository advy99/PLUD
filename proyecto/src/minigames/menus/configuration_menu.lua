require("src/minigames/menus/menu")
local class = require "lib/middleclass"


ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function ConfigurationMenu:initialize()
	Menu.initialize(self, "level_config")

end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

end


function ConfigurationMenu:draw()
	love.graphics.setColor(1, 1, 1)
	Menu.draw(self)

	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function ConfigurationMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ConfigurationMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
