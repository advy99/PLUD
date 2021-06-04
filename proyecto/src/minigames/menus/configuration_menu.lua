require("src/minigames/menus/menu")
local class = require "lib/middleclass"
local suit = require("lib/SUIT")

ConfigurationMenu = Menu:subclass('ConfigurationMenu')



function ConfigurationMenu:initialize(num_players)
	Menu.initialize(self, "level_config", num_players)

	self.title = TextBox:new("CONFIGURATION", 435, 80, 400, 75, 40, 0.6)
	self.config_background = TextBox:new("", 390, 70, 500, 600, 40, 0.6)

	self.vsync_chk = {text = "VSYNC", checked = config:getVSYNC()}

end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)
	love.graphics.setFont(font)


	suit.Checkbox(self.vsync_chk, 500, 200, 200,30)

	config:setVSYNC(self.vsync_chk.checked)

end


function ConfigurationMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()

	suit.draw()


end

function ConfigurationMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ConfigurationMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function ConfigurationMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)
end
