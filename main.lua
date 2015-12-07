--	Just Another Zombie Game

--	Created By	Beelz
--	Version		0.0.1 

require "tools/game"

function love.load()
	gameLoad()
end

function love.update(dt)
	gameUpdate(dt)
end

function love.draw()
	gameDraw()
end

function love.keypressed(key, i)
	gameKey(key, i)
end

