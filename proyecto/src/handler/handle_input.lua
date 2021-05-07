
function handleKeyboard(dt)

	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		game.objects.player1:move(1)
	end

	if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		game.objects.player1:move(-1)
	end


	if game.level == "level_1" then

		if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
			game.objects.player2:move(1)
		end

		if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
			game.objects.player2:move(-1)
		end
	end

end


function love.keypressed(k)
   if k == 'escape' then
		if game.level == "level_menu" then
			love.event.quit()
		else
			game:loadLevel("level_menu")
		end
   end


	if k == "enter" then
		game.objects.player1:attack()
	end

	if k == "t" then
		game.objects.player1:kill()
	end

	if k == "up" then --press the up arrow key to set the ball in the air
		game.objects.player1:jump()
	end

	if game.level == "level_1" then

		if k == "e" then
			game.objects.player2:attack()
		end

		if k == "w" then --press the up arrow key to set the ball in the air
			game.objects.player2:jump()
		end
	end


end

function love.keyreleased(k)
	if game.level == "level_1" then

		if k == "a" or k == "d" then
			game.objects.player2:stopWalking()
		end
	end

	if k == "left" or k == "right" then
		game.objects.player1:stopWalking()
	end
end
