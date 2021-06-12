
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/death_ball")
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

	-- TODO: por cordura mental esto está comentado para las pruebas
	SoundManager.static.menu_music:play()
	-- self.music = love.audio.newSource("music/menu.mp3", "stream")
	-- self.music:setLooping(true)
	-- self.music:play()
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
		if self.next_minigame == Constants.BOMB_TAG or self.next_minigame == Constants.TREASURE_HUNT or
		self.next_minigame == Constants.DEATH_BALL then
			message = "GAME STARTS\nIN... "
		elseif self.next_minigame == Constants.PRACTICE then
			message = "PRACTICE MODE\n IN... "
		elseif self.next_minigame == Constants.MENU then
			message = "QUIT TO\nMENU IN... "
		elseif self.next_minigame == Constants.CONFIGURATION_MENU then
			message = "SETTINGS\nIN... "
		elseif self.next_minigame == Constants.SAVE_CONFIG then
			message = "QUIT AND SAVE\nIN... "
		elseif self.next_minigame == Constants.EXIT then
			message = "EXIT GAME\nIN... "
		end

		local countdown_text = TextBox:new( message .. math.abs(math.ceil(self.countdown)), 462.5, 375, 350, 150, 40, 0.8, text_color, box_color)
		countdown_text:draw()
	end

	for i = 1, self.num_active_players, 1 do
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
				self.next_minigame = Constants.DEATH_BALL -- TODO: cambiar entre los 3 minijuegos, con ganador, tabla de puntuaciones, etc.
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
			elseif event == Events.PLAYER_LAND_PLATFORM_TREASURE_HUNT then
				self.next_minigame = Constants.TREASURE_HUNT
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

	-- TODO solo cambiar entre controles y score cuando entre a un juego


	if minigame == Constants.BOMB_TAG then
		self.minigame = BombTag:new(self.num_active_players)
	elseif minigame == Constants.DEATH_BALL then
		self.minigame = DeathBall:new(self.num_active_players)
	elseif minigame == Constants.TREASURE_HUNT then
		--self.minigame = TreasureHunt:new(self.num_active_players) TODO: implementar tercer minijuego
	elseif minigame == Constants.MENU then
		self.minigame = TitleMenu:new(self.num_active_players)
		SoundManager.static.menu_music:setVolume(config:getMusicVolume() * config:getMusicVolume())

		local sfx_vol = config:getSFXVolume() * config:getSFXVolume()
		for _ , player in pairs(self.minigame.level.players) do
			player.sound_manager:setVolume("jump", sfx_vol)
			player.sound_manager:setVolume("land", sfx_vol)
			player.sound_manager:setVolume("dead", sfx_vol)
		end

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

	if k == Constants.ADD_PLAYER_KEY and self.num_active_players < Constants.MAX_PLAYERS then
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
