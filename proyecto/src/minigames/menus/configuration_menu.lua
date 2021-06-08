require("src/minigames/menus/menu")
require("src/configuration")

local class = require "lib/middleclass"
local suit = require("lib/SUIT")

ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function ConfigurationMenu:initialize(num_players)
	Menu.initialize(self, "level_config", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new("CONFIGURATION", 435, 80, 400, 75, 40, 1, text_color, box_color)
	self.screen_section = TextBox:new("SCREEN", 525, 170, 200, 60, 35, 0.9, text_color, box_color)
	self.volume_section = TextBox:new("VOLUME", 525, 350, 200, 60, 35, 0.9, text_color, box_color)

	self.config_background = TextBox:new("", 390, 70, 500, 600, 40, 0.9, text_color, box_color)
	self.init_config = Configuration:new()

	self.vsync_chk = {text = "VSYNC", checked = self.init_config:getVSYNC()}
	self.fps_chk = {text = "SHOW FPS", checked = self.init_config:getShowFPS()}
	self.music_slider = {value = self.init_config:getMusicVolume()}
	self.sfx_slider = {value = self.init_config:getSFXVolume()}

	self.on_controls = false

end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)
	love.graphics.setFont(font)

	if not self.on_controls then
		suit.Checkbox(self.vsync_chk, {align = "left"}, 500, 250, 250,30)
		suit.Checkbox(self.fps_chk, {align = "left"}, 500, 300, 250,30)
		suit.Slider(self.music_slider, {align = "right"}, 600, 425, 200,30)
		suit.Label("MUSIC", {align = "left"}, 475, 425, 130,30)
		suit.Slider(self.sfx_slider, {align = "right"}, 600, 475, 200,30)
		suit.Label("SFX", {align = "left"}, 475, 475, 130,30)
		suit.Button("CONTROLS", {align = "center"}, 480, 550, 300,50)



		self.init_config:setVSYNC(self.vsync_chk.checked)
		self.init_config:setShowFPS(self.fps_chk.checked)
		self.init_config:setMusicVolume(self.music_slider.value)
		self.init_config:setSFXVolume(self.sfx_slider.value)
	end

end


function ConfigurationMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	if not self.on_controls then
		self.config_background:draw()
		self.title:draw()
		self.screen_section:draw()
		self.volume_section:draw()
	end

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

function ConfigurationMenu:saveConfig()
	self.init_config:saveConfig()
	config:loadConfiguration()
	local flags = {vsync = config:getVSYNC(), fullscreen = false, resizable = false}
	love.window.updateMode(Constants.DEFAULT_WIDTH, Constants.DEFAULT_HEIGHT, flags)
end
