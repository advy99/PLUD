
require("src/handler/handle_collisions")
require("src/enums/events")
require("src/level")



local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()
	self.objects = {}

	self.bomb_swap_time = 0

	self.level = Level("level_menu")

end


function Game:update(dt)

	self.level:update(dt)

	if self.bomb_swap_time < 1 then
		self.bomb_swap_time = self.bomb_swap_time + dt
	end

end

function Game:draw()
	self.level:draw()
end


function Game:handleEvent(object, event)

	-- no debería pasar nunca, ya que el objeto está en el nivel, pero por si acaso
	if self.level.objects[object] ~= nil then

		if event == Events.PLAYER_LAND_PLATFORM then
			self.level.objects[object]:setMode("grounded")

		elseif event == Events.PLAYER_LEAVE_PLATFORM then

			if self.level.objects[object]:getMode() ~= "jumping" then
				self.level.objects[object]:setMode("falling")
			end

		elseif event == Events.EXIT_GAME then
			love.event.quit()
		end
	end

end


function Game:handleEventBetweenObjects(object_a, object_b, event)

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


function Game:loadLevel(level_name)
	self.level = Level(level_name)
end
