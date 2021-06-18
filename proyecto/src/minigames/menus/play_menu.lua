require("src/minigames/menus/menu")
local class = require "lib/middleclass"


PlayMenu = Menu:subclass('PlayMenu')

function PlayMenu:initialize(num_players)

	Menu.initialize(self, "level_play", num_players)

end


function PlayMenu:update(dt)

	Menu.update(self, dt)

end


function PlayMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

end

function PlayMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function PlayMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function PlayMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)
end

function PlayMenu:handleInternalEvent(event)
	Menu.handleInternalEvent(self, event)


end
