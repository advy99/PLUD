local class = require "lib/middleclass"


MiniGame = class("MiniGame")

function MiniGame:initialize(minigame_level, num_players)

	self.level = Level:new(minigame_level, num_players)

end


function MiniGame:update(dt)

	self.level:update(dt)

end


function MiniGame:draw()
	self.level:draw()

end

function MiniGame:loadLevel(level_name)
	self.level = Level:new(level_name)
end


function MiniGame:handleInternalEvent(event)

end

function MiniGame:getNumPlayers()
	return table_size(self.level.players)
end

function MiniGame:handleEvent(object, event)

	-- no debería pasar nunca, ya que el objeto está en el nivel, pero por si acaso
	if self.level.players[object] ~= nil then

		if event == Events.PLAYER_LAND_PLATFORM then
			self.level.players[object]:setMode("grounded")

		elseif event == Events.PLAYER_LEAVE_PLATFORM then

			if self.level.players[object]:getMode() ~= "jumping" then
				self.level.players[object]:setMode("falling")
			end

		elseif event == Events.EXIT_GAME then
			love.event.quit()			
		end
	end

end



function MiniGame:handleEventBetweenObjects(object_a, object_b, event)

end

function MiniGame:mouseMoved(x, y)

end

function MiniGame:addPlayer(num_player)
	self.level:addPlayer(num_player)
end

function MiniGame:removePlayer(num_player)
	self.level:removePlayer(num_player)
end
