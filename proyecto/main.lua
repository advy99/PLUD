--
-- Fichero principal de Love2D
--
--
--


require("player")
require("handle_input")
require("constants")
require("platform")


-- Funcion load de Love2D
-- Esta función se ejecutará una única vez al inicio del juego
-- Cargaremos toda la configuración inicial
function love.load()

	-- cargamos el modulo LIP, para leer y escribir archivos ini
	local LIP = require "LIP"

	-- cargamos la configuración
	config = LIP.load("config.ini")

	-- establecemos la configuración de la ventana y la semilla aleatoria
	love.window.setMode(config.screen.width, config.screen.height, {vsync = config.screen.vsync, fullscreen = config.screen.fullscreen})
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	-- Creamos un mundo nuevo y asignamos la funciones que gestionarán las colisiones
	love.physics.setMeter(Constants.PX_PER_METER)
	world = love.physics.newWorld(0, Constants.GRAVITY * px_per_meter, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- objetos que estarán en nuestro mundo
	objects = {}

	-- dos jugadores
	objects.player1 = Player:newPlayer(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player1")
	objects.player2 = Player:newPlayer(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player2")

	-- plataforma a la izquierda, con un sensor en la parte superior
	objects.platformL = Platform:newPlatform(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformL:addSensor("up")

	-- plataforma a la derecha, con un sensor en la parte superior
	objects.platformR = Platform:newPlatform(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformR:addSensor("up")

	-- suelo, con un sensor en la parte superior, y techo
	objects.floor= Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight(), love.graphics.getWidth(), 50, "floor")
	objects.floor:addSensor("up")
	objects.roof= Platform:newPlatform(world, love.graphics.getWidth() / 2, 0, love.graphics.getWidth(), 50, "roof")

	-- muros a la izquierda y derecha
	-- con sensores en la parte contraria, para que sea la parte interna la que detecta la colision
	objects.left_wall = Platform:newPlatform(world, 0, love.graphics.getHeight() / 2, 50, love.graphics.getHeight(),"left_wall")
	objects.left_wall:addSensor("right")
	objects.right_wall = Platform:newPlatform(world, love.graphics.getWidth(), love.graphics.getHeight() / 2, 50, love.graphics.getHeight(), "right_wall")
	objects.right_wall:addSensor("left")

	-- muro central
	objects.middle_wall = Platform:newPlatform(world, love.graphics.getWidth() / 2, 3 * love.graphics.getHeight() / 4, 50, love.graphics.getHeight() / 2, "middle_wall")
	objects.middle_wall:addSensor("left")
	objects.middle_wall:addSensor("right")
	objects.middle_wall:addSensor("up")



end

-- Funcion de actualización del mundo de Love2D
-- Es llamada cada frame
-- dt: Tiempo transcurrido desde el último frame
function love.update(dt)
	-- actualizamos el mundo
	world:update(dt)

	-- para cada objeto, llamamos a su respectivo update
	for _, object in pairs(objects) do
		object:update(dt)
	end

	-- gestionamos la entrada por teclado
	handleKeyboard(dt)
end


-- Funcion draw de Love2D
-- Esta funcion es la que se encarga de dibujar los objetos
function love.draw()

	-- Para cada objetos, llamamos a su respectiva forma de dibujarse
	for _, object in pairs(objects) do
		object:draw()
	end

end

-- Funcion que se ejecutará cuando se detecta una colisión
function beginContact(a, b, coll)

	-- Si colisionan un jugador y un un sensor de una plataforma, el jugador para al estado grounded
	if a:getCategory() == Constants.PLAYER_CATEGORY and b:getCategory() == Constants.PLATFORM_CATEGORY then
		if a:getUserData() == "player1" then
			objects.player1:setMode("grounded")
		elseif a:getUserData() == "player2" then
			objects.player2:setMode("grounded")
		end
	end

	-- lo mismo, pero por si se pasa a y b intercam
	if b:getCategory() == Constants.PLAYER_CATEGORY and a:getCategory() == Constants.PLATFORM_CATEGORY then
		if b:getUserData() == "player1" then
			objects.player1:setMode("grounded")
		elseif b:getUserData() == "player2" then
			objects.player2:setMode("grounded")
		end
	end


end

-- Función que se ejecutará cuando finaliza una colisión
function endContact(a, b, coll)

	-- Si es un jugador y una plataforma, y el jugador no estaba saltando, pasa a cayendo.
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

-- funcion que se ejecuta antes de resolver una colision
function preSolve(a, b, coll)

end

-- funcion que se ejecuta despues de resolver una colision
function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
