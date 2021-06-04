
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/menus/configuration_menu")
require("src/minigames/menus/title_menu")
require("src/text_box")
require("src/interface_box")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()

	self.minigame = nil
	self.num_active_players = 1
	self:changeMiniGame(Constants.MENU)

	self.countdown = nil
	self.next_minigame = nil

	local keys = config.config.player2
	self.interface = InterfaceBox:new(200, 200, keys)
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


end

function Game:draw()

	self.minigame:draw()

	if self.next_minigame ~= nil then
		local text_color = {1, 1, 1}
		local box_color = {0, 0, 0}
		local countdown_text = TextBox:new( "STARTING IN...\n" .. math.abs(math.ceil(self.countdown)), 462.5, 375, 350, 150, 40, 0.8, text_color, box_color)
		countdown_text:draw()
	end

	self.interface:draw(self.minigame.level.players.player1)

end

function Game:handleInternalEvent(event)

	self.minigame:handleInternalEvent(event)

	local num = event - Events.PLAYER_LAND_PLATFORM_PLAY
	-- cuando entran en una plataforma
	if event > 0 then
		if self.minigame:numPlayersInPlatform(num) == self.minigame:getNumPlayers() then
			self.countdown = 5

			self.next_minigame = nil
			if event == Events.PLAYER_LAND_PLATFORM_PLAY then
				self.next_minigame = Constants.BOMB_TAG
			elseif event == Events.PLAYER_LAND_PLATFORM_CONFIGURATION then
				self.next_minigame = Constants.CONFIGURATION_MENU
			elseif event == Events.PLAYER_LAND_PLATFORM_PRACTICE then
				-- TODO: Tenemos que ver que hacemos con la plataforma de prácticas
			elseif event == Events.PLAYER_LAND_PLATFORM_EXIT then
				self.next_minigame = Constants.EXIT
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
	elseif minigame == Constants.MENU then
		self.minigame = TitleMenu:new(self.num_active_players)
	elseif minigame == Constants.CONFIGURATION_MENU then
		self.minigame = ConfigurationMenu:new(self.num_active_players)
	elseif minigame == Constants.EXIT then
		love.event.quit()
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

	if k == Constants.ADD_PLAYER_KEY and self.num_active_players < 4 then
		self:addPlayer()
	end

	if k == Constants.REMOVE_PLAYER_KEY and self.num_active_players > 1 then
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

	if self.minigame.class.name == "ConfigurationMenu" or self.minigame.class.name == "TitleMenu" then
		self.num_active_players = self.num_active_players + 1
		self.minigame:addPlayer(self.num_active_players)
		self.countdown = nil
		self.next_minigame = nil
	end


end


function Game:removePlayer()
	if self.minigame.class.name == "ConfigurationMenu" or self.minigame.class.name == "TitleMenu" then
		self.minigame:removePlayer(self.num_active_players)
		self.num_active_players = self.num_active_players - 1
		self.countdown = nil
		self.next_minigame = nil
	end
end
