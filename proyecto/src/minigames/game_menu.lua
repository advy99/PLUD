require("src/minigames/minigame")
local class = require "lib/middleclass"


GameMenu = MiniGame:subclass('GameMenu')

function GameMenu:initialize()

	MiniGame.initialize(self, "level_menu")

end


function GameMenu:update(dt)

	MiniGame.update(self, dt)

end


function GameMenu:draw()
	MiniGame.draw(self)

 	mainFont = love.graphics.newFont("fonts/kirbyss.ttf", 50)
	love.graphics.setFont(mainFont)
	love.graphics.printf("JUGAR", -love.graphics.getWidth() * 0.165 ,  love.graphics.getHeight() * 0.73, 1000, "center")
	love.graphics.printf("SALIR", love.graphics.getWidth() * 0.385,  love.graphics.getHeight() * 0.73, 1000, "center")


end

function GameMenu:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function GameMenu:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

end