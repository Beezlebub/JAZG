
function hudLoad()
	camSettings = {}
	camSettings.x = 0
	camSettings.y = 0
	camSettings.scale = 1
	camSettings.rot = 0

    lm.setCursor(lm.getSystemCursor("crosshair"))
    lg.setPointSize(5)
    lg.setPointStyle("smooth")

	---------------------------------------------

	hud = {}

	hud.weapon = {}
	hud.weapon.x = lg.getWidth() - 310
	hud.weapon.y = lg.getHeight() - 100
	hud.weapon.w = 270
	hud.weapon.h = 80

	hud.weapon.ammo = {} 
	hud.weapon.ammo.x = hud.weapon.x + 10
	hud.weapon.ammo.y = hud.weapon.y + 30
	hud.weapon.ammo.w = 250
	hud.weapon.ammo.h = 40

	hud.weapon.reload = {}
	hud.weapon.reload.x = 0
	hud.weapon.reload.y = 0
	hud.weapon.reload.w = 50
	hud.weapon.reload.h = 10

end

function hudUpdate(dt)
	camSettings.x = -player.x + player.rad
	camSettings.y = -player.y + player.rad
	hud.weapon.reload.x = player.x - hud.weapon.reload.w/2
	hud.weapon.reload.y = player.y - 50

	
	local mx, my = lm.getX(), lm.getY()
	local dis, angle = checkDis(player.x - lg.getWidth()/2, player.y - lg.getHeight()/2, mx, my)
	tDis = dis
	tAngle = angle

end

function hud1Draw()
	if weapon.isReloading then
		lg.setColor(80, 80, 80)
		lg.rectangle("line", hud.weapon.reload.x, hud.weapon.reload.y, hud.weapon.reload.w, hud.weapon.reload.h)

		local tw = hud.weapon.reload.w - (hud.weapon.reload.w * (weapon.canShootTimer / weapon[weapon.use].reloadTime))
		lg.setColor(180, 50, 50)
		lg.rectangle("fill", hud.weapon.reload.x, hud.weapon.reload.y+1, tw, hud.weapon.reload.h-2)


		--lg.setColor(180, 50, 50)
		--lg.printf("RELOADING", hud.weapon.reload.x, hud.weapon.reload.y - 20, hud.weapon.reload.w, "center")
	end

end

function hud2Draw()

	lg.setColor(255, 255, 255)
	lg.print(tDis, 10, 10)
	lg.print(tAngle, 10, 30)

	drawRect(hud.weapon, {80,80,80})
	drawRect(hud.weapon.ammo, {180,180,80})

	lg.setColor(255, 255, 255)
	lg.printf(weapon[weapon.use].name, hud.weapon.x, hud.weapon.y + 5, hud.weapon.w, "center")

	for i = 1, weapon[weapon.use].magMax do
		lg.setColor(80, 80, 80)
		local lineX = hud.weapon.ammo.x + (i * (hud.weapon.ammo.w / (weapon[weapon.use].magMax)))
		lg.line(lineX, hud.weapon.ammo.y, lineX, hud.weapon.ammo.y + hud.weapon.ammo.h)
	end

	for i = weapon[weapon.use].magMax, weapon[weapon.use].magBullets, -1 do
		lg.setColor(80, 80, 80)
		local tw = hud.weapon.ammo.w - (i * (hud.weapon.ammo.w / (weapon[weapon.use].magMax)))

		lg.rectangle("fill", hud.weapon.ammo.x, hud.weapon.ammo.y, tw, hud.weapon.ammo.h)
	end

	
end
