
require("src/minigames/minigame")

local class = require "lib/middleclass"


BombTag = MiniGame:subclass('BombTag')

function BombTag:initialize(num_players)

	-- Generamos un aleatorio entre 1 y NUMBER_OF_LEVELS, ambos incluidos
	local num_level = love.math.random(1, Constants.NUMBER_OF_LEVELS)

	MiniGame.initialize(self, "level_" .. num_level, num_players)

	-- Ponemos en -1 para indicar que ningún jugador tiene la bomba
	self.num_player_with_bomb = -1

	self.bomb_sprite = love.graphics.newImage("img/dynamite.png")

	self:assignBomb()
	self.bomb_swap_time = 0
	self.BOMB_TIME = 5
	self.bomb_timer = self.BOMB_TIME

	self.countdown_box_size = {32, 32}
	local pos = {0, 0}
	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.countdown_box = TextBox:new( tostring(self.bomb_timer), pos[1], pos[2], self.countdown_box_size[1], self.countdown_box_size[2], self.countdown_box_size[1]*0.75, 0.8, text_color, box_color)

end


function BombTag:update(dt)

	MiniGame.update(self, dt)

	if self.bomb_swap_time < 1 then
		self.bomb_swap_time = self.bomb_swap_time + dt
	end

	if self.bomb_timer > 0 then
		self.bomb_timer = self.bomb_timer - dt

		if self.num_player_with_bomb ~= -1 then
			local player = self.level.players["player" .. self.num_player_with_bomb]
			local new_pos_x = player.body:getX() - self.countdown_box_size[1]/2
			local new_pos_y = player.body:getY() - self.countdown_box_size[2]/2 - player.height*1.5
			self.countdown_box:updatePosition(new_pos_x, new_pos_y)
		end
	else
		if self.num_player_with_bomb ~= -1 then
			local player = self.level.players["player" .. self.num_player_with_bomb]
			player:kill()
			self.num_player_with_bomb = -1
			self.countdown_box:updatePosition(-100, -100)
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

	-- si el personaje tiene la bomba, la dibujamos
	if self.num_player_with_bomb ~= -1 then

		local player = self.level.players["player" .. self.num_player_with_bomb]
		local bomb_pos_x = player.body:getX() + 5 * player.orientation
		local bomb_pos_y = player.body:getY() * 0.98

		love.graphics.draw(self.bomb_sprite, bomb_pos_x, bomb_pos_y, 0, -player.orientation, 1)
	end
end

function BombTag:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function BombTag:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

	if self.level.players[object_b] ~= nil and self.level.players[object_b] ~= nil then

		if event == Events.PLAYERS_COLLIDE then
			if object_a == "player" .. self.num_player_with_bomb and self.bomb_swap_time >= 1 then
				self.num_player_with_bomb = tonumber(string.sub(object_b, -1))
				self.bomb_swap_time = 0.5
			elseif object_b == "player" .. self.num_player_with_bomb and self.bomb_swap_time >= 1 then
				self.num_player_with_bomb = tonumber(string.sub(object_a, -1))
				self.bomb_swap_time = 0.5
			end
		end
	end
end

function BombTag:assignBomb()
	local num_player = table_size(self.level.players)
	self.num_player_with_bomb = love.math.random(num_player)
end
