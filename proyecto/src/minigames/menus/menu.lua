require("src/minigames/minigame")
local class = require "lib/middleclass"


Menu = MiniGame:subclass('Menu')

function Menu:initialize(level_name, num_players)

	MiniGame.initialize(self, level_name, num_players)

	self.players_in_platform = {}

	for i = 0,3 do
		self.players_in_platform[i] = 0
	end

end


function Menu:update(dt)

	MiniGame.update(self, dt)

end


function Menu:draw()
	love.graphics.reset()

	MiniGame.draw(self)

end

function Menu:handleEvent(object, event)
	MiniGame.handleEvent(self, object, event)
end


function Menu:handleEventBetweenObjects(object_a, object_b, event)

	MiniGame.handleEventBetweenObjects(self, object_a, object_b, event)

end

function Menu:mouseMoved(x, y)
	MiniGame.mouseMoved(self, x, y)
end

function Menu:numPlayersInPlatform(num_platform)
	return self.players_in_platform[num_platform]
end



function Menu:handleInternalEvent(event)
	MiniGame.handleInternalEvent(self, event)


	-- como las plataformas estan ordenadas como en los eventos, si al evento le quito
	-- el valor del primer evento, se me queda en un rango de [0,7]
	local num = math.abs(event) - Events.PLAYER_LAND_PLATFORM_PLAY

	-- Si es negativo, se ha salido de la plataforma
	if event < 0 then
		-- le vuelvo a restar el valor del primer evento para dejarlo en [0,3]
		-- y le resto porque ha salido
		self.players_in_platform[num] = self.players_in_platform[num] - 1
	else
		-- ha entrado, así que sumo y ya
		self.players_in_platform[num] = self.players_in_platform[num] + 1
	end

end
