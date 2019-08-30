-- This is a configuration for Hammerspoon:
-- Modification Keys: Cmd + Ctrl + Alt + Shift (⌘ + ⌃ + ⌥ + ⇧)
-- Karabiner-elements is used to bind Caps Lock to Modification Keys
-- Caps Lock (⇪) -> Cmd + Ctrl + Alt + Shift (⌘ + ⌃ + ⌥ + ⇧)
-- 1. Window Layout Management:
--   -  ⌘ + ⌃ + ⌥ + ⇧ + [, Toggle current window to left/restore;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + ], Toggle current window to right/restore;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + F, Toggle current window to screenimize/restore;
--
-- 2. Window Resizing:
--   -  ⌘ + ⌃ + ⌥ + ⇧ + H, Increase window width;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + K, Increase window height;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + L, Decrease window width;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + J, Decrease window height;

--
-- 3. Window Placement:
--   -  ⌘ + ⌃ + ⌥ + ⇧ + Left, Move window to screen left;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + Right, Move window to screen right;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + U, Move window up;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + D, Move window down;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + N, Move window left;
--   -  ⌘ + ⌃ + ⌥ + ⇧ + M, Move window right;



-- 0. --
hs.console.darkMode(true)

if hs.console.darkMode(true) then
	hs.console.alpha(0.95)
	hs.console.consoleCommandColor{ white = 0.80 }
	hs.console.outputBackgroundColor{ white = 0.15 }
end

-- 1. --
hs.window.animationDuration = 0
modification_keys = {"cmd", "ctrl", "alt", "shift"}
previous_frame_sizes = {}

hs.hotkey.bind(
	modification_keys, "R",
	function()
		hs.notify.new({
			title           = "Hammerspoon",
			informativeText = "Config reloaded!"
		}):send()
		hs.reload()
	end
)


function is_almost_equal_to_win_frame(geo)
	local epsilon = 2
	local win = hs.window.focusedWindow()
	local win_frame = win:frame()

	if math.abs(win_frame.x - geo.x) < epsilon and
	   math.abs(win_frame.y - geo.y) < epsilon and
	   math.abs(win_frame.w - geo.w) < epsilon and
	   math.abs(win_frame.h - geo.h) < epsilon then

		return true
	else
		return false
	end
end


function get_screen_win_frame()
	local win = hs.window.focusedWindow()

	return win:screen():frame()
end


function get_fill_left_win_frame()
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()
	local screen_frame = win:screen():frame()

	win_frame.x = screen_frame.x
	win_frame.y = screen_frame.y
	win_frame.w = screen_frame.w / 2
	win_frame.h = screen_frame.h

	return win_frame
end


function get_fill_right_win_frame()
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()
	local screen_frame = win:screen():frame()

	win_frame.x = screen_frame.x + screen_frame.w / 2
	win_frame.y = screen_frame.y
	win_frame.w = screen_frame.w / 2
	win_frame.h = screen_frame.h

	return win_frame
end


function is_predefined_win_frame_size()
	if is_almost_equal_to_win_frame(get_screen_win_frame()) or
		is_almost_equal_to_win_frame(get_fill_left_win_frame()) or
		is_almost_equal_to_win_frame(get_fill_right_win_frame()) then

		return true
	else
		return false
	end
end


function bind_resize_and_restore_keys(key, resize_frame_fn)
	hs.hotkey.bind(
		modification_keys, key,
		function()
			local win          = hs.window.focusedWindow()
			local win_frame    = win:frame()
			local target_frame = resize_frame_fn()

			if is_predefined_win_frame_size() and not
				is_almost_equal_to_win_frame(target_frame) then

				win:setFrame(target_frame)
			elseif previous_frame_sizes[win:id()] then

				win:setFrame(previous_frame_sizes[win:id()])
				previous_frame_sizes[win:id()] = nil
			else
				previous_frame_sizes[win:id()] = win_frame
				win:setFrame(target_frame)
			end
		end
	)
end

bind_resize_and_restore_keys("F", get_screen_win_frame)
bind_resize_and_restore_keys("[", get_fill_left_win_frame)
bind_resize_and_restore_keys("]", get_fill_right_win_frame)


-- 2. --
function is_right_win_frame()
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()
	local screen_frame = win:screen():frame()

	if (screen_frame.w - (win_frame.x + win_frame.w)) <= 50 then
		return true
	else
		return false
	end
end


function is_top_win_frame()
	local win       = hs.window.focusedWindow()
	local win_frame = win:frame()

	if win_frame.y <= 100 then
		return true
	else
		return false
	end
end


hs.hotkey.bind(modification_keys, "H", function()
	-- increase window width
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()
	local screen_frame = win:screen():frame()

	if is_right_win_frame() and win_frame.x >= 0 then
		win_frame.x = win_frame.x - 50
		win_frame.w = win_frame.w + 50
		win:setFrame(win_frame)
	elseif win_frame.x < 0 or win_frame.w > screen_frame.w then
		win_frame.x = 0
		win_frame.w = screen_frame.w
		win:setFrame(win_frame)
	else
		win_frame.w = win_frame.w + 50
		win:setFrame(win_frame)
	end
end)


hs.hotkey.bind(modification_keys, "L", function()
	-- decrease window width
	local win = hs.window.focusedWindow()
	local win_frame = win:frame()

	if is_right_win_frame() then
		win_frame.x = win_frame.x + 50
		win_frame.w = win_frame.w - 50
		win:setFrame(win_frame)
	else
		win_frame.w = win_frame.w - 50
		win:setFrame(win_frame)
	end
end)


hs.hotkey.bind(modification_keys, "K", function()
	-- increase window height
	local win       = hs.window.focusedWindow()
	local win_frame = win:frame()

	if is_top_win_frame() then
		win_frame.h = win_frame.h + 50
		win:setFrame(win_frame)
	else
		win_frame.h = win_frame.h + 50
		win:setFrame(win_frame)
	end
end)


hs.hotkey.bind(modification_keys, "J", function()
	-- decrease window height
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()

	if is_top_win_frame() then
		win_frame.h = win_frame.h - 50
		win:setFrame(win_frame)
	else
		win_frame.h = win_frame.h - 50
		win:setFrame(win_frame)
	end
end)


-- WIP --
hs.hotkey.bind(modification_keys, "U", function()
	--	move window up
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()

	win_frame.y = win_frame.y - 25
	win:setFrame(win_frame)
 end)


hs.hotkey.bind(modification_keys, "D", function()
	--	move window down
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()


	win_frame.y = win_frame.y + 25
	win:setFrame(win_frame)
end)


hs.hotkey.bind(modification_keys, "N", function()
	--	move window left
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()

	win_frame.x = win_frame.x - 25
	win:setFrame(win_frame)
end)


hs.hotkey.bind(modification_keys, "M", function()
	--	move window right
	local win          = hs.window.focusedWindow()
	local win_frame    = win:frame()

	win_frame.x = win_frame.x + 25
	win:setFrame(win_frame)
end)
-- END WIP --


-- 3. --
hs.hotkey.bind(modification_keys, "Right", function()
	-- move to screen right
	-- wraps around to first screen
	local win = hs.window.focusedWindow()
	local win_screen = win:screen()

	win:moveToScreen(win_screen:next())
end)


hs.hotkey.bind(modification_keys, "Left", function()
	-- move to screen left
	--   wraps around to last screen
	local win = hs.window.focusedWindow()
	local win_screen = win:screen()

	win:moveToScreen(win_screen:previous())
end)
