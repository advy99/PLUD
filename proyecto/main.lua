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

	objects.player1 = Player:newPlayer(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player1")
	objects.player2 = Player:newPlayer(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player2")

	objects.platformL = Platform:newPlatform(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformL:addSensor("up")

	objects.platformR = Platform:newPlatform(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformR:addSensor("up")

	objects.floor= Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight(), love.graphics.getWidth(), 50, "floor")
	objects.floor:addSensor("up")
	objects.roof= Platform:newPlatform(world, love.graphics.getWidth() / 2, 0, love.graphics.getWidth(), 50, "roof")

	objects.left_wall = Platform:newPlatform(world, 0, love.graphics.getHeight() / 2, 50, love.graphics.getHeight(),"left_wall")
	objects.left_wall:addSensor("right")
	objects.right_wall = Platform:newPlatform(world, love.graphics.getWidth(), love.graphics.getHeight() / 2, 50, love.graphics.getHeight(), "right_wall")
	objects.right_wall:addSensor("left")

	objects.middle_wall = Platform:newPlatform(world, love.graphics.getWidth() / 2, 3 * love.graphics.getHeight() / 4, 50, love.graphics.getHeight() / 2, "middle_wall")
	objects.middle_wall:addSensor("left")
	objects.middle_wall:addSensor("right")
	objects.middle_wall:addSensor("up")



end

function love.update(dt)
	world:update(dt)

	for _, object in pairs(objects) do
		object:update(dt)
	end

	handleKeyboard(dt)
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
