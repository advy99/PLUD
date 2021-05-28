--
-- Fichero principal de Love2D
--
--
--


require("src/game")
require("src/game_objects/player")
require("src/enums/constants")
require("src/game_objects/platform")



-- Funcion load de Love2D
-- Esta función se ejecutará una única vez al inicio del juego
-- Cargaremos toda la configuración inicial
function love.load()

	-- cargamos el modulo LIP, para leer y escribir archivos ini
	local LIP = require "lib/LIP"

	-- cargamos la configuración
	local config = LIP.load("config/config.ini")

	flags = {vsync = config.screen.vsync, fullscreen = config.screen.fullscreen, resizable = true}

	-- establecemos la configuración de la ventana y la semilla aleatoria
	love.window.setMode(Constants.DEFAULT_WIDTH, Constants.DEFAULT_HEIGHT, flags)
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	-- Creamos un mundo nuevo y asignamos la funciones que gestionarán las colisiones
	love.physics.setMeter(Constants.PX_PER_METER)

	-- scale = 1
	game = Game:new()


end

-- Funcion de actualización del mundo de Love2D
-- Es llamada cada frame
-- dt: Tiempo transcurrido desde el último frame
function love.update(dt)

	game:update(dt)

	-- gestionamos la entrada por teclado
	game:handleKeyboard(dt)
end


-- Funcion draw de Love2D
-- Esta funcion es la que se encarga de dibujar los objetos
function love.draw()
	-- love.physics.setMeter(Constants.PX_PER_METER * scale)
	love.physics.setMeter(Constants.PX_PER_METER)

	game:draw()

end

-- TODO Para hacer pruebas más adelante
-- function love.resize(w, h)
-- 	scale = w / Constants.DEFAULT_WIDTH
--
-- 	love.window.updateMode( w, Constants.DEFAULT_HEIGHT * scale )
-- end

function love.keypressed(k)
	game:keyPressed(k)
end

function love.keyreleased(k)
	game:keyReleased(k)

end
