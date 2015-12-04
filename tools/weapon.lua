
function weaponLoad()
	
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
	weapon[1].fireRate = 0.2
	weapon[1].fireMode = 0
	weapon[1].reloadTime = 2

	weapon[2] = {}
	weapon[2].name = "SMG"
	weapon[2].damage = 15
	weapon[2].magBullets = 30
	weapon[2].magMax = 30
	weapon[2].allBullets = 90
	weapon[2].fireRate = 0.2
	weapon[2].fireMode = 1
	weapon[2].reloadTime = 2

	weapon[3] = {}
	weapon[3].name = "MG"
	weapon[3].damage = 25
	weapon[3].magBullets = 75
	weapon[3].magMax = 75
	weapon[3].allBullets = 300
	weapon[3].fireRate = 0.15
	weapon[3].fireMode = 1
	weapon[3].reloadTime = 5

	weapon[4] = {}
	weapon[4].name = "AR"
	weapon[4].damage = 50
	weapon[4].magBullets = 25
	weapon[4].magMax = 25
	weapon[4].allBullets = 75
	weapon[4].fireRate = .2
	weapon[4].fireMode = 0
	weapon[4].reloadTime = 2.5

	weapon[5] = {}
	weapon[5].name = "Rifle"
	weapon[5].stat = {}
	weapon[5].damage = 100
	weapon[5].magBullets = 7
	weapon[5].magMax = 7
	weapon[5].allBullets = 21
	weapon[5].fireRate = 4
	weapon[5].fireMode = 0
	weapon[5].reloadTime = 3.0

	---------------------------------------------

	bullets = {}
	bulletSpeed = 200

end

function weaponUpdate(dt)

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

	---------------------------------------------

	if lm.isDown("l") then
		if weapon.canShoot and weapon[weapon.use].magBullets > 0 then
			createBullet()
			weapon[weapon.use].magBullets = weapon[weapon.use].magBullets - 1
			weapon.canShootTimer = weapon[weapon.use].fireRate
			weapon.canShoot = false
			weapon.btnDown = true
		end
	else
		weapon.btnDown = false
	end

	if weapon[weapon.use].fireMode == 0 and weapon.btnDown then
		weapon.canShootTimer = weapon[weapon.use].fireRate
	end

	---------------------------------------------

	for i, bullet in ipairs(bullets) do
		bullet[1] = bullet[1] + bullet[3] * bulletSpeed * dt
		bullet[2] = bullet[2] + -bullet[3] * bulletSpeed * dt
	end

end

function createBullet()
	local mx, my = lm.getPosition()
	local x, y = player.x, player.y
	local dis, angle = checkDis(mx, my, x, y)

	bullets[#bullets+1] = {x, y, angle, weapon[weapon.use].damage}
end

function removeBullet(i)
	table.remove(bullets, i)
end

function weaponDraw()
	for i, bullet in ipairs(bullets) do
		lg.point(bullet[1], bullet[2])
	end
end
