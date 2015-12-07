class = require 'tools.middleclass'
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

	player = player:new(1000, 1000)

	weaponLoad()
	
	zombies = {}

	for i = 1, 20 do
		local x = math.random(player.x - lg.getWidth()/2, player.x + lg.getWidth()/2)
		local y = math.random(player.y - lg.getHeight()/2, player.y + lg.getHeight()/2)
		local rad = 30
		local speed = math.random(5, 15)
		local health = 100

		zombies[i] = zombie:new(x, y, rad, speed, health)
	end

	hudLoad()

end

function gameUpdate(dt)
	for i, bullet in ipairs(bullets) do
		bullet:update(dt)
	end

	for i, zombie in ipairs(zombies) do
		zombie:update(dt)
	end

	player:update(dt)
	weaponUpdate(dt)
	hudUpdate(dt)
end

function gameDraw()
	lg.push()
	
	lg.translate(camSettings.x + lg.getWidth()/camSettings.scale/2, camSettings.y + lg.getHeight()/camSettings.scale/2)
	lg.scale(camSettings.scale, camSettings.scale)

	for i, bullet in ipairs(bullets) do 		--bullets
		bullet:draw()
	end

	lg.setColor(120, 120, 120, 150)	
	lg.circle("fill", gun.x, gun.y, gun.rad)	-- gun

	for i, zombie in ipairs(zombies) do 		--zombies
		zombie:draw({200,50,50})
	end

	player:draw({200,200,200})					--player

	hud1Draw()									-- hud
	lg.pop()
	hud2Draw()

end

function gameKey(key, i)
	if key == "escape" then love.event.quit() end
	if key == "-" and camSettings.scale > .5 then camSettings.scale = camSettings.scale - .1 end
	if key == "=" and camSettings.scale < 1 then camSettings.scale = camSettings.scale + .1 end


	if not weapon.isReloading then
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
end


-------------------------------------------------

function checkColl(x1, y1, r1, x2, y2, r2)
	if (x1 + r1 + r2 > x2 and x1 < x2 + r1 + r2 and 
		y1 + r1 + r2 > y2 and y1 < y2 + r1 + r2) then
		collided = true
	end
return collided
end

function checkDis(x1, y1, x2, y2)
	local tx = x2 - x1
	local ty = y2 - y1

	local angle = (math.atan2(ty, tx) / math.pi)
	local dis = ((tx^2) + (ty^2))
	dis = math.sqrt(dis)
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
