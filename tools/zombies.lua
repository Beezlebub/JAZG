zombie = class('zombie')

function zombie:initialize(x, y)
	self.x = x
	self.y = y
	self.rad = 20
	self.speed = math.random(10, 30)
	self.health = 100
end

function zombie:remove()
	table.remove(zombies, i)
end

function zombie:update(dt)
	local canMove = true
	for i, zombie in ipairs(zombies) do
		local dis, angle = checkDis(self.x, self.y, zombie.x, zombie.y)
		if dis < zombie.rad*2 then
			if self ~= zombie then canMove = false end
		end
	end

	if canMove then
		if player.x > self.x then
			self.x = self.x + self.speed * dt
		else
			self.x = self.x - self.speed * dt
		end

		if player.y > self.y then
			self.y = self.y + self.speed * dt
		else
			self.y = self.y - self.speed * dt
		end
	end

	if self.health < 1 then
		zombie:remove(self)
	end
end

function zombie:draw(color)
	drawCircle(self, color)
end
