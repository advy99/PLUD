
require("src/minigames/minigame")

local class = require "lib/middleclass"


BombTag = MiniGame:subclass('BombTag')

function BombTag:initialize()

	-- Generamos un aleatorio entre 1 y NUMBER_OF_LEVELS, ambos incluidos
	local num_level = love.math.random(1, Constants.NUMBER_OF_LEVELS)

	MiniGame.initialize(self, "level_" .. num_level)

	self.bomb_swap_time = 0
	self.bomb_timer = 5

end


function BombTag:update(dt)

	MiniGame.update(self, dt)

	if self.bomb_swap_time < 1 then
		self.bomb_swap_time = self.bomb_swap_time + dt
	end

	if self.bomb_timer > 0 then
		self.bomb_timer = self.bomb_timer - dt
	else

		for _ , player in pairs(self.level.objects) do
			if player.has_bomb then
				player:kill()
			end
		end

	end

	for _ , player in pairs(self.level.objects) do
		if player.has_died then
			player:respawn(300, 300)
			self.bomb_timer = 5
		end
	end

end


function BombTag:draw()
	MiniGame.draw(self)

	if self.level.level_name ~= "level_menu" then
		love.graphics.setColor(0, 0, 0)
		local mainFont = love.graphics.newFont("fonts/kirbyss.ttf", 50)
		love.graphics.setFont(mainFont)
		love.graphics.printf("Tiempo restante: " .. math.abs(math.ceil(self.bomb_timer)), -100,  50, 1000, "center")
	end

end

function BombTag:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function BombTag:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

	if self.level.objects[object_b] ~= nil and self.level.objects[object_b] ~= nil then

		if event == Events.PLAYERS_COLLIDE then
			if self.level.objects[object_a].has_bomb and self.bomb_swap_time >= 1 then
				self.level.objects[object_a].has_bomb = false
				self.level.objects[object_b].has_bomb = true
				self.bomb_swap_time = 0.5
			elseif self.level.objects[object_b].has_bomb and self.bomb_swap_time >= 1 then
				self.level.objects[object_b].has_bomb = false
				self.level.objects[object_a].has_bomb = true
				self.bomb_swap_time = 0.5
			end
		end
	end
end
