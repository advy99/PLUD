require("src/minigames/menus/menu")
local class = require "lib/middleclass"


TitleMenu = Menu:subclass('TitleMenu')

function TitleMenu:initialize()

	Menu.initialize(self, "level_title")

	self.players_in_platform = {}

	for i = 0,3 do
		self.players_in_platform[i] = 0
	end

end


function TitleMenu:update(dt)

	Menu.update(self, dt)

end


function TitleMenu:draw()
	love.graphics.setColor(1, 1, 1)
	Menu.draw(self)


	love.graphics.draw(self.game_name_image, 480, 70, 0, 0.1, 0.1)

end

function TitleMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function TitleMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end

function TitleMenu:mouseMoved(x, y)
	Menu.mouseMoved(self, x, y)
end

function TitleMenu:handleInternalEvent(event)
	MiniGame.handleInternalEvent(self, event)

	-- como las plataformas estan ordenadas como en los eventos, si al evento le quito
	-- el valor del primer evento, se me queda en un rango de [0,7]
	local num = event - Events.PLAYER_LAND_PLATFORM_PLAY

	if num >= 0 and num <= 7 then
		-- Si no es uno de los cuatro primeros (0, 1, 2, 3), se ha salido de la plataforma
		if num > 3 then
			-- le vuelvo a restar el valor del primer evento para dejarlo en [0,3]
			num = event - Events.PLAYER_LEAVE_PLATFORM_PLAY
			-- y le resto porque ha salido
			self.players_in_platform[num] = self.players_in_platform[num] - 1
		else
			-- ha entrado, así que sumo y ya
			self.players_in_platform[num] = self.players_in_platform[num] + 1
		end
	end

end

function TitleMenu:numPlayersInPlatform(num_platform)
	return self.players_in_platform[num_platform]
end
