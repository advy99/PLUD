local class = require "lib/middleclass"
local sti = require "lib/sti"

Level = class("Level")


-- Constructor de la clase nivel, recibe como argumento el nivel a crear
function Level:initialize(level_name, num_players)

	-- creamos el mundo
	self.world = love.physics.newWorld(0, Constants.GRAVITY * Constants.PX_PER_METER, true)
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- creamos los objetos dentro del mundo
	self.players = {}

	-- cargamos el mapa asociado
	self.map = sti("maps/" .. level_name .. ".lua", { "box2d" })
	self.map:box2d_init(self.world)

	-- guardamos el nombre del nivel
	self.level_name = level_name

	for i=1, num_players, 1
	do
		self:addPlayer(i)
	end

end

function Level:update(dt)
	-- actualizamos el mundo
	self.world:update(dt)
	self.map:update(dt)
	-- para cada objeto, llamamos a su respectivo update
	for _, object in pairs(self.players) do
		object:update(dt)
	end
end

function Level:draw()
	love.graphics.reset()

	self.map:draw()

	-- para cuando nos pongamos a escalar el mapa
	-- self.map:draw(0,0,scale,scale)

	-- para cada objeto, llamamos a su respectivo draw
	for _, object in pairs(self.players) do
		object:draw()
	end

	if Constants.SHOW_HITBOX then
		-- Draw Collision Map (useful for debugging)
		love.graphics.setColor(1, 0, 0)
		self.map:box2d_draw()
	end

end

-- Funcion para crear los objetos de un nivel en un mundo
-- Devuelve los objetos que componen ese nivel
function Level:addPlayer(num_player)
	local sprite_sheet = nil

	if num_player == 1 then
		sprite_sheet = love.graphics.newImage("img/blue_slime_atlas.png")
	elseif num_player == 2 then
		sprite_sheet = love.graphics.newImage("img/red_slime_atlas.png")
	elseif num_player == 3 then
		sprite_sheet = love.graphics.newImage("img/green_slime_atlas.png")
	elseif num_player == 4 then
		sprite_sheet = love.graphics.newImage("img/yellow_slime_atlas.png")
	end

	local player_name = "player" .. num_player

	self.players[player_name] = Player:new(self.world, 300, love.graphics.getHeight() / 2, sprite_sheet, player_name )

end

function Level:removePlayer(num_player)
	local player_name = "player" .. num_player

	self.players[player_name]:destroy()
	self.players[player_name] = nil
end
