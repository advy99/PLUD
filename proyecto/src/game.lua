
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/death_ball")
require("src/minigames/virus_fall")
require("src/minigames/play_state")
require("src/minigames/menus/configuration_menu")
require("src/minigames/menus/title_menu")
require("src/minigames/menus/practice_menu")
require("src/minigames/menus/score_menu")
require("src/minigames/menus/credits_menu")
require("src/minigames/menus/play_menu")


require("src/text_box")
require("src/interface_box")
require("src/sound_manager")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()

	self.minigame = nil
	self.num_active_players = Constants.MIN_PLAYERS

	self.countdown = nil
	self.next_minigame = nil

	for i = 1,4,1 do
		local keys = config.config["player" .. i]
		self["interface_p" .. i] = InterfaceBox:new(96 + (i-1) * 224 + (i-1) * 64, 784, keys)
	end

	self:changeMiniGame(Constants.TITLE_MENU)

	SoundManager.static.menu_music:play()

	local vol = 1
	if config:getMuted() then
		vol = 0
	end
	love.audio.setVolume(vol)

end


function Game:update(dt)

	self.minigame:update(dt)

	if self.next_minigame ~= nil then
		if self.countdown <= 0 then
			self:changeMiniGame(self.next_minigame)
			self.next_minigame = nil
			self.countdown = nil
		else
			self.countdown = self.countdown - dt
		end
	end

	for i = 1,4,1 do
		local keys = config.config["player" .. i]
		self["interface_p" .. i]:update(keys)
	end

end

function Game:draw()

	self.minigame:draw()

	if self.minigame.class.super.name ~= "Menu" and self.minigame.class.name ~= "PlayState" then
		love.graphics.setColor(0, 0, 0, 0.5)

		local box_color = {0, 0, 0}
		local text_color = {1, 1, 1}
		local key_size = 40
		local pos = {Constants.DEFAULT_WIDTH - 115, 35}
		local esc = TextBox:new( "ESC", pos[1], pos[2], key_size * 2, key_size, 22, 1, text_color, box_color) -- text, posX, posY, sizeW, sizeH, textSize


		esc:draw()

	end

	if self.next_minigame ~= nil then
		local text_color = {1, 1, 1}
		local box_color = {0, 0, 0}

		local message = ""
		local size = {384, 150}
		local pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 375}
		if self.next_minigame == Constants.BOMB_TAG or self.next_minigame == Constants.VIRUS_FALL or
		self.next_minigame == Constants.DEATH_BALL then
			message = language.PLAY_GAME
			pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
		elseif self.next_minigame == Constants.PLAY_MENU then
			message = language.ENTER_PLAY
			if self.minigame.class.name == "PracticeMenu" then
				pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
				message = language.QUIT_TO_MENU
			elseif self.minigame.class.name == "ScoreMenu" then
				size = {288, 150}
				pos = {948, 375}
				message = language.QUIT_TO_MENU
			end
		elseif self.next_minigame == Constants.PLAY then
			message = language.PLAY_GAME
			pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
		elseif self.next_minigame == Constants.PRACTICE then
			message = language.ENTER_PRACTICE
			pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
		elseif self.next_minigame == Constants.TITLE_MENU then
			message = language.QUIT_TO_MENU
			-- Si realiza esta llamada desde el menú de prácticas
			if self.minigame.class.name == "PlayMenu" then
				pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
			-- Si realiza esta llamada desde el menú de configuración
		elseif self.minigame.class.name == "PlayState" then
				size = {384, 150}
				lpos = {(Constants.DEFAULT_WIDTH - size[1])/2, 375}
			else
				size = {288, 150}
				pos = {948, 375}
			end
		elseif self.next_minigame == Constants.CONFIGURATION_MENU then
			message = language.ENTER_OPTIONS
		elseif self.next_minigame == Constants.CREDITS_MENU then
			message = language.ENTER_CREDITS
		elseif self.next_minigame == Constants.SCORE_MENU then
			message = language.ENTER_SCORE
			pos = {(Constants.DEFAULT_WIDTH - size[1])/2, 100}
		elseif self.next_minigame == Constants.SAVE_CONFIG then
			message = language.EXIT_SAVING_OPTIONS
			size = {288, 150}
			pos = {48, 375}
		elseif self.next_minigame == Constants.EXIT then
			message = language.EXIT_GAME
		end

		local countdown_text = TextBox:new( message .. math.abs(math.ceil(self.countdown)), pos[1], pos[2], size[1], size[2], 32, 0.8, text_color, box_color)
		countdown_text:draw()
	end

	local num = self.num_active_players

	if self.minigame.class.super.name == "Menu" then
		num = math.min(num + 1, Constants.MAX_PLAYERS)
	end

	for i = 1, num, 1 do
		-- si el primer parametro es nil, se trata de ayuda
		self["interface_p" .. i]:draw(self.minigame.level.players["player" .. i])
	end

