require("src/enums/events")

-- Funcion que se ejecutará cuando se detecta una colisión
function beginContact(a, b, coll)

	local category_a, mask_a, group_a = a:getFilterData()
	local category_b, mask_b, group_b = b:getFilterData()


	-- Si colisionan un jugador y un un sensor de una plataforma, el jugador para al estado grounded
	if a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP then
		game:handleEvent(a:getUserData(), Events.PLAYER_LAND_PLATFORM)
	end

	-- lo mismo, pero por si se pasa a y b intercam
	if b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP then
		game:handleEvent(b:getUserData(), Events.PLAYER_LAND_PLATFORM)
	end


	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PLAY_CATEGORY) or
	 	(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PLAY_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_PLAY)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_CONFIGURATION_CATEGORY) or
	 	(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_CONFIGURATION_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_CONFIGURATION)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PRACTICE_CATEGORY) or
		(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PRACTICE_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_PRACTICE)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_EXIT_CATEGORY) or
		(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_EXIT_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_EXIT)

	end


	if b:getGroupIndex() == Constants.PLAYER_GROUP and a:getGroupIndex() == Constants.PLAYER_GROUP then
		game:handleEventBetweenObjects(a:getUserData(), b:getUserData(), Events.PLAYERS_COLLIDE)
	end

end

-- Función que se ejecutará cuando finaliza una colisión
function endContact(a, b, coll)

	-- Si es un jugador y una plataforma, y el jugador no estaba saltando, pasa a cayendo.
	if a:getGroupIndex() == Constants.PLAYER_GROUP and b:getGroupIndex() == Constants.PLATFORM_GROUP then
		game:handleEvent(a:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
	end

	if b:getGroupIndex() == Constants.PLAYER_GROUP and a:getGroupIndex() == Constants.PLATFORM_GROUP then
		game:handleEvent(b:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
	end


	-- si sale de una plataforma con contador
	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PLAY_CATEGORY) or
	 	(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PLAY_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_PLAY)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_CONFIGURATION_CATEGORY) or
	 	(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_CONFIGURATION_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_CONFIGURATION)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PRACTICE_CATEGORY) or
		(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PRACTICE_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_PRACTICE)

	end

	if (a:getGroupIndex() == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_EXIT_CATEGORY) or
		(b:getGroupIndex() == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_EXIT_CATEGORY) then

		game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_EXIT)

	end

end

-- funcion que se ejecuta antes de resolver una colision
function preSolve(a, b, coll)

end

-- funcion que se ejecuta despues de resolver una colision
function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
