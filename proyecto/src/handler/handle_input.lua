
function handleKeyboard(dt)

	if game.level.objects.player1 ~= nil then

		if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
			game.level.objects.player1:move(1)
		end

		if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
			game.level.objects.player1:move(-1)
		end
	end

	if game.level.objects.player2 ~= nil then

		if love.keyboard.isDown("d") then --press the right arrow key to push the ball to the right
			game.level.objects.player2:move(1)
		end

		if love.keyboard.isDown("a") then --press the left arrow key to push the ball to the left
			game.level.objects.player2:move(-1)
		end
	end

end


function love.keypressed(k)
   if k == 'escape' then
		if game.level.level_name == "level_menu" then
			love.event.quit()
		else
			game:loadLevel("level_menu")
		end
   end

	if game.level.objects.player1 ~= nil then
		if k == "enter" then
			game.level.objects.player1:attack()
		end


		if k == "t" then
			game.level.objects.player1:kill()
		end

		if k == "up" then --press the up arrow key to set the ball in the air
			game.level.objects.player1:jump()
		end
	end

	if game.level.objects.player2 ~= nil then

		if k == "e" then
			game.level.objects.player2:attack()
		end

		if k == "w" then --press the up arrow key to set the ball in the air
			game.level.objects.player2:jump()
		end
	end


end

function love.keyreleased(k)
	if game.level.objects.player2 ~= nil then
		if k == "a" or k == "d" then
			game.level.objects.player2:stopWalking()
		end
	end

	if game.level.objects.player1 ~= nil then
		if k == "left" or k == "right" then
			game.level.objects.player1:stopWalking()
		end
	end
end
