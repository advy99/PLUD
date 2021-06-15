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
	self.title = TextBox:new(language.CONFIGURATION, 435, 80, 400, 75, 40, 1, text_color, box_color)
	self.controls_title = TextBox:new(language.CONTROLS, 435, 80, 400, 75, 40, 1, text_color, box_color)


	local background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", 390, 70, 500, 625, 40, 0.9, text_color, box_color)

	-- pagina 1
	local languages_box = {background_box[1] + background_box[3]/2 - 125, 170, 250, 60}
	local volume_box = {background_box[1] + background_box[3]/2 - 100, 350, 200, 60}
	self.language_section = TextBox:new(language.LANGUAGE, languages_box[1], languages_box[2], languages_box[3], languages_box[4], 35, 0.9, text_color, box_color)
	self.volume_section = TextBox:new(language.SOUND, volume_box[1], volume_box[2], volume_box[3], volume_box[4], 35, 0.9, text_color, box_color)

	-- pagina 2
	local screen_box = {background_box[1] + background_box[3]/2 - 100, 170, 200, 60}
	self.screen_section = TextBox:new(language.SCREEN, screen_box[1], screen_box[2], screen_box[3], screen_box[4], 35, 0.9, text_color, box_color)




	self.init_config = Configuration:new()

	self.vsync_chk = {text = language.VSYNC, checked = self.init_config:getVSYNC()}
	self.fps_chk = {text = language.FPS, checked = self.init_config:getShowFPS()}
	self.music_slider = {value = self.init_config:getMusicVolume(), min = 0, max = 1}
	self.sfx_slider = {value = self.init_config:getSFXVolume(), min = 0, max = 1}
	self.mute_chk = {text = language.MUTE, checked = self.init_config:getMuted()}


	self.show_second_page = false

	self.languages_array = {"english", "spanish"}
	self.active_language = 0

	for key, value in pairs(self.languages_array)
	do
		if value == self.init_config:getLanguage() then
			self.active_language = key
		end
	end

	self.languages = {}
	self.languages.english = love.graphics.newImage("img/languages/united-kingdom.png")
	self.languages.spanish = love.graphics.newImage("img/languages/spain.png")

	self.flag_position = {background_box[1] + background_box[3]/2 - self.languages.english:getWidth() / 2  * 0.15, 250}
	self.player_position = {background_box[1] + background_box[3]/2 - self.players_images.player1:getWidth() / 2 * 0.75 / 10, 175}

	self.pages_button_position = {background_box[1] + background_box[3]/2 - 150, 600, 300}

end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

	self.title:updateText(language.CONFIGURATION)
	self.controls_title:updateText(language.CONTROLS)
	self.language_section:updateText(language.LANGUAGE)
	self.volume_section:updateText(language.SOUND)
	self.screen_section:updateText(language.SCREEN)

	self.vsync_chk.text = language.VSYNC
	self.fps_chk.text = language.FPS
	self.mute_chk.text = language.MUTE


	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)
	love.graphics.setFont(font)


	if not self.show_second_page then

		suit.Slider(self.music_slider, {align = "right"}, 640, 425, 175,30)
		suit.Label(language.MUSIC, {align = "center"}, 460, 425, 160,30)
		suit.Slider(self.sfx_slider, {align = "right"}, 640, 475, 175,30)
		suit.Label(language.SFX, {align = "center"}, 460, 475, 160,30)
		suit.Checkbox(self.mute_chk, {align = "left"}, 500, 525, 250,30)
		self.show_second_page = suit.Button("->", {id = "go_page_2", align = "center"}, self.pages_button_position[1], self.pages_button_position[2], self.pages_button_position[3],50).hit

		if suit.Button("<-", {align = "center"}, self.flag_position[1] - 70 - 20, self.flag_position[2] + self.languages.english:getWidth() / 2 * 0.15 - 15, 70,30).hit then
			self.active_language = self.active_language - 1
			if self.active_language < 1 then
				self.active_language = self.active_language + 2
			end
			self.init_config:setLanguage(self.languages_array[self.active_language])
			changeLanguage(self.languages_array[self.active_language])

		end

		if suit.Button("->", {align = "center"}, self.flag_position[1] + self.languages.english:getWidth() * 0.15 + 20, self.flag_position[2] + self.languages.english:getWidth() / 2 * 0.15 - 15, 70,30).hit then
			self.active_language = self.active_language + 1

			if self.active_language > 2 then
				self.active_language = self.active_language - 2
			end
			self.init_config:setLanguage(self.languages_array[self.active_language])

			changeLanguage(self.languages_array[self.active_language])
		end


		self.init_config:setMusicVolume(self.music_slider.value)
		self.init_config:setSFXVolume(self.sfx_slider.value)
		self.init_config:setMuted(self.mute_chk.checked)

		local vol = 1

		if self.mute_chk.checked then
			vol = 0
		end

		love.audio.setVolume(vol)

		local music_vol = self.music_slider.value * self.music_slider.value
		SoundManager.static.menu_music:setVolume(music_vol)

		local sfx_vol = self.sfx_slider.value * self.sfx_slider.value
		for _ , player in pairs(self.level.players) do
			player.sound_manager:setVolume("jump", sfx_vol)
			player.sound_manager:setVolume("land", sfx_vol)
			player.sound_manager:setVolume("dead", sfx_vol)
		end

	else

		suit.Checkbox(self.vsync_chk, {align = "left"}, 500, 250, 250,30)
		suit.Checkbox(self.fps_chk, {align = "left"}, 500, 300, 250,30)

		self.init_config:setVSYNC(self.vsync_chk.checked)
		self.init_config:setShowFPS(self.fps_chk.checked)


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


		suit.Label(language.JUMP, {align = "left"}, 550, 300, 130,30)

		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].JUMP_KEY), {id = "jump", align = "center"}, 675, 300, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].JUMP_KEY = k
			end
		end

		suit.Label(language.LEFT, {align = "left"}, 550, 350, 130,30)
		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].LEFT_KEY), {id = "left", align = "center"}, 675, 350, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].LEFT_KEY = k
			end
		end


		suit.Label(language.RIGHT, {align = "left"}, 550, 400, 130,30)
		if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].RIGHT_KEY), {id = "right", align = "center"}, 675, 400, 40,30).hit then
			local k = readKey()
			if not self.init_config:keyAssigned(k) and k ~= "escape" then
				self.init_config.config["player" .. self.actual_player].RIGHT_KEY = k
			end
		end

		-- si pulso dentro de controles, estoy saliendo de controles
		self.show_second_page = not suit.Button("<-", {id = "go_page_1", align = "center"}, self.pages_button_position[1], self.pages_button_position[2], self.pages_button_position[3],50).hit
	end

end


function ConfigurationMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()

	if not self.show_second_page then
		self.language_section:draw()
		self.volume_section:draw()
		love.graphics.draw(self.languages[self.languages_array[self.active_language]], self.flag_position[1], self.flag_position[2], 0, 0.15, 0.15)

	else
		self.screen_section:draw()
		self.controls_title:draw()
		love.graphics.reset()
		love.graphics.draw(self.players_images["player" .. self.actual_player], self.top_left, self.player_position[1], self.player_position[2], 0, 0.75, 0.75)

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
