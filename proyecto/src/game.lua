
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/enums/constants")
require("src/level")
require("src/minigames/minigame")
require("src/minigames/bomb_tag")
require("src/minigames/game_menu")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()

	self:changeMiniGame(Constants.MENU)

end


function Game:update(dt)

	self.minigame:update(dt)


end

function Game:draw()

	self.minigame:draw()

end


function Game:handleEvent(object, event)

	self.minigame:handleEvent(object, event)

end


function Game:handleEventBetweenObjects(object_a, object_b, event)

	self.minigame:handleEventBetweenObjects(object_a, object_b, event)

end

function Game:changeMiniGame(minigame)

	if minigame == Constants.BOMB_TAG then
		self.minigame = BombTag()
	elseif minigame == Constants.MENU then
		self.minigame = GameMenu()
	end
end

function Game:loadLevel(level_name)
	self.minimage:loadLevel(level_name)
end


function Game:keyPressed(k)
	if k == 'escape' then
		if self.minigame.level.level_name == "level_menu" then
			love.event.quit()
		else
			self:changeMiniGame(Constants.MENU)
		end
	end

	if self.minigame.level.objects.player1 ~= nil then
		if k == "enter" then
			self.minigame.level.objects.player1:attack()
		end


		if k == "t" then
			self.minigame.level.objects.player1:kill()
		end

		if k == "up" then --press the up arrow key to set the ball in the air
			self.minigame.level.objects.player1:jump()
		end
	end

	if self.minigame.level.objects.player2 ~= nil then

		if k == "e" then
			self.minigame.level.objects.player2:attack()
		end

		if k == "w" then --press the up arrow key to set the ball in the air
			self.minigame.level.objects.player2:jump()
		end
	end
end

function Game:keyReleased(k)
	if self.minigame.level.objects.player2 ~= nil then
		if k == "a" or k == "d" then
			self.minigame.level.objects.player2:stopWalking()
		end
	end

	if self.minigame.level.objects.player1 ~= nil then
		if k == "left" or k == "right" then
			self.minigame.level.objects.player1:stopWalking()
		end
	end
end

function Game:handleKeyboard(dt)
	if self.minigame.level.objects.player1 ~= nil then

		if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
			self.minigame.level.objects.player1:move(1)
		end

		if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
			self.minigame.level.objects.player1:move(-1)
		end
	end

	if self.minigame.level.objects.player2 ~= nil then

		if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
			self.minigame.level.objects.player2:move(1)
		end

		if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
			self.minigame.level.objects.player2:move(-1)
		end
	end
end
