require("src/minigames/menus/menu")
require("src/configuration")

local class = require "lib/middleclass"
local suit = require("lib/SUIT")

ConfigurationMenu = Menu:subclass('ConfigurationMenu')

function ConfigurationMenu:initialize(num_players)
	Menu.initialize(self, "level_config", num_players)

	self.players_images = {}
	self.players_images.player1 = love.graphics.newImage("img/blue_slime_atlas.png")
	self.players_images.player2 = love.graphics.newImage("img/red_slime_atlas.png")
	self.players_images.player3 = love.graphics.newImage("img/green_slime_atlas.png")
	self.players_images.player4 = love.graphics.newImage("img/yellow_slime_atlas.png")
	self.actual_player = 1
	self.top_left = love.graphics.newQuad(0, 0, 128, 128, self.players_images.player1:getDimensions())

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new("CONFIGURATION", 435, 80, 400, 75, 40, 1, text_color, box_color)
	self.controls_title = TextBox:new("CONTROLS", 435, 80, 400, 75, 40, 1, text_color, box_color)

	self.screen_section = TextBox:new("SCREEN", 525, 170, 200, 60, 35, 0.9, text_color, box_color)
	self.volume_section = TextBox:new("VOLUME", 525, 350, 200, 60, 35, 0.9, text_color, box_color)

	self.config_background = TextBox:new("", 390, 70, 500, 625, 40, 0.9, text_color, box_color)
	self.init_config = Configuration:new()

	self.vsync_chk = {text = "VSYNC", checked = self.init_config:getVSYNC()}
	self.fps_chk = {text = "SHOW FPS", checked = self.init_config:getShowFPS()}
	self.music_slider = {value = self.init_config:getMusicVolume(), min = 0, max = 2}
	self.sfx_slider = {value = self.init_config:getSFXVolume(), min = 0, max = 2}
	self.mute_chk = {text = "MUTE ALL", checked = self.init_config:getMuted()}


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
		suit.Checkbox(self.mute_chk, {align = "left"}, 500, 525, 250,30)
		self.on_controls = suit.Button("CONTROLS", {align = "center"}, 480, 600, 300,50).hit

		-- TODO : Seleccion de idioma

		self.init_config:setVSYNC(self.vsync_chk.checked)
		self.init_config:setShowFPS(self.fps_chk.checked)
		self.init_config:setMusicVolume(self.music_slider.value)
		self.init_config:setSFXVolume(self.sfx_slider.value)
		self.init_config:setMuted(self.mute_chk.checked)

		SoundManager.static.menu_music:setVolume(self.music_slider.value * self.music_slider.value)

	else

		if suit.Button("<-", {align = "center"}, 500, 210, 70,30).hit then
			self.actual_player = self.actual_player - 1
			if self.actual_player < 1 then
				self.actual_player = self.actual_player + 4
			end
		end

		if suit.Button("->", {align = "center"}, 700, 210, 70,30).hit then
			self.actual_player = self.actual_player + 1

			if self.actual_player > 4 then
				self.actual_player = self.actual_player - 4
			end
		end


		suit.Label("JUMP", {align = "left"}, 550, 300, 130,30)

		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].JUMP_KEY), {id = "jump", align = "center"}, 675, 300, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].JUMP_KEY = k
			end
		end

		suit.Label("LEFT", {align = "left"}, 550, 350, 130,30)
		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].LEFT_KEY), {id = "left", align = "center"}, 675, 350, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].LEFT_KEY = k
			end
		end


		suit.Label("RIGHT", {align = "left"}, 550, 400, 130,30)
		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].RIGHT_KEY), {id = "right", align = "center"}, 675, 400, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].RIGHT_KEY = k
			end
		end

		-- si pulso dentro de controles, estoy saliendo de controles
		self.on_controls = not suit.Button("BACK", {align = "center"}, 480, 550, 300,50).hit
	end

end


function ConfigurationMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()

	if not self.on_controls then
		self.title:draw()
		self.screen_section:draw()
		self.volume_section:draw()
	else
		self.controls_title:draw()
		love.graphics.reset()
		love.graphics.draw(self.players_images["player" .. self.actual_player], self.top_left, 590, 175, 0, 0.75, 0.75)

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
