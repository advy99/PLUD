
require("src/minigames/minigame")

local class = require "lib/middleclass"


PlayState = MiniGame:subclass('PlayState')

function PlayState:initialize(num_players)


	-- este minijuego  no tendrá mapa ni jugadores, luego no tengo que cargar la clase padre
	-- MiniGame.initialize(self, "level_" .. num_level, num_players)
	self.minigames = {}
	-- insertamos los juegos de forma aleatoria
	local pos = math.random(0, 2)
	-- TODO: cambiar por menu con resultados, no la tabla de scores
	table.insert(self.minigames, 0, ScoreMenu:new(num_players))
	table.insert(self.minigames, (pos % 3) + 1, BombTag:new(num_players))
	table.insert(self.minigames, ((pos + 1) % 3) + 1, DeathBall:new(num_players))
	table.insert(self.minigames, ((pos + 2) % 3) + 1, VirusFall:new(num_players))

	self.level = self.minigames[#self.minigames].level
	self.scores = {}

	self:saveScores()

	self.TIME_PER_MINIGAME = 10
	self.elapsed_time = 0

end


function PlayState:update(dt)
	self.minigames[#self.minigames]:update(dt)

	self.elapsed_time = self.elapsed_time + dt

	if self.elapsed_time >= self.TIME_PER_MINIGAME then
		self.elapsed_time = 0
		if #self.minigames > 0 then
			self:saveScores()
			table.remove(self.minigames, #self.minigames)
			self.level = self.minigames[#self.minigames].level
			self:setScores()
		else
			-- TODO acabar estado de juego, ha terminado la partida
		end
	end

end


function PlayState:draw()
	self.minigames[#self.minigames]:draw()
end

function PlayState:handleEvent(object, event)
	self.minigames[#self.minigames]:handleEvent(object, event)
end


function PlayState:handleEventBetweenObjects(object_a, object_b, event)
	self.minigames[#self.minigames]:handleEventBetweenObjects(object_a, object_b, event)
end


function PlayState:saveScores()
	for index, player in pairs(self.level.players) do
		self.scores[index] = player:getScore()
	end
end

function PlayState:setScores()
	for index, player in pairs(self.level.players) do
		print(self.scores[index])
		player:setScore(self.scores[index])
	end
end
