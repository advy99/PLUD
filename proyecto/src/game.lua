
require("src/handler/handle_collisions")
require("src/enums/events")


local class = require "lib/middleclass"
local sti = require "lib/sti"

Game = class("Game")


function Game:initialize()
	self.world = nil
	self.objects = {}

	self.level = "level_menu"
	self:loadLevel(self.level)

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

end


function Game:handleEvent(object, event)

	if event == Events.PLAYER_LAND_PLATFORM then
		self.objects[object]:setMode("grounded")

	elseif event == Events.PLAYER_LEAVE_PLATFORM then

		if self.objects[object]:getMode() ~= "jumping" then
			self.objects[object]:setMode("falling")
		end

	elseif event == Events.EXIT_GAME then
		love.event.quit()

	elseif event == Events.LOAD_LEVEL1 then
		self:loadLevel("level_1")
	end

end


function Game:loadLevel(level_name)

	if self.world ~= nil then
		self.world:destroy()
	end

	self.world = love.physics.newWorld(0, Constants.GRAVITY * Constants.PX_PER_METER, true)
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	self.objects = create_objects(self.world, level_name)

	self.map = sti("maps/" .. level_name .. ".lua", { "box2d" })
	self.map:box2d_init(self.world)

	self.level = level_name
end
