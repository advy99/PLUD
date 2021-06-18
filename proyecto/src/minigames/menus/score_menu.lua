require("src/minigames/menus/menu")

local class = require "lib/middleclass"

ScoreMenu = Menu:subclass('ScoreMenu')

function ScoreMenu:initialize(num_players)
	Menu.initialize(self, "level_score", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new(language.HIGHSCORE, 412, 80, 450, 75, 40, 1, text_color, box_color)

	self.background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)
end


function ScoreMenu:update(dt)

	Menu.update(self, dt)
end


function ScoreMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()
end

function ScoreMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ScoreMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
