require("src/minigames/menus/menu")

local class = require "lib/middleclass"

ResultMenu = Menu:subclass('ResultMenu')

function ResultMenu:initialize(num_players)
	Menu.initialize(self, "level_result", num_players)
end


function ResultMenu:update(dt)
	Menu.update(self, dt)
end


function ResultMenu:draw()
	love.graphics.reset()
	Menu.draw(self)
end

function ResultMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ResultMenu:handleEventBetweenObjects(object_a, object_b, event)
	Menu.handleEventBetweenObjects(self, object_a, object_b, event)
end
