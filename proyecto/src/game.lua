
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/menus/configuration_menu")
require("src/minigames/menus/game_menu")
require("src/text_box")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()

	self.minigame = nil
	self:changeMiniGame(Constants.MENU)

	self.countdown = nil
	self.next_minigame = nil
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
		local countdown_text = TextBox:new( "STARTING IN...\n" .. math.abs(math.ceil(self.countdown)), 462.5, 375, 350, 150, 40)
		countdown_text:draw()
	end

end

function Game:handleInternalEvent(event)

	self.countdown = 5

	self.next_minigame = nil
	if event == Events.PLAYER_LAND_PLATFORM_PLAY then
		self.next_minigame = Constants.BOMB_TAG
	elseif event == Events.PLAYER_LAND_PLATFORM_CONFIGURATION then
		self.next_minigame = Constants.CONFIGURATION_MENU
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
		self.minigame = BombTag:new()
	elseif minigame == Constants.MENU then
		self.minigame = GameMenu:new()
	elseif minigame == Constants.CONFIGURATION_MENU then
		self.minigame = ConfigurationMenu:new()
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

	if self.minigame.level.players.player1 ~= nil then
		if k == "enter" then
			self.minigame.level.players.player1:attack()
		end


		if k == "t" then
			self.minigame.level.players.player1:kill()
		end

		if k == "up" then --press the up arrow key to set the ball in the air
			self.minigame.level.players.player1:jump()
		end
	end

	if self.minigame.level.players.player2 ~= nil then

		if k == "e" then
			self.minigame.level.players.player2:attack()
		end

		if k == "w" then --press the up arrow key to set the ball in the air
			self.minigame.level.players.player2:jump()
		end
	end
end

function Game:keyReleased(k)
	if self.minigame.level.players.player2 ~= nil then
		if k == "a" or k == "d" then
			self.minigame.level.players.player2:stopWalking()
		end
	end

	if self.minigame.level.players.player1 ~= nil then
		if k == "left" or k == "right" then
			self.minigame.level.players.player1:stopWalking()
		end
	end
end

function Game:handleKeyboard(dt)
	if self.minigame.level.players.player1 ~= nil then

		if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
			self.minigame.level.players.player1:move(1)
		end

		if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
			self.minigame.level.players.player1:move(-1)
		end
	end

	if self.minigame.level.players.player2 ~= nil then

		if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
			self.minigame.level.players.player2:move(1)
		end

		if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
			self.minigame.level.players.player2:move(-1)
		end
	end
end
