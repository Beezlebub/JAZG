-- Configuration
function love.conf(t)
	t.title = "Just Another Zombie Game" -- The title of the window the game is in (string)
	t.version = "0.9.1"         -- The LÖVE version this game was made for (string)
	t.window.width = 1200        -- we want our game to be long and thin.
	t.window.height = 720
	-- For Windows debugging
	t.console = false
end
