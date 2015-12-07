player = class('player')

function player:initialize(x, y)
	self.x = x
	self.y = y
	self.rad = 20
	self.speed = 100
	self.health = 100
end

function player:update(dt)	
	if lk.isDown("w") then
		self.y = self.y - self.speed * dt
	elseif lk.isDown("s") then
		self.y = self.y + self.speed * dt
	end

	if lk.isDown("a") then
		self.x = self.x - self.speed * dt
	elseif lk.isDown("d") then
		self.x = self.x + self.speed * dt
	end

	for i = #zombie, 1, -1 do
		local dis, angle = checkDis(self.x, self.y, zombie[i].x, zombie[i].y)
		if dis < player.rad + zombie[i].rad then
			player.health = player.health - 20
		end
	end

	if self.health <= 0 then

		--	END GAME	-------------------------
	end
end

function player:draw(color)
	if player.health > 0 then
		drawCircle(self, color)
	else
		lg.setColor(255, 100, 100)
		lg.print("DEAD", 500, 500)
	end
end

