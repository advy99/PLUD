require("player")
require("handle_input")
require("constants")
require("platform")


function love.load()

	local LIP = require "LIP"

	config = LIP.load("config.ini")
	love.window.setMode(config.screen.width, config.screen.height, {vsync = config.screen.vsync, fullscreen = config.screen.fullscreen})
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	local px_per_meter = 64
	love.physics.setMeter(px_per_meter)
	world = love.physics.newWorld(0, Constants.GRAVITY * px_per_meter, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	objects = {}

	objects.player1 = Player:newPlayer(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, "player1")
	objects.player2 = Player:newPlayer(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player2")

	objects.platform = Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 100, love.graphics.getWidth(), 50, "up_platform")
	objects.platformR = Platform:newPlatform(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 250, love.graphics.getWidth()/5, 50, "down_platform")

end

function love.update(dt)
	world:update(dt)

	objects.player1:update(dt)
	objects.player2:update(dt)

	handleKeyboard(dt)
end

function love.keypressed(k)
   if k == 'escape' then
      love.event.quit()
   end
end

function love.draw()

	for _, object in pairs(objects) do
		object:draw()
	end

end

function beginContact(a, b, coll)

	if a:getCategory() == Constants.PLAYER_CATEGORY and b:getCategory() == Constants.PLATFORM_CATEGORY then
		if a:getUserData() == "player1" then
			objects.player1:setMode("grounded")
		elseif a:getUserData() == "player2" then
			objects.player2:setMode("grounded")
		end
	end

	if b:getCategory() == Constants.PLAYER_CATEGORY and a:getCategory() == Constants.PLATFORM_CATEGORY then
		if b:getUserData() == "player1" then
			objects.player1:setMode("grounded")
		elseif b:getUserData() == "player2" then
			objects.player2:setMode("grounded")
		end
	end


end

function endContact(a, b, coll)

	if a:getCategory() == Constants.PLAYER_CATEGORY and b:getCategory() == Constants.PLATFORM_CATEGORY then
		if a:getUserData() == "player1" and objects.player1:getMode() ~= "jumping" then
			objects.player1:setMode("falling")
		elseif a:getUserData() == "player2" and objects.player2:getMode() ~= "jumping" then
			objects.player2:setMode("falling")
		end
	end

	if b:getCategory() == Constants.PLAYER_CATEGORY and a:getCategory() == Constants.PLATFORM_CATEGORY then
		if b:getUserData() == "player1" and objects.player1:getMode() ~= "jumping" then
			objects.player1:setMode("falling")
		elseif b:getUserData() == "player2" and objects.player2:getMode() ~= "jumping" then
			objects.player2:setMode("falling")
		end
	end
end

function preSolve(a, b, coll)

end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
