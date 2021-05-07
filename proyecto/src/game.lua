
require("src/handler/handle_collisions")
require("src/enums/events")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()
	self.world = love.physics.newWorld(0, Constants.GRAVITY * Constants.PX_PER_METER, true)
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	self.objects = create_level_1(self.world)
	self.map = sti("maps/prueba.lua", { "box2d" })
	self.map:box2d_init(self.world)

end


function Game:update(dt)

	-- actualizamos el mundo
	self.world:update(dt)
	self.map:update(dt)
	-- para cada objeto, llamamos a su respectivo update
	for _, object in pairs(self.objects) do
		object:update(dt)
	end

end

function Game:draw()
	-- para cada objeto, llamamos a su respectivo draw
	for _, object in pairs(self.objects) do
		object:draw()
	end

	love.graphics.setColor(1, 1, 1)
	self.map:draw()
	--
	-- -- Draw Collision Map (useful for debugging)
	-- love.graphics.setColor(1, 0, 0)
	-- map:box2d_draw()

end


function Game:handleEvent(object, event)

	if event == Events.PLAYER_LAND_PLATFORM then
		self.objects[object]:setMode("grounded")

	elseif event == Events.PLAYER_LEAVE_PLATFORM then

		if self.objects[object]:getMode() ~= "jumping" then
			self.objects[object]:setMode("falling")
		end

	end

end
