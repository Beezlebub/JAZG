require "tools.player"
require "tools.zombies"
require "tools.weapon"
require "tools.hud"

lg = love.graphics
lk = love.keyboard
lm = love.mouse
lp = love.physics

function gameLoad()
	world = lp.newWorld(0, 0, false)
	lp.setMeter(64)
	lg.setNewFont(16)
	lg.setLineWidth(1)

	playerLoad()
	weaponLoad()
	zombiesLoad()
	hudLoad()

end

function gameUpdate(dt)
	playerUpdate(dt)
	weaponUpdate(dt)
	zombiesUpdate(dt)
	hudUpdate(dt)
end

function gameDraw()
	lg.push()
	
	lg.translate(camSettings.x + lg.getWidth()/camSettings.scale/2, camSettings.y + lg.getHeight()/camSettings.scale/2)
	lg.scale(camSettings.scale, camSettings.scale)

	playerDraw()
	weaponDraw()
	zombiesDraw()

	hud1Draw()
	lg.pop()
	hud2Draw()
end

function gameKey(key, i)
	if key == "escape" then love.event.quit() end

	if key == "1" then
		weapon.use = 1
	elseif key == "2" then
		weapon.use = 2
	elseif key == "3" then
		weapon.use = 3
	elseif key == "4" then
		weapon.use = 4
	elseif key == "5" then
		weapon.use = 5
	elseif key == "r" then
		if weapon[weapon.use].magBullets < weapon[weapon.use].magMax then
			weapon.canShoot = false
			weapon.isReloading = true
			weapon.canShootTimer = weapon[weapon.use].reloadTime
		end
	end
end

-------------------------------------------------

function checkDis(x1, y1, x2, y2)
	local tx = x1 - x2
	local ty = y1 - y2

	local angle = math.atan2(ty, tx) / (math.pi*2)
	local dis = math.sqrt((x2-x1)^2 + (y2-y1)^2)

	return dis, angle
end

function drawCircle(obj, color)
	lg.setColor(color, 80)	
	lg.circle("fill", obj.x, obj.y, obj.rad)
	lg.setColor(color, 255)	
	lg.circle("line", obj.x, obj.y, obj.rad)
end

function drawRect(obj, color)
	lg.setColor(color, 80)	
	lg.rectangle("fill", obj.x, obj.y, obj.w, obj.h)
	lg.setColor(color, 255)	
	lg.rectangle("line", obj.x, obj.y, obj.w, obj.h)
end
