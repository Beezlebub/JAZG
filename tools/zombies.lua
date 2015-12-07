zombie = class('zombie')

function zombie:initialize(x, y)
	self.x = x
	self.y = y
	self.rad = 20
	self.speed = math.random(10, 30)
	self.health = 100
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
end

function zombie:draw(color)
	drawCircle(self, color)
end


function zombiesLoad()
	zombies = {}
	zombies.canSpawn = true
	zombies.spawnTimer = 0
	zombies.timerMax = 5
	zombies.maxNum = 30

	for i = 1, 20 do
		local x = math.random(player.x - lg.getWidth()/2, player.x + lg.getWidth()/2)
		local y = math.random(player.y - lg.getHeight()/2, player.y + lg.getHeight()/2)
		local rad = 30
		local speed = math.random(5, 15)
		local health = 100

		zombies[i] = zombie:new(x, y, rad, speed, health)
	end
end

function spawnZombies(dt)
	if zombies.spawnTimer > 0 then
		zombies.spawnTimer = zombies.spawnTimer - 1 * dt
	else
		if #zombies < zombies.maxNum then
			local x = math.random(player.x - lg.getWidth()/2, player.x + lg.getWidth()/2)
			local y = math.random(player.y - lg.getHeight()/2, player.y + lg.getHeight()/2)
			local rad = 30
			local speed = math.random(5, 15)
			local health = 100

			zombies[#zombies+1] = zombie:new(x, y, rad, speed, health)
			zombies.spawnTimer = zombies.timerMax
		end
	end
end

