bullet = class('bullet')

function bullet:initialize(x, y, angle, damage)
	self.x = gun.x
	self.y = gun.y
	self.damage = damage

	local dis, angle = checkDis(self.x, self.y, x, y)
	self.angle = angle
end

function bullet:remove()
	table.remove(bullets, i)
end

function bullet:update(dt)
	self.x = self.x + math.sin(self.angle) * bulletSpeed * dt
	self.y = self.y + math.cos(-self.angle) * bulletSpeed * dt

	for i = #zombie, 1, -1 do
		local dis, angle = checkDis(self.x, self.y, zombie[i].x, zombie[i].y)
		if dis < zombie[i].rad then
			zombie[i].health = zombie[i].health - self.damage
			bullet:remove(self)
		end
	end

end

function bullet:draw(color)
	lg.point(self.x, self.y)
end

	---------------------------------------------

function weaponLoad()
	
	gun = {}
	gun.x = 0
	gun.y = 0
	gun.rad = 10
	gun.dis = 40

	bullets = {}
	bulletSpeed = 200

	---------------------------------------------

	weapon = {}
	weapon.btnDown = false
	weapon.isReloading = false
	weapon.canShoot = true
	weapon.canShootTimer = 0
	weapon.use = 1

	weapon[1] = {}
	weapon[1].name = "Pistol"
	weapon[1].damage = 25
	weapon[1].magBullets = 9
	weapon[1].magMax = 9
	weapon[1].allBullets = 48
	weapon[1].fireRate = 0.01
	weapon[1].fireMode = 0
	weapon[1].reloadTime = 1.5

	weapon[2] = {}
	weapon[2].name = "SMG"
	weapon[2].damage = 15
	weapon[2].magBullets = 30
	weapon[2].magMax = 30
	weapon[2].allBullets = 90
	weapon[2].fireRate = 0.2
	weapon[2].reloadTime = 2

	weapon[3] = {}
	weapon[3].name = "LMG"
	weapon[3].damage = 20
	weapon[3].magBullets = 75
	weapon[3].magMax = 75
	weapon[3].allBullets = 300
	weapon[3].fireRate = 0.1
	weapon[3].reloadTime = 5

	weapon[4] = {}
	weapon[4].name = "DMR"
	weapon[4].damage = 50
	weapon[4].magBullets = 12
	weapon[4].magMax = 12
	weapon[4].allBullets = 75
	weapon[4].fireRate = .01
	weapon[4].fireMode = 0
	weapon[4].reloadTime = 2.5

	weapon[5] = {}
	weapon[5].name = "Rifle"
	weapon[5].stat = {}
	weapon[5].damage = 100
	weapon[5].magBullets = 7
	weapon[5].magMax = 7
	weapon[5].allBullets = 21
	weapon[5].fireRate = .2
	weapon[5].fireMode = 0
	weapon[5].reloadTime = 3.0
end

function weaponUpdate(dt)

	if lm.isDown("l") then weapon.btnDown = true else weapon.btnDown = false end

	rotateGun(dt)

	if not weapon.isReloading and weapon.btnDown then
		if weapon.canShoot then
			if weapon[weapon.use].magBullets > 0 then
				createBullet()
				weapon[weapon.use].magBullets = weapon[weapon.use].magBullets - 1
				weapon.canShootTimer = weapon[weapon.use].fireRate
				weapon.canShoot = false
			end
		else
			if weapon[weapon.use].fireMode == 0 then 
				weapon.canShootTimer = weapon[weapon.use].fireRate
			end
		end
	end

	---------------------------------------------

	if weapon.canShootTimer > 0 then
		weapon.canShootTimer = weapon.canShootTimer - 1 * dt
	else
		if weapon.isReloading then
			if weapon[weapon.use].allBullets >= weapon[weapon.use].magMax then
				weapon[weapon.use].magBullets = weapon[weapon.use].magMax
				weapon[weapon.use].allBullets = weapon[weapon.use].allBullets - weapon[weapon.use].magMax
			else
				weapon[weapon.use].magBullets = weapon[weapon.use].allBullets
				weapon[weapon.use].allBullets = 0
			end
			weapon.isReloading = false
		end
		weapon.canShoot = true
	end

	if weapon[weapon.use].magBullets == 0 and not weapon.isReloading then
		if weapon[weapon.use].allBullets > 0 then
			weapon.canShootTimer = weapon[weapon.use].reloadTime
			weapon.canShoot = false
			weapon.isReloading = true
		end
	end
end

function createBullet()
	local mx, my = lm.getX()+lg.getWidth(), lm.getY()+lg.getHeight()
	local x, y = player.x, player.y
	local dis, angle = checkDis(x, y, mx, my)
	bullets[#bullets+1] = bullet:new(x, y, angle, weapon[weapon.use].damage)
end

	---------------------------------------------

function rotateGun(dt)
	local mx, my = lm.getX() + player.x, lm.getY() + player.y
	local dis, angle = checkDis(mx, my, player.x, player.y)

	gun.x = player.x + math.sin(angle) * gun.dis
	gun.y = player.y + math.cos(-angle) * gun.dis

end

