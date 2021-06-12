
require("src/minigames/minigame")
require("src/game_objects/energy_ball")

local class = require "lib/middleclass"


DeathBall = MiniGame:subclass('DeathBall')

function DeathBall:initialize(num_players)

	-- Generamos un aleatorio entre 1 y NUMBER_OF_LEVELS, ambos incluidos
	local num_level = love.math.random(1, Constants.NUMBER_OF_LEVELS)

	MiniGame.initialize(self, "level_" .. num_level, num_players)

	self.energy_ball = EnergyBall:new(self.level.world, 100, 100)

end


function DeathBall:update(dt)

	MiniGame.update(self, dt)

	self.energy_ball:update(dt)


	for _ , player in pairs(self.level.players) do
		if player.has_died then
			local num = love.math.random(4)
			player:respawn(self.level.spawnpoints["spawn" .. num].x, self.level.spawnpoints["spawn" .. num].y)
		end
	end

end


function DeathBall:draw()
	MiniGame.draw(self)

	self.energy_ball:draw(dt)

end

function DeathBall:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)

	if self.level.players[object] ~= nil then

		if event == Events.PLAYER_TOUCHED_DEATH_BALL then
			self.level.players[object]:kill()
		end
	end
end


function DeathBall:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

	-- if self.level.players[object_b] ~= nil and self.level.players[object_b] ~= nil then
	--
	-- 	if event == Events.PLAYERS_COLLIDE then
	-- 		if self.level.players[object_a].has_bomb and self.bomb_swap_time >= 1 then
	-- 			self.level.players[object_a].has_bomb = false
	-- 			self.level.players[object_b].has_bomb = true
	-- 			self.bomb_swap_time = 0.5
	-- 		elseif self.level.players[object_b].has_bomb and self.bomb_swap_time >= 1 then
	-- 			self.level.players[object_b].has_bomb = false
	-- 			self.level.players[object_a].has_bomb = true
	-- 			self.bomb_swap_time = 0.5
	-- 		end
	-- 	end
	-- end
end


function DeathBall:changeBallDirection(x, y)

	-- local aleatorio = love.math.random( 0, 360 )
	self.energy_ball:changeBallDirection(x, y )
end