end

function Game:handleInternalEvent(event)

	self.minigame:handleInternalEvent(event)

	local num = event - Events.PLAYER_LAND_PLATFORM_PLAY_MENU
	-- cuando entran en una plataforma

	if event == Events.DEATH_BALL_COLLISION then
		-- self.minigame:changeBallDirection()
	elseif event > 0 then
		if self.minigame:numPlayersInPlatform(num) == self.minigame:getNumPlayers() then
			self.countdown = Constants.TIME_BETWEEN_SCREENS
			self.next_minigame = nil
			if event == Events.PLAYER_LAND_PLATFORM_PLAY_MENU then
				self.next_minigame = Constants.PLAY_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_CONFIGURATION then
				self.next_minigame = Constants.CONFIGURATION_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_PRACTICE then
				self.next_minigame = Constants.PRACTICE
			elseif event == Events.PLAYER_LAND_PLATFORM_EXIT then
				self.next_minigame = Constants.EXIT
			elseif event == Events.PLAYER_LAND_PLATFORM_MENU then
				self.next_minigame = Constants.TITLE_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_SAVE_CONFIG_AND_MENU then
				self.next_minigame = Constants.SAVE_CONFIG
			elseif event == Events.PLAYER_LAND_PLATFORM_BOMB_TAG then
				self.next_minigame = Constants.BOMB_TAG
			elseif event == Events.PLAYER_LAND_PLATFORM_VIRUS_FALL then
				self.next_minigame = Constants.VIRUS_FALL
			elseif event == Events.PLAYER_LAND_PLATFORM_DEATH_BALL then
				self.next_minigame = Constants.DEATH_BALL
			elseif event == Events.PLAYER_LAND_PLATFORM_SCORE then
				self.next_minigame = Constants.SCORE_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_CREDITS then
				self.next_minigame = Constants.CREDITS_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_PLAY then
				self.next_minigame = Constants.PLAY
			end
		end
	else
		-- cuando el jugador sale de una plataforma
		if self.countdown ~= nil then
			self.countdown = nil
			self.next_minigame = nil
		end
	end

end

function Game:handleEvent(object, event)

	self.minigame:handleEvent(object, event)

end


function Game:handleEventBetweenObjects(object_a, object_b, event)

	self.minigame:handleEventBetweenObjects(object_a, object_b, event)

end

