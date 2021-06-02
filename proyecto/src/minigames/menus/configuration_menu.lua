require("src/minigames/menus/menu")
local class = require "lib/middleclass"
local menuengine = require "lib/menuengine"
menuengine.stop_on_nil_functions = true

ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function start_game()
	print("START")
end

function quit_game()
	print("QUIT")
end


function ConfigurationMenu:initialize()
	Menu.initialize(self, "level_config")

	self.menu = menuengine.new(200,100)
	self.menu:addEntry("Start Game", start_game)
	self.menu:addSep()
	self.menu:addEntry("Quit Game", quit_game)


end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)
	self.menu:update()
end


function ConfigurationMenu:draw()
	love.graphics.setColor(1, 1, 1)
	Menu.draw(self)

	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)
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
