--
-- Fichero principal de Love2D
--
--
--


require("src/game")
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
	local LIP = require "lib/LIP"

	-- cargamos la configuración
	local config = LIP.load("config/config.ini")

	-- establecemos la configuración de la ventana y la semilla aleatoria
	love.window.setMode(config.screen.width, config.screen.height, {vsync = config.screen.vsync, fullscreen = config.screen.fullscreen})
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	-- Creamos un mundo nuevo y asignamos la funciones que gestionarán las colisiones
	love.physics.setMeter(Constants.PX_PER_METER)

	game = Game:new()


end

-- Funcion de actualización del mundo de Love2D
-- Es llamada cada frame
-- dt: Tiempo transcurrido desde el último frame
function love.update(dt)

	game:update(dt)

	-- gestionamos la entrada por teclado
	handleKeyboard(dt)
end


-- Funcion draw de Love2D
-- Esta funcion es la que se encarga de dibujar los objetos
function love.draw()

	game:draw()

end
