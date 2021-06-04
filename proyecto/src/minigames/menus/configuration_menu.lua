require("src/minigames/menus/menu")
local class = require "lib/middleclass"
local suit = require("lib/SUIT")

ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function ConfigurationMenu:initialize(num_players)
	Menu.initialize(self, "level_config", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new("CONFIGURATION", 435, 80, 400, 75, 40, 1, text_color, box_color)
	self.config_background = TextBox:new("", 390, 70, 500, 600, 40, 0.9, text_color, box_color)

	self.vsync_chk = {text = "VSYNC", checked = config:getVSYNC()}
	self.fps_chk = {text = "Show FPS", checked = config:getShowFPS()}
	self.music_slider = {value = config:getMusicVolume()}
	self.sfx_slider = {value = config:getSFXVolume()}


end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)
	love.graphics.setFont(font)


	suit.Checkbox(self.vsync_chk, {align = "center"}, 500, 200, 200,30)
	suit.Checkbox(self.fps_chk, {align = "center"}, 500, 250, 200,30)
	suit.Slider(self.fps_chk, {align = "center"}, 500, 250, 200,30)



	config:setVSYNC(self.vsync_chk.checked)
	config:setShowFPS(self.fps_chk.checked)


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
