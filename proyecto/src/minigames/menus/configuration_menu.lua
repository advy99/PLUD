require("src/minigames/menus/menu")

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
	self.title = TextBox:new(language.CONFIGURATION, 412, 80, 450, 75, 40, 1, text_color, box_color)


	self.background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)

	-- pagina 1
	local up_box = {self.background_box[1] + self.background_box[3]/2 - 150, 170, 300, 60}
	local down_box = {self.background_box[1] + self.background_box[3]/2 - 150, 350, 300, 60}
	self.language_section = TextBox:new(language.LANGUAGE, up_box[1], up_box[2], up_box[3], up_box[4], 35, 0.9, text_color, box_color)
	self.volume_section = TextBox:new(language.SOUND, down_box[1], down_box[2], down_box[3], down_box[4], 35, 0.9, text_color, box_color)

	-- pagina 2
	self.screen_section = TextBox:new(language.SCREEN, up_box[1], up_box[2], up_box[3], up_box[4], 35, 0.9, text_color, box_color)

	self.controls_section = TextBox:new(language.CONTROLS, down_box[1], down_box[2], down_box[3], down_box[4], 35, 0.9, text_color, box_color)

	local text_color = {1, 1, 1}
	local box_color = {1.00,0.30,0.30}
	local down_box = {self.background_box[1] + self.background_box[3]/2 - 150, 370, 300, 150}

	self.key_assigned_text_box = TextBox:new(language.KEY_ASSIGNED, down_box[1], down_box[2] + 100, down_box[3], down_box[4], 35, 1, text_color, box_color)
	self.key_assigned_time = 0
	self.KEY_ASSIGNED_TIME = 1


	self.init_config = Configuration:new()

	self.vsync_chk = {text = language.VSYNC, checked = self.init_config:getVSYNC()}
	self.fps_chk = {text = language.FPS, checked = self.init_config:getShowFPS()}
	self.music_slider = {value = self.init_config:getMusicVolume(), min = 0, max = 1}
	self.sfx_slider = {value = self.init_config:getSFXVolume(), min = 0, max = 1}
	self.mute_chk = {text = language.MUTE, checked = self.init_config:getMuted()}


	self.show_second_page = false

	self.languages_array = {"english", "spanish", "german", "italian", "french", "portuguese"}
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
	self.languages.german = love.graphics.newImage("img/languages/germany.png")
	self.languages.italian = love.graphics.newImage("img/languages/italy.png")
	self.languages.french = love.graphics.newImage("img/languages/france.png")
	self.languages.portuguese = love.graphics.newImage("img/languages/portugal.png")

	self.flag_position = {self.background_box[1] + self.background_box[3]/2 - self.languages.english:getWidth() / 2  * 0.15, 250}
	self.player_position = {self.background_box[1] + self.background_box[3]/2 - self.players_images.player1:getWidth() / 2 * 0.75 / 10, 390}

	self.pages_button_position = {self.background_box[1] + self.background_box[3]/2 - 150, 625, 300}

end


