
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/death_ball")
require("src/minigames/virus_fall")
require("src/minigames/menus/configuration_menu")
require("src/minigames/menus/title_menu")
require("src/minigames/menus/practice_menu")
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

	self:changeMiniGame(Constants.MENU)

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

	if self.next_minigame ~= nil then
		local text_color = {1, 1, 1}
		local box_color = {0, 0, 0}

		local message = ""
		local pos = {446.5, 375}
		local size = {384, 150}
		if self.next_minigame == Constants.BOMB_TAG or self.next_minigame == Constants.VIRUS_FALL or
		self.next_minigame == Constants.DEATH_BALL then
			message = language.PLAY_GAME
			pos = {462.5, 100}
		elseif self.next_minigame == Constants.PLAY then
			message = language.PLAY_GAME
		elseif self.next_minigame == Constants.PRACTICE then
			message = language.ENTER_PRACTICE
		elseif self.next_minigame == Constants.MENU then
			message = language.QUIT_TO_MENU
			pos = {948, 375}
			size = {288, 150}
		elseif self.next_minigame == Constants.CONFIGURATION_MENU then
			message = language.ENTER_OPTIONS
		elseif self.next_minigame == Constants.SAVE_CONFIG then
			message = language.EXIT_SAVING_OPTIONS
			pos = {48, 375}
			size = {288, 150}
		elseif self.next_minigame == Constants.EXIT then
			message = language.EXIT_GAME
		end

		local countdown_text = TextBox:new( message .. math.abs(math.ceil(self.countdown)), pos[1], pos[2], size[1], size[2], 40, 0.8, text_color, box_color)
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

	local num = event - Events.PLAYER_LAND_PLATFORM_PLAY
	-- cuando entran en una plataforma

	if event == Events.DEATH_BALL_COLLISION then
		-- self.minigame:changeBallDirection()
	elseif event > 0 then
		if self.minigame:numPlayersInPlatform(num) == self.minigame:getNumPlayers() then
			self.countdown = Constants.TIME_BETWEEN_MINIGAME
			self.next_minigame = nil
			if event == Events.PLAYER_LAND_PLATFORM_PLAY then
				self.next_minigame = Constants.PLAY
			elseif event == Events.PLAYER_LAND_PLATFORM_CONFIGURATION then
				self.next_minigame = Constants.CONFIGURATION_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_PRACTICE then
				self.next_minigame = Constants.PRACTICE
			elseif event == Events.PLAYER_LAND_PLATFORM_EXIT then
				self.next_minigame = Constants.EXIT
			elseif event == Events.PLAYER_LAND_PLATFORM_MENU then
				self.next_minigame = Constants.MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_SAVE_CONFIG_AND_MENU then
				self.next_minigame = Constants.SAVE_CONFIG
			elseif event == Events.PLAYER_LAND_PLATFORM_BOMB_TAG then
				self.next_minigame = Constants.BOMB_TAG
			elseif event == Events.PLAYER_LAND_PLATFORM_VIRUS_FALL then
				self.next_minigame = Constants.VIRUS_FALL
			elseif event == Events.PLAYER_LAND_PLATFORM_DEATH_BALL then
				self.next_minigame = Constants.DEATH_BALL
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
	elseif minigame == Constants.MENU then
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
	end

	local show

	if self.minigame.class.super.name == "Menu" then
		show = "controls"
	else
		show = "score"
	end

	for i = 1, self.num_active_players, 1 do
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
	if k == 'escape' then
		if self.minigame.level.level_name == "level_title" then
			love.event.quit()
		else
			self:changeMiniGame(Constants.MENU)
		end
	end

	if (k == Constants.ADD_PLAYER_KEY or (love.keyboard.isDown(Constants.ADD_PLAYER_KEY_COMBINATION))) and self.num_active_players < Constants.MAX_PLAYERS then
		self:addPlayer()
	end

	if k == Constants.REMOVE_PLAYER_KEY and self.num_active_players > Constants.MIN_PLAYERS then
		self:removePlayer()
	end

	for _, player in pairs(self.minigame.level.players) do
		player:keyPressed(k)
	end

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

	if self.minigame.class.super.name == "Menu" then
		self.num_active_players = self.num_active_players + 1
		self.minigame:addPlayer(self.num_active_players)
		self.countdown = nil
		self.next_minigame = nil
	end


end


function Game:removePlayer()

	if self.minigame.class.super.name == "Menu" then
		self.minigame:removePlayer(self.num_active_players)
		self.num_active_players = self.num_active_players - 1
		self.countdown = nil
		self.next_minigame = nil
	end
end
