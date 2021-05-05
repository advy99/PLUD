--
-- Fichero principal de Love2D
--
--
--


require("src/player")
require("src/handle_input")
require("src/constants")
require("src/platform")
require("src/load_levels")



-- Funcion load de Love2D
-- Esta función se ejecutará una única vez al inicio del juego
-- Cargaremos toda la configuración inicial
function love.load()

	-- cargamos el modulo LIP, para leer y escribir archivos ini
	local LIP = require "src/LIP"

	-- cargamos la configuración
	local config = LIP.load("config/config.ini")

	-- establecemos la configuración de la ventana y la semilla aleatoria
	love.window.setMode(config.screen.width, config.screen.height, {vsync = config.screen.vsync, fullscreen = config.screen.fullscreen})
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	-- Creamos un mundo nuevo y asignamos la funciones que gestionarán las colisiones
	love.physics.setMeter(Constants.PX_PER_METER)
	world = love.physics.newWorld(0, Constants.GRAVITY * Constants.PX_PER_METER, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- objetos que estarán en nuestro mundo
	objects = {}

	create_level_1()


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