function ConfigurationMenu:update(dt)

	Menu.update(self, dt)

	self.title:updateText(language.CONFIGURATION)
	self.controls_section:updateText(language.CONTROLS)
	self.language_section:updateText(language.LANGUAGE)
	self.volume_section:updateText(language.SOUND)
	self.screen_section:updateText(language.SCREEN)

	self.vsync_chk.text = language.VSYNC
	self.fps_chk.text = language.FPS
	self.mute_chk.text = language.MUTE


	local font = love.graphics.newFont("fonts/kirbyss.ttf", 30)
	love.graphics.setFont(font)


	if not self.show_second_page then

		suit.Slider(self.music_slider, {align = "right"}, 640, 450, 175,30)
		suit.Label(language.MUSIC, {align = "center"}, 460, 450, 160,30)
		suit.Slider(self.sfx_slider, {align = "right"}, 640, 500, 175,30)
		suit.Label(language.SFX, {align = "center"}, 460, 500, 160,30)
		suit.Checkbox(self.mute_chk, {align = "center"}, 500, 550, 275,30)
		self.show_second_page = suit.Button("->", {id = "go_page_2", align = "center"}, self.pages_button_position[1], self.pages_button_position[2], self.pages_button_position[3],50).hit

		if suit.Button("<-", {align = "center"}, self.flag_position[1] - 70 - 20, self.flag_position[2] + self.languages.english:getWidth() / 2 * 0.15 - 15, 70,30).hit then
			self.active_language = self.active_language - 1
			if self.active_language < 1 then
				self.active_language = self.active_language + table_size(self.languages_array)
			end
			self.init_config:setLanguage(self.languages_array[self.active_language])
			changeLanguage(self.languages_array[self.active_language])

		end

		if suit.Button("->", {align = "center"}, self.flag_position[1] + self.languages.english:getWidth() * 0.15 + 20, self.flag_position[2] + self.languages.english:getWidth() / 2 * 0.15 - 15, 70,30).hit then
			self.active_language = self.active_language + 1

			if self.active_language > table_size(self.languages_array) then
				self.active_language = self.active_language - table_size(self.languages_array)
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

		suit.Checkbox(self.vsync_chk, {align = "center"}, self.background_box[1] + self.background_box[3] / 2 - 150, 250, 300,30)
		suit.Checkbox(self.fps_chk, {align = "center"}, self.background_box[1] + self.background_box[3] / 2 - 150, 300, 300,30)

		self.init_config:setVSYNC(self.vsync_chk.checked)
		self.init_config:setShowFPS(self.fps_chk.checked)


		if suit.Button("<-", {align = "center"}, self.player_position[1] - 70 - 20, self.player_position[2]+ self.players_images.player1:getHeight() / 20 * 0.75 + 10, 70,30).hit then
			self.actual_player = self.actual_player - 1
			if self.actual_player < 1 then
				self.actual_player = self.actual_player + 4
			end
		end

		if suit.Button("->", {align = "center"}, self.player_position[1] + self.players_images.player1:getWidth() * 0.075 + 20, self.player_position[2] + self.players_images.player1:getHeight() / 20 * 0.75 + 10, 70,30).hit then
			self.actual_player = self.actual_player + 1

			if self.actual_player > 4 then
				self.actual_player = self.actual_player - 4
			end
		end


		if love.timer.getTime() > self.key_assigned_time + self.KEY_ASSIGNED_TIME then
			suit.Label(language.JUMP, {align = "left"}, 500, self.player_position[2] + 85, 200,30)
			if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].JUMP_KEY), {id = "jump", align = "center"}, 725, self.player_position[2] + 85, 40,30).hit then
				local k = readKey()
				if not self.init_config:keyAssigned(k) and keyValid(k) then
					self.init_config.config["player" .. self.actual_player].JUMP_KEY = k
				else
					if self.init_config:keyAssigned(k) then
						self.key_assigned_text_box:updateText(language.KEY_ASSIGNED)
					else
						self.key_assigned_text_box:updateText(language.INVALID_KEY)
					end
					self.key_assigned_time = love.timer.getTime()
				end
			end

			suit.Label(language.LEFT, {align = "left"}, 500, self.player_position[2] + 135, 200,30)
			if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].LEFT_KEY), {id = "left", align = "center"}, 725, self.player_position[2] + 135, 40,30).hit then
				local k = readKey()
				if not self.init_config:keyAssigned(k) and keyValid(k) then
					self.init_config.config["player" .. self.actual_player].LEFT_KEY = k
				else
					if self.init_config:keyAssigned(k) then
						self.key_assigned_text_box:updateText(language.KEY_ASSIGNED)
					else
						self.key_assigned_text_box:updateText(language.INVALID_KEY)
					end
					self.key_assigned_time = love.timer.getTime()
				end
			end


			suit.Label(language.RIGHT, {align = "left"}, 500, self.player_position[2] + 185, 200,30)
			if suit.Button(string.upper(self.init_config.config["player" .. self.actual_player].RIGHT_KEY), {id = "right", align = "center"}, 725, self.player_position[2] + 185, 40,30).hit then
				local k = readKey()
				if not self.init_config:keyAssigned(k) and keyValid(k) then
					self.init_config.config["player" .. self.actual_player].RIGHT_KEY = k
				else
					if self.init_config:keyAssigned(k) then
						self.key_assigned_text_box:updateText(language.KEY_ASSIGNED)
					else
						self.key_assigned_text_box:updateText(language.INVALID_KEY)
					end
					self.key_assigned_time = love.timer.getTime()
				end
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
		self.controls_section:draw()
		love.graphics.reset()
		love.graphics.draw(self.players_images["player" .. self.actual_player], self.top_left, self.player_position[1], self.player_position[2], 0, 0.75, 0.75)

	end

	suit.draw()

	if love.timer.getTime() < self.key_assigned_time + self.KEY_ASSIGNED_TIME then
		self.key_assigned_text_box:draw()
	end


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
