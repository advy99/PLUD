
require("src/minigames/minigame")

local class = require "lib/middleclass"


BombTag = MiniGame:subclass('BombTag')

function BombTag:initialize(num_players)

	-- Generamos un aleatorio entre 1 y NUMBER_OF_LEVELS, ambos incluidos
	local num_level = love.math.random(1, Constants.NUMBER_OF_LEVELS)

	MiniGame.initialize(self, "level_" .. num_level, num_players)

	self:assignBomb()
	self.bomb_swap_time = 0
	self.BOMB_TIME = 5
	self.bomb_timer = self.BOMB_TIME

	local pos = {Constants.DEFAULT_WIDTH/2 - 16, 64}
	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.countdown_box = TextBox:new( tostring(self.bomb_timer), pos[1], pos[2], 32, 32, 25, 0.8, text_color, box_color)

end


function BombTag:update(dt)

	MiniGame.update(self, dt)

	if self.bomb_swap_time < 1 then
		self.bomb_swap_time = self.bomb_swap_time + dt
	end

	if self.bomb_timer > 0 then
		self.bomb_timer = self.bomb_timer - dt
	else
		for _ , player in pairs(self.level.players) do
			if player.has_bomb then
				player:kill()
				player.has_bomb = false
			end
		end
	end

	for _ , player in pairs(self.level.players) do
		if player.has_died then
			local num = love.math.random(4)
			player:respawn(self.level.spawnpoints["spawn" .. num].x, self.level.spawnpoints["spawn" .. num].y)
			self.bomb_timer = self.BOMB_TIME
			self:assignBomb()
		end
	end

	self.countdown_box:updateText(tostring(math.abs(math.ceil(self.bomb_timer))))

end


function BombTag:draw()
	MiniGame.draw(self)

	self.countdown_box:draw()
end

function BombTag:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function BombTag:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

	if self.level.players[object_b] ~= nil and self.level.players[object_b] ~= nil then

		if event == Events.PLAYERS_COLLIDE then
			if self.level.players[object_a].has_bomb and self.bomb_swap_time >= 1 then
				self.level.players[object_a].has_bomb = false
				self.level.players[object_b].has_bomb = true
				self.bomb_swap_time = 0.5
			elseif self.level.players[object_b].has_bomb and self.bomb_swap_time >= 1 then
				self.level.players[object_b].has_bomb = false
				self.level.players[object_a].has_bomb = true
				self.bomb_swap_time = 0.5
			end
		end
	end
end

function BombTag:assignBomb()
	local num_player = table_size(self.level.players)
	num_player = love.math.random(num_player)

	self.level.players["player" .. num_player].has_bomb = true

end
