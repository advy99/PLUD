require("src/minigames/minigame")
local class = require "lib/middleclass"


GameMenu = MiniGame:subclass('GameMenu')

function GameMenu:initialize()

	MiniGame.initialize(self, "level_title")

	self.game_name_image = love.graphics.newImage("img/lose_to_win.png")

end


function GameMenu:update(dt)

	MiniGame.update(self, dt)

end


function GameMenu:draw()
	love.graphics.setColor(1, 1, 1)
	MiniGame.draw(self)

	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()

 	mainFont = love.graphics.newFont("fonts/kirbyss.ttf", 50)
	love.graphics.setFont(mainFont)
	-- love.graphics.printf("JUGAR", -width * 0.165 ,  height * 0.73, 1000, "center")
	-- love.graphics.printf("SALIR", width * 0.385,  height * 0.73, 1000, "center")

	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function GameMenu:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function GameMenu:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

end
