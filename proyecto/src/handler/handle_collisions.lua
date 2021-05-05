require("src/enums/events")

-- Funcion que se ejecutará cuando se detecta una colisión
function beginContact(a, b, coll)

	-- Si colisionan un jugador y un un sensor de una plataforma, el jugador para al estado grounded
	if a:getCategory() == Constants.PLAYER_CATEGORY and b:getCategory() == Constants.PLATFORM_CATEGORY then
		game:handleEvent(a:getUserData(), Events.PLAYER_LAND_PLATFORM)
	end

	-- lo mismo, pero por si se pasa a y b intercam
	if b:getCategory() == Constants.PLAYER_CATEGORY and a:getCategory() == Constants.PLATFORM_CATEGORY then
		game:handleEvent(b:getUserData(), Events.PLAYER_LAND_PLATFORM)
	end

end

-- Función que se ejecutará cuando finaliza una colisión
function endContact(a, b, coll)

	-- Si es un jugador y una plataforma, y el jugador no estaba saltando, pasa a cayendo.
	if a:getCategory() == Constants.PLAYER_CATEGORY and b:getCategory() == Constants.PLATFORM_CATEGORY then
		game:handleEvent(a:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
	end

	if b:getCategory() == Constants.PLAYER_CATEGORY and a:getCategory() == Constants.PLATFORM_CATEGORY then
		game:handleEvent(b:getUserData(), Events.PLAYER_LEAVE_PLATFORM)
	end
end

-- funcion que se ejecuta antes de resolver una colision
function preSolve(a, b, coll)

end

-- funcion que se ejecuta despues de resolver una colision
function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
