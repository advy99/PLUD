
function create_objects(world, level_name)
	local sprite_sheet_player1 = love.graphics.newImage("img/blue_slime_atlas.png")
	local sprite_sheet_player2 = love.graphics.newImage("img/red_slime_atlas.png")

	local objects = {}

	if level_name == "level_menu" then
		-- dos jugadores
		objects.player1 = Player:new(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, sprite_sheet_player1, "player1")
	elseif level_name == "level_1" then
		objects.player1 = Player:new(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, sprite_sheet_player1, "player1")
		objects.player2 = Player:new(world, 3 * love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, sprite_sheet_player2, "player2")

	end

	return objects

end
