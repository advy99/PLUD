require("src/minigames/minigame")
local class = require "lib/middleclass"


Menu = MiniGame:subclass('Menu')

function Menu:initialize(level_name)

	MiniGame.initialize(self, level_name)

	self.game_name_image = love.graphics.newImage("img/lose_to_win.png")

end


function Menu:update(dt)

	MiniGame.update(self, dt)

end


function Menu:draw()
	love.graphics.setColor(1, 1, 1)
	MiniGame.draw(self)


	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function Menu:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function Menu:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

end

function Menu:mouseMoved(x, y)
	MiniGame.mouseMoved(self, x, y)
end
