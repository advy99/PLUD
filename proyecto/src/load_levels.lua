
function create_level_1()
	local sprite_sheet_player1 = love.graphics.newImage("img/blue_slime_atlas.png")
	local sprite_sheet_player2 = love.graphics.newImage("img/red_slime_atlas.png")


	-- dos jugadores
	objects.player2 = Player:new(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, sprite_sheet_player2, "player2")
	objects.player1 = Player:new(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, sprite_sheet_player1, "player1")

	-- plataforma a la izquierda, con un sensor en la parte superior
	objects.platformL = Platform:new(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformL:addSensor("up")

	-- plataforma a la derecha, con un sensor en la parte superior
	objects.platformR = Platform:new(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() - 150, love.graphics.getWidth()/5, 50, "left_platform")
	objects.platformR:addSensor("up")

	-- suelo, con un sensor en la parte superior, y techo
	objects.floor= Platform:new(world, love.graphics.getWidth() / 2, love.graphics.getHeight(), love.graphics.getWidth(), 50, "floor")
	objects.floor:addSensor("up")
	objects.roof= Platform:new(world, love.graphics.getWidth() / 2, 0, love.graphics.getWidth(), 50, "roof")

	-- muros a la izquierda y derecha
	-- con sensores en la parte contraria, para que sea la parte interna la que detecta la colision
	objects.left_wall = Platform:new(world, 0, love.graphics.getHeight() / 2, 50, love.graphics.getHeight(),"left_wall")
	-- objects.left_wall:addSensor("right")
	objects.right_wall = Platform:new(world, love.graphics.getWidth(), love.graphics.getHeight() / 2, 50, love.graphics.getHeight(), "right_wall")
	-- objects.right_wall:addSensor("left")

	-- muro central
	objects.middle_wall = Platform:new(world, love.graphics.getWidth() / 2, 3 * love.graphics.getHeight() / 4, 50, love.graphics.getHeight() / 2, "middle_wall")
	-- objects.middle_wall:addSensor("left")
	-- objects.middle_wall:addSensor("right")
	-- objects.middle_wall:addSensor("up")

end