function Game:changeMiniGame(minigame)


	if minigame == Constants.BOMB_TAG then
		self.minigame = BombTag:new(self.num_active_players)
	elseif minigame == Constants.DEATH_BALL then
		self.minigame = DeathBall:new(self.num_active_players)
	elseif minigame == Constants.VIRUS_FALL then
		self.minigame = VirusFall:new(self.num_active_players)
	elseif minigame == Constants.TITLE_MENU then
		self.minigame = TitleMenu:new(self.num_active_players)
		SoundManager.static.menu_music:setVolume(config:getMusicVolume() * config:getMusicVolume())

		local sfx_vol = config:getSFXVolume() * config:getSFXVolume()
		for _ , player in pairs(self.minigame.level.players) do
			player.sound_manager:setVolume("jump", sfx_vol)
			player.sound_manager:setVolume("land", sfx_vol)
			player.sound_manager:setVolume("dead", sfx_vol)
		end

		local vol = 1
		if config:getMuted() then
			vol = 0
		end
		love.audio.setVolume(vol)
		changeLanguage(config:getLanguage())

	elseif minigame == Constants.PRACTICE then
		self.minigame = PracticeMenu:new(self.num_active_players)
	elseif minigame == Constants.CONFIGURATION_MENU then
		self.minigame = ConfigurationMenu:new(self.num_active_players)
	elseif minigame == Constants.EXIT then
		love.event.quit()
	elseif minigame == Constants.SAVE_CONFIG then
		self.minigame:saveConfig()
		self.minigame = TitleMenu:new(self.num_active_players)
	elseif minigame == Constants.PLAY_MENU then
		self.minigame = PlayMenu:new(self.num_active_players)
	elseif minigame == Constants.CREDITS_MENU then
		self.minigame = CreditsMenu:new(self.num_active_players)
	elseif minigame == Constants.SCORE_MENU then
		self.minigame = ScoreMenu:new(self.num_active_players)
	elseif minigame == Constants.PLAY then
		self.minigame = PlayState:new(self.num_active_players)
	end

	local show

	if self.minigame.class.super.name == "Menu" then
		show = "controls"
	else
		show = "score"
	end

	for i = 1, Constants.MAX_PLAYERS, 1 do
		self["interface_p" .. i]:setShow(show)
	end

end

function Game:loadLevel(level_name)
	self.minimage:loadLevel(level_name)
end

function Game:mouseMoved(x, y)
	if self.minigame ~= nil then
		self.minigame:mouseMoved(x, y)
	end
end

function Game:keyPressed(k)
	if k == 'escape' and self.minigame.class.super.name ~= "Menu" and self.minigame.class.name ~= "PlayState" then
		self:changeMiniGame(Constants.PRACTICE)
	elseif k == "escape" and Constants.DEBUG then
		if self.minigame.class.name == "TitleMenu" then
			love.event.quit()
		else
			self:changeMiniGame(Constants.TITLE_MENU)
		end
	end

	local key_comb1 =  love.keyboard.isDown(Constants.ADD_PLAYER_KEY_COMBINATION[1]) and love.keyboard.isDown(Constants.ADD_PLAYER_KEY_COMBINATION[2])
	local key_comb2 =  love.keyboard.isDown(Constants.ADD_PLAYER_KEY_COMBINATION_2[1]) and love.keyboard.isDown(Constants.ADD_PLAYER_KEY_COMBINATION_2[2])

	if (k == Constants.ADD_PLAYER_KEY or key_comb1 or key_comb2) and self.num_active_players < Constants.MAX_PLAYERS then
		self:addPlayer()
	end

	if k == Constants.REMOVE_PLAYER_KEY and self.num_active_players > Constants.MIN_PLAYERS then
		self:removePlayer()
	end

	self.minigame:keyPressed(k)

end

function Game:textEdited(text, start, length)
	-- for IME input
	self.minigame:textEdited(text, start, length)
end

function Game:textInput(t)
	-- forward text input to SUIT
	self.minigame:textInput(t)
end


function Game:keyReleased(k)

	for _, player in pairs(self.minigame.level.players) do
		player:keyReleased(k)
	end

end

function Game:handleKeyboard(dt)

	for _, player in pairs(self.minigame.level.players) do
		player:handleKeyboard(dt)
	end
end

function Game:addPlayer()
	 -- Permite añadir jugadores en modo DEBUG
	if self.minigame.class.super.name == "Menu" or Constants.DEBUG then
		self.num_active_players = self.num_active_players + 1
		self.minigame:addPlayer(self.num_active_players)
		self.countdown = nil
		self.next_minigame = nil
	end


end


function Game:removePlayer()
-- Permite eliminar jugadores en modo DEBUG
	if self.minigame.class.super.name == "Menu" or Constants.DEBUG then
		self.minigame:removePlayer(self.num_active_players)
		self.num_active_players = self.num_active_players - 1
		self.countdown = nil
		self.next_minigame = nil
	end
end
