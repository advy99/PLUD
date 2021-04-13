
function handleKeyboard(dt)
	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		objects.player1:move(1,0)
	end

	if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		objects.player1:move(-1, 0)
	end

	if love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
		objects.player1:jump()
	end

	if love.keyboard.isDown("down") then --press the up arrow key to set the ball in the air
		objects.player1:move(0,-1)
	end


	if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
		objects.player2:move(1,0)
	end

	if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
		objects.player2:move(-1, 0)
	end

	if love.keyboard.isDown("w") then --press the up arrow key to set the ball in the air
		objects.player2:jump()
	end

	if love.keyboard.isDown("s") then --press the up arrow key to set the ball in the air
		objects.player2:move(0,-1)
	end


end
