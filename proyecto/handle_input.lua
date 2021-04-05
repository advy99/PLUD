
function handleKeyboard(dt)
	if love.keyboard.isDown("a") then
		player1:move(-1, dt)
	elseif love.keyboard.isDown("d")  then
		player1:move(1, dt)
	elseif love.keyboard.isDown("w") then
		player1:jump()
	end

	if  love.keyboard.isDown("left")  then
		player2:move(-1, dt)
	elseif  love.keyboard.isDown("right")  then
		player2:move(1, dt)
	elseif love.keyboard.isDown("up") then
		player2:jump()
	end
end
