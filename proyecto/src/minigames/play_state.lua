
require("src/minigames/minigame")

local class = require "lib/middleclass"


PlayState = MiniGame:subclass('PlayState')

function PlayState:initialize(num_players)


	-- este minijuego  no tendrá mapa ni jugadores, luego no tengo que cargar la clase padre
	-- MiniGame.initialize(self, "level_" .. num_level, num_players)

	self.minigames = {}
	-- insertamos los juegos de forma aleatoria
	local pos = math.random(0, 2)
	table.insert(self.minigames, (pos % 3) + 1, BombTag:new(num_players))
	table.insert(self.minigames, ((pos + 1) % 3) + 1, DeathBall:new(num_players))
	table.insert(self.minigames, ((pos + 2) % 3) + 1, VirusFall:new(num_players))

	self.scores = {}

end


function PlayState:update(dt)
	self.minigames[0]:update(dt)
end


function PlayState:draw()
	self.minigames[0]:draw()
end

function PlayState:handleEvent(object, event)
	self.minigames[0]:handleEvent(object, event)
end


function PlayState:handleEventBetweenObjects(object_a, object_b, event)
	self.minigames[0]:handleEventBetweenObjects(object_a, object_b, event)
end
