
function zombiesLoad()
	zombie = {}

	for i = 1, 20 do
		zombie[i] = {}
		zombie[i].x = math.random(player.x - lg.getWidth()/2, player.x + lg.getWidth()/2)
		zombie[i].y = math.random(player.y - lg.getHeight()/2, player.y + lg.getHeight()/2)
		zombie[i].rad = 10
		zombie[i].speed = math.random(5, 15)
		zombie[i].health = 100
	end
end

function zombiesUpdate(dt)
	for i = #zombie, 1, -1 do
		if player.x > zombie[i].x then
			zombie[i].x = zombie[i].x + zombie[i].speed * dt
		else
			zombie[i].x = zombie[i].x - zombie[i].speed * dt
		end

		if player.y > zombie[i].y then
			zombie[i].y = zombie[i].y + zombie[i].speed * dt
		else
			zombie[i].y = zombie[i].y - zombie[i].speed * dt
		end
	end
end

function zombiesDraw()
	for i = #zombie, 1, -1 do
		drawCircle(zombie[i], {200,50,50} )
	end
end
