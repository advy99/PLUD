
require("src/minigames/minigame")
require("src/game_objects/virus")

local class = require "lib/middleclass"


VirusFall = MiniGame:subclass('VirusFall')

function VirusFall:initialize(num_players)

	-- Generamos un aleatorio entre 1 y NUMBER_OF_LEVELS, ambos incluidos
	local num_level = love.math.random(1, Constants.NUMBER_OF_LEVELS)

	MiniGame.initialize(self, "level_" .. num_level, num_players)

	self.virus = {}

	for i = 1, 2, 1 do
		self.virus[i] = Virus:new(self.level.world, 0, 0)
		self:respawnVirus(i)
	end


end


function VirusFall:update(dt)

	MiniGame.update(self, dt)

	for index , virus in pairs(self.virus) do

		virus:update(dt)

		local _, virus_y = virus:getPosition()

		if virus_y > Constants.DEFAULT_HEIGHT then
			self:respawnVirus(index)
		end

	end


	for _ , player in pairs(self.level.players) do
		if player.has_died then
			local num = love.math.random(4)
			player:respawn(self.level.spawnpoints["spawn" .. num].x, self.level.spawnpoints["spawn" .. num].y)
		end
	end

end


function VirusFall:draw()
	MiniGame.draw(self)

	for index , virus in pairs(self.virus) do
		virus:draw(dt)
	end

end

function VirusFall:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)

	if self.level.players[object] ~= nil then

		if event == Events.PLAYER_TOUCHED_VIRUS then
			self.level.players[object]:kill()
		end
	end
end


function VirusFall:handleEventBetweenObjects(object_a, object_b, event)
	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)
end

function VirusFall:respawnVirus(i)
	local new_x = love.math.random(32 + 26, Constants.DEFAULT_WIDTH - 32 - 26)
	self.virus[i]:setPosition(new_x, -64)
end
