require("src/minigames/menus/menu")
require("src/credits")

local class = require "lib/middleclass"
local suit = require("lib/SUIT")

CreditsMenu = Menu:subclass('CreditsMenu')

function CreditsMenu:initialize(num_players)
	Menu.initialize(self, "level_credits", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new(language.CREDITS, 412, 80, 450, 75, 40, 1, text_color, box_color)

	self.background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)
end


function CreditsMenu:update(dt)

	Menu.update(self, dt)
end


function CreditsMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()
end

function CreditsMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function CreditsMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
