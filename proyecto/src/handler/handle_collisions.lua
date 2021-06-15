require("src/enums/events")

local ball_can_touch = true

-- Funcion que se ejecutará cuando se detecta una colisión
function beginContact(a, b, coll)

	local category_a, mask_a, group_a = a:getFilterData()
	local category_b, mask_b, group_b = b:getFilterData()

	if not a:isSensor() and not b:isSensor() then

		-- Si colisionan un jugador y un un sensor de una plataforma, el jugador para al estado grounded
		if group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP then
			game:handleEvent(a:getUserData(), Events.PLAYER_LAND_PLATFORM)
		-- lo mismo, pero por si se pasa a y b intercam
		elseif group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP then
			game:handleEvent(b:getUserData(), Events.PLAYER_LAND_PLATFORM)
		end


		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PLAY_CATEGORY) or
		 	(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PLAY_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_PLAY)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_BOMB_TAG_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_BOMB_TAG_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_BOMB_TAG)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_VIRUS_FALL_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_VIRUS_FALL_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_VIRUS_FALL)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_DEATH_BALL_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_DEATH_BALL_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_DEATH_BALL)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_CONFIGURATION_CATEGORY) or
		 	(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_CONFIGURATION_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_CONFIGURATION)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PRACTICE_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PRACTICE_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_PRACTICE)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_EXIT_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_EXIT_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_EXIT)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_MENU_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_MENU_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_MENU)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_SAVE_CONFIG_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_SAVE_CONFIG_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LAND_PLATFORM_SAVE_CONFIG_AND_MENU)

		end

		-- Si colisionan un jugador y un un sensor de una plataforma, el jugador para al estado grounded
		if group_a == Constants.PLAYER_GROUP and group_b == Constants.OBJECTS_GROUP and category_b == Constants.DEATH_BALL_CATEGORY then
			game:handleEvent(a:getUserData(), Events.PLAYER_TOUCHED_DEATH_BALL)
		-- lo mismo, pero por si se pasa a y b intercam
		elseif group_b == Constants.PLAYER_GROUP and group_a == Constants.OBJECTS_GROUP and category_a == Constants.DEATH_BALL_CATEGORY then
			game:handleEvent(b:getUserData(), Events.PLAYER_TOUCHED_DEATH_BALL)
		end



		if group_a == Constants.PLAYER_GROUP and group_b == Constants.PLAYER_GROUP then
			game:handleEventBetweenObjects(a:getUserData(), b:getUserData(), Events.PLAYERS_COLLIDE)
		end

		if (group_a == Constants.OBJECTS_GROUP and category_a == Constants.DEATH_BALL_CATEGORY or
			group_b == Constants.OBJECTS_GROUP and category_b == Constants.DEATH_BALL_CATEGORY) and ball_can_touch then
			-- cogemos la normal, y cambiamos
	
			game:handleEvent(coll, Events.DEATH_BALL_COLLISION)

			ball_can_touch = false
		end

	else

		if group_a == Constants.PLAYER_GROUP and not a:isSensor() and
			group_b == Constants.OBJECTS_GROUP and category_b == Constants.VIRUS_CATEGORY then

			game:handleEvent(a:getUserData(), Events.PLAYER_TOUCHED_VIRUS)

		elseif group_b == Constants.PLAYER_GROUP and not b:isSensor() and
				 group_a == Constants.OBJECTS_GROUP and category_a == Constants.VIRUS_CATEGORY then

			game:handleEvent(b:getUserData(), Events.PLAYER_TOUCHED_VIRUS)

		end

	end


end

-- Función que se ejecutará cuando finaliza una colisión
function endContact(a, b, coll)

	local category_a, mask_a, group_a = a:getFilterData()
	local category_b, mask_b, group_b = b:getFilterData()

	if not a:isSensor() and not b:isSensor() then

		-- Si es un jugador y una plataforma, y el jugador no estaba saltando, pasa a cayendo.
		if group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP then
			game:handleEvent(a:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
		end

		if group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP then
			game:handleEvent(b:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
		end


		-- si sale de una plataforma con contador
		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PLAY_CATEGORY) or
		 	(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PLAY_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_PLAY)

		end


		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_CONFIGURATION_CATEGORY) or
		 	(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_CONFIGURATION_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_CONFIGURATION)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_PRACTICE_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_PRACTICE_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_PRACTICE)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_EXIT_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_EXIT_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_EXIT)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_MENU_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_MENU_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_MENU)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_SAVE_CONFIG_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_SAVE_CONFIG_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_SAVE_CONFIG_AND_MENU)

		end


		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_BOMB_TAG_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_BOMB_TAG_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_BOMB_TAG)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_VIRUS_FALL_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_VIRUS_FALL_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_VIRUS_FALL)

		end

		if (group_a == Constants.PLAYER_GROUP and group_b == Constants.PLATFORM_GROUP and category_b == Constants.PLATFORM_DEATH_BALL_CATEGORY) or
			(group_b == Constants.PLAYER_GROUP and group_a == Constants.PLATFORM_GROUP and category_a == Constants.PLATFORM_DEATH_BALL_CATEGORY) then

			game:handleInternalEvent(Events.PLAYER_LEAVE_PLATFORM_DEATH_BALL)

		end


		if (group_a == Constants.OBJECTS_GROUP and category_a == Constants.DEATH_BALL_CATEGORY or
			group_b == Constants.OBJECTS_GROUP and category_b == Constants.DEATH_BALL_CATEGORY)  then
			ball_can_touch = true

		end

	end

end

-- funcion que se ejecuta antes de resolver una colision
function preSolve(a, b, coll)

end

-- funcion que se ejecuta despues de resolver una colision
function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
