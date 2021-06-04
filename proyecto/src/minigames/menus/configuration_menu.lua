require("src/minigames/menus/menu")
local class = require "lib/middleclass"
local menuengine = require "lib/menuengine"
menuengine.stop_on_nil_functions = true

ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function changeVSYNC()
	config:setVSYNC(not config:getVSYNC())
end

function quit_game()
	print("QUIT")
end


function ConfigurationMenu:initialize(num_players)
	Menu.initialize(self, "level_config", num_players)


	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new("CONFIGURATION", 435, 80, 400, 75, 40, 0.6, text_color, box_color)
	self.vsync_value = TextBox:new(config:getTextVSYNC(), 650, 180, 100, 40, 30, 0)

	self.config_background = TextBox:new("", 390, 70, 500, 600, 40, 0.6, text_color, box_color)

	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)

	self.menu = menuengine.new(500,200, font)
	self.menu:addEntry("VSYC: \t\t ", changeVSYNC)
	self.menu:addSep()
	self.menu:addEntry("Quit Game", quit_game)


end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)
	self.menu:update()
	self.vsync_value:updateText(config:getTextVSYNC())
end


function ConfigurationMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()
	self.vsync_value:draw()
	self.menu:draw()


end

function ConfigurationMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ConfigurationMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function ConfigurationMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)

	menuengine.mousemoved(x, y)
end
