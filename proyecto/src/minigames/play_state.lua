
require("src/minigames/minigame")
require("src/minigames/menus/result_menu")

local class = require "lib/middleclass"


PlayState = MiniGame:subclass('PlayState')

function PlayState:initialize(num_players)


	-- este minijuego  no tendrá mapa ni jugadores, luego no tengo que cargar la clase padre
	-- MiniGame.initialize(self, "level_" .. num_level, num_players)
	self.minigames = {}
	-- TODO: cambiar por menu con resultados, no la tabla de scores
	table.insert(self.minigames, 0, ResultMenu:new(num_players))
	table.insert(self.minigames, 1, BombTag:new(num_players))
	table.insert(self.minigames, 2, DeathBall:new(num_players))
	table.insert(self.minigames, 3, VirusFall:new(num_players))

	self.level = self.minigames[#self.minigames].level
	self.scores = {}

	self:saveScores()

	self.curtain = love.graphics.newImage("img/curtain.png")

	self.left_curtain_animation_position = -Constants.DEFAULT_WIDTH / 2
	self.right_curtain_animation_position = Constants.DEFAULT_WIDTH

	self.curtain_animation_time = 0.75

	self.TIME_PER_MINIGAME = 30
	self.TIME_CLOSE_CURTAINS = self.TIME_PER_MINIGAME + self.curtain_animation_time
	self.TIME_OPEN_CURTAINS = self.TIME_CLOSE_CURTAINS + self.curtain_animation_time
	self.elapsed_time = 0

	self.has_changed = false
	self.show_results = false


end


function PlayState:update(dt)

	if not self.show_results then
		self.elapsed_time = self.elapsed_time + dt
	end

	-- si nos pasamos del tempo de juego
	if self.elapsed_time >= self.TIME_PER_MINIGAME and not self.show_results then

		-- si no han acabado de cerrarse las cortinas
		if self.elapsed_time <= self.TIME_CLOSE_CURTAINS then
			if self.left_curtain_animation_position < 0 then
				self.left_curtain_animation_position = self.left_curtain_animation_position + 768 * dt / self.curtain_animation_time
				self.right_curtain_animation_position = self.right_curtain_animation_position - 768 * dt / self.curtain_animation_time
			end
		elseif self.elapsed_time <= self.TIME_OPEN_CURTAINS then
			-- si no se ha cambiado de minijuego
			if #self.minigames > 0 and not self.has_changed then
				self:saveScores()
				table.remove(self.minigames, #self.minigames)
				self.level = self.minigames[#self.minigames].level
				self:setScores()
				self.has_changed = true
			end

			if self.left_curtain_animation_position > -Constants.DEFAULT_WIDTH / 2 then
				self.left_curtain_animation_position = self.left_curtain_animation_position - 768 * dt / self.curtain_animation_time
				self.right_curtain_animation_position = self.right_curtain_animation_position + 768 * dt / self.curtain_animation_time
			end
		else
			self.elapsed_time = 0
			self.has_changed = false
			if #self.minigames == 0 then
				self.show_results = true
			end
		end
	else
		self.minigames[#self.minigames]:update(dt)
	end
end


function PlayState:draw()
	self.minigames[#self.minigames]:draw()

	if self.elapsed_time >= self.TIME_PER_MINIGAME then
		love.graphics.draw(self.curtain, self.left_curtain_animation_position, 0)
		love.graphics.draw(self.curtain, self.right_curtain_animation_position, 0)
	end

	love.graphics.setColor(0, 0, 0, 0.5)

	if self.TIME_PER_MINIGAME - self.elapsed_time > 0 and #self.minigames ~= 0 then
		local box_color = {0, 0, 0}
		local text_color = {1, 1, 1}
		local key_size = 40
		local pos = {Constants.DEFAULT_WIDTH - 115, 35}
		local time = TextBox:new( tostring(math.abs(math.ceil(self.TIME_PER_MINIGAME - self.elapsed_time))), pos[1], pos[2], key_size * 2, key_size, 22, 1, text_color, box_color) -- text, posX, posY, sizeW, sizeH, textSize
		time:draw()
	end



end

function PlayState:handleEvent(object, event)
	if self.elapsed_time < self.TIME_PER_MINIGAME then
		self.minigames[#self.minigames]:handleEvent(object, event)
	end
end


function PlayState:handleEventBetweenObjects(object_a, object_b, event)
	if self.elapsed_time < self.TIME_PER_MINIGAME then
		self.minigames[#self.minigames]:handleEventBetweenObjects(object_a, object_b, event)
	end

end

function PlayState:handleInternalEvent(event)
	if self.elapsed_time < self.TIME_PER_MINIGAME then
		self.minigames[#self.minigames]:handleInternalEvent(event)
	end
end

function PlayState:saveScores()
	for index, player in pairs(self.level.players) do
		self.scores[index] = player:getScore()
	end
end



function PlayState:setScores()
	for index, player in pairs(self.level.players) do
		player:setScore(self.scores[index])
	end


	if #self.minigames == 0 then
		local num = 1
		local _, best = max_item(self.scores)

		self.minigames[0]:setBestScore(best)

		while (num <= table_size(self.scores)) do
			local jugador, _ = max_item(self.scores)
			self.scores[jugador] = -1
			local x_pos =  self.level.spawnpoints["spawn" .. num].x
			local y_pos = self.level.spawnpoints["spawn" .. num].y
			self.level.players[jugador]:respawn(x_pos, y_pos)
			num = num + 1
		end
	end

end

function PlayState:numPlayersInPlatform(num_platform)
	return self.minigames[0].players_in_platform[num_platform]
end



function PlayState:keyPressed(k)
	self.minigames[#self.minigames]:keyPressed(k)
end

function PlayState:textEdited(text, start, length)
	self.minigames[#self.minigames]:textEdited(text, start, length)

end

function PlayState:textInput(t)
	self.minigames[#self.minigames]:textInput(t)
end
