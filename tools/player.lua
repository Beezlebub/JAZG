
function playerLoad()
	player = {}
	player.x = 2000
	player.y = 2000
	player.rad = 10
	player.speed = 50

end

function playerUpdate(dt)
	if lk.isDown("w") then
		player.y = player.y - player.speed * dt
	elseif lk.isDown("s") then
		player.y = player.y + player.speed * dt
	end

	if lk.isDown("a") then
		player.x = player.x - player.speed * dt
	elseif lk.isDown("d") then
		player.x = player.x + player.speed * dt
	end


end

function playerDraw()
	drawCircle(player, {200,200,200} )
end
