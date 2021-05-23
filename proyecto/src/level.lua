local class = require "lib/middleclass"
local sti = require "lib/sti"


-- Funcion para crear los objetos de un nivel en un mundo
-- Devuelve los objetos que componen ese nivel
function create_objects(world, level_name)
	local sprite_sheet_player1 = love.graphics.newImage("img/blue_slime_atlas.png")
	local sprite_sheet_player2 = love.graphics.newImage("img/red_slime_atlas.png")

	local objects = {}

	local pos_x_player1 = love.graphics.getWidth() / 4


	if level_name == "level_menu" then
		pos_x_player1 = love.graphics.getWidth() / 2
	else
		objects.player2 = Player:new(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, sprite_sheet_player2, "player2")
	end

	objects.player1 = Player:new(world, pos_x_player1, love.graphics.getHeight() / 2, sprite_sheet_player1, "player1")

	return objects

end




Level = class("Level")


-- Constructor de la clase nivel, recibe como argumento el nivel a crear
function Level:initialize(level_name)

	-- creamos el mundo
	self.world = love.physics.newWorld(0, Constants.GRAVITY * Constants.PX_PER_METER, true)
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- creamos los objetos dentro del mundo
	self.objects = create_objects(self.world, level_name)

	-- cargamos el mapa asociado
	self.map = sti("maps/" .. level_name .. ".lua", { "box2d" })
	self.map:box2d_init(self.world)

	-- guardamos el nombre del nivel
	self.level_name = level_name

end

function Level:update(dt)
	-- actualizamos el mundo
	self.world:update(dt)
	self.map:update(dt)
	-- para cada objeto, llamamos a su respectivo update
	for _, object in pairs(self.objects) do
		object:update(dt)
	end
end

function Level:draw()
	love.graphics.setColor(1, 1, 1)
	self.map:draw()

	-- para cada objeto, llamamos a su respectivo draw
	for _, object in pairs(self.objects) do
		object:draw()
	end

	if Constants.SHOW_HITBOX then
		-- Draw Collision Map (useful for debugging)
		love.graphics.setColor(1, 0, 0)
		self.map:box2d_draw()
	end

	if self.level_name == "level_menu" then
		-- prueba de fuentes
		local mainFont = love.graphics.newFont("fonts/kirbyss.ttf", 50)
		love.graphics.setFont(mainFont)
		love.graphics.printf("JUGAR", -love.graphics.getWidth() * 0.165 ,  love.graphics.getHeight() * 0.825, 1000, "center")
		love.graphics.printf("SALIR", love.graphics.getWidth() * 0.385,  love.graphics.getHeight() * 0.825, 1000, "center")

	end

end
