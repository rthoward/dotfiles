hs.alert.defaultStyle.radius = 5
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }

local positions = {
	maximized = hs.layout.maximized,
	centered = { x = 0.0125, y = 0.0125, w = 0.975, h = 0.975 },

	left34 = { x = 0, y = 0, w = 0.34, h = 1 },
	left50 = hs.layout.left50,
	left55 = { x = 0, y = 0, w = 0.55, h = 1 },
	left60 = { x = 0, y = 0, w = 0.60, h = 1 },
	left66 = { x = 0, y = 0, w = 0.66, h = 1 },

	right34 = { x = 0.66, y = 0, w = 0.34, h = 1 },
	right40 = { x = 0.60, y = 0, w = 0.40, h = 1 },
	right45 = { x = 0.55, y = 0, w = 0.45, h = 1 },
	right50 = hs.layout.right50,
	right66 = { x = 0.34, y = 0, w = 0.66, h = 1 },

	upper50 = { x = 0, y = 0, w = 1, h = 0.5 },
	upper50Left50 = { x = 0, y = 0, w = 0.5, h = 0.5 },
	upper50Right50 = { x = 0.5, y = 0, w = 0.5, h = 0.5 },

	lower50 = { x = 0, y = 0.5, w = 1, h = 0.5 },
	lower50Left50 = { x = 0, y = 0.5, w = 0.5, h = 0.5 },
	lower50Right50 = { x = 0.5, y = 0.5, w = 0.5, h = 0.5 },
}

local screens = {
	macbook = "Color LCD",
	ex_landscape = "DELL",
	ex_portrait = "27GL850",
}

local apps = {
	sublime = { name = "Sublime Text", path = "/Applications/Sublime Text.app" },
	vscode = { name = "Code", path = "/Applications/Visual Studio Code.app" },
	emacs = { name = "Emacs", path = "/Applications/Emacs.app" },
	neovim = {
		name = "neovim",
		path = "/Users/richard/Applications/Neovim.app",
		launchOrFocus = function()
			local window = hs.window.get("neovim-main")
			if window then
				window:focus()
			end
		end,
	},
	xcode = { name = "xcode", path = "/Applications/Xcode.app" },
	alacritty = { name = "Alacritty", path = "/Applications/Alacritty.app" },
	kitty = { name = "kitty", path = "/Applications/kitty.app" },
	iterm2 = { name = "iTerm2", path = "/Applications/iTerm.app" },
	firefox = { name = "Firefox", path = "/Applications/Firefox.app" },
	slack = { name = "Slack", path = "/Applications/Slack.app" },
	spotify = { name = "Spotify", path = "/Applications/Spotify.app" },
	zoom = { name = "Zoom", path = "/Applications/zoom.us.app" },
	obsidian = { name = "Obsidian", path = "/Applications/Obsidian.app" },
	postico = { name = "Postico", path = "/Applications/Postico.app" },
	tableplus = { name = "TablePlus", path = "/Applications/TablePlus.app" },
	insomnia = { name = "Insomnia", path = "/Applications/Insomnia.app" },
	dash = { name = "Dash", path = "/Applications/Dash.app" }
}

local app_mod = { "cmd", "shift" }
local layout_mod = { "cmd", "alt", "ctrl" }

local editors = { apps.vscode, apps.neovim, apps.sublime, apps.emacs, apps.xcode }
local terminals = { apps.kitty, apps.alacritty, apps.iterm2 }
local db_tools = { apps.tableplus, apps.postico }

-- state

local editor_index = 1
local terminal_index = 1
local db_tool_index = 1
local slack_shortcut_enabled = true

-- helpers

local function current_editor()
	return editors[editor_index]
end

local function current_terminal()
	return terminals[terminal_index]
end

local function current_db_tool()
	return db_tools[db_tool_index]
end

local function cycle_editor()
	editor_index = (editor_index % #editors) + 1
end

local function cycle_terminal()
	terminal_index = (terminal_index % #terminals) + 1
end

local function cycle_db_tool()
	db_tool_index = (db_tool_index % #db_tools) + 1
end

-- application hotkeys

-- Given an application, open it or focus on one of its windows.
-- If the focused window is on a different screen than the mouse cursor
-- then move the cursor to center of the new window.
local function launchOrFocus(app)
	local current_mouse_screen = hs.mouse.getCurrentScreen()

	if app.launchOrFocus then
		app.launchOrFocus()
	else
		hs.application.launchOrFocus(app.path)
	end

	local new_window = hs.window.focusedWindow()

	if current_mouse_screen ~= new_window:screen() then
		local new_mouse_coords = new_window:frame().center
		hs.mouse.absolutePosition(new_mouse_coords)
	end
end

hs.hotkey.bind(app_mod, "W", function()
	launchOrFocus(apps.firefox)
end)

hs.hotkey.bind(app_mod, "space", function()
	launchOrFocus(current_terminal())
end)

hs.hotkey.bind(app_mod, "s", function()
	if slack_shortcut_enabled then
		launchOrFocus(apps.slack)
	end
end)

hs.hotkey.bind(app_mod, "e", function()
	launchOrFocus(current_editor())
end)

hs.hotkey.bind(app_mod, "d", function()
	launchOrFocus(current_db_tool())
end)

hs.hotkey.bind(app_mod, "m", function()
	launchOrFocus(apps.spotify)
end)

hs.hotkey.bind(app_mod, "n", function()
	launchOrFocus(apps.obsidian)
end)

hs.hotkey.bind(app_mod, "i", function()
	launchOrFocus(apps.insomnia)
end)

hs.hotkey.bind(app_mod, "z", function()
	launchOrFocus(apps.zoom)
end)

-- focus current terminal and run last command
hs.hotkey.bind(app_mod, "return", function()
	local term = hs.application.get(current_terminal().name)

	if term then
		local current_window = hs.window.focusedWindow()
		term:activate()
		hs.eventtap.keyStroke({ "ctrl" }, "p")
		hs.eventtap.keyStroke({}, "return")
		current_window:focus()
	end
end)

-- layout hotkeys

hs.hotkey.bind(layout_mod, "p", function()
	local ex_l = hs.screen.find(screens.ex_landscape)
	local ex_p = hs.screen.find(screens.ex_portrait)
	local mac_screen = hs.screen.find(screens.macbook)

	local two_monitor_layout = {
		{ apps.firefox.name, nil, ex_l, positions.centered, nil, nil },
		{ current_editor().name, nil, ex_l, positions.centered, nil, nil },
		{ current_terminal().name, nil, ex_p, positions.lower50, nil, nil },
		{ apps.slack.name, nil, ex_p, positions.upper50, nil, nil },
		{ apps.obsidian.name, nil, ex_p, positions.maximized, nil, nil },
		{ apps.spotify.name, nil, ex_p, positions.maximized, nil, nil },
		{ apps.dash.name, nil, ex_p, positions.maximized, nil, nil }
	}

	local one_monitor_layout = {
		{ current_editor().name, nil, mac_screen, positions.centered, nil, nil },
		{ current_terminal().name, nil, mac_screen, positions.centered, nil, nil },
		{ apps.slack.name, nil, mac_screen, positions.centered, nil, nil },
		{ apps.spotify.name, nil, mac_screen, positions.centered, nil, nil },
	}

	if ex_p and ex_l then
		hs.layout.apply(two_monitor_layout)
	else
		hs.layout.apply(one_monitor_layout)
	end
end)

-- maximize window
hs.hotkey.bind(layout_mod, "m", function()
	hs.window.focusedWindow():maximize()
end)

-- center window
hs.hotkey.bind(layout_mod, "c", function()
	hs.window.focusedWindow():moveToUnit(positions.centered)
end)

-- resize window to left 2/3 of screen
hs.hotkey.bind(layout_mod, "h", function()
	hs.window.focusedWindow():moveToUnit(positions.left55)
end)

-- resize window to right 2/3 of screen
hs.hotkey.bind(layout_mod, "l", function()
	hs.window.focusedWindow():moveToUnit(positions.right45)
end)

-- resize window to top 1/2 of screen
hs.hotkey.bind(layout_mod, "k", function()
	hs.window.focusedWindow():moveToUnit(positions.upper50)
end)

-- resize window to bottom 1/2 of screen
hs.hotkey.bind(layout_mod, "j", function()
	hs.window.focusedWindow():moveToUnit(positions.lower50)
end)

hs.hotkey.bind(layout_mod, "up", function()
	hs.window.focusedWindow():moveOneScreenNorth(false, true)
end)

hs.hotkey.bind(layout_mod, "down", function()
	hs.window.focusedWindow():moveOneScreenSouth(false, true)
	hs.window.focusedWindow():maximize(0)
end)

hs.hotkey.bind(layout_mod, "right", function()
	hs.window.focusedWindow():moveOneScreenEast(false, true)
end)

hs.hotkey.bind(layout_mod, "left", function()
	hs.window.focusedWindow():moveOneScreenWest(false, true)
	hs.window.focusedWindow():maximize(0)
end)

-- mode hotkeys
local meta_mode = hs.hotkey.modal.new(layout_mod, "return")

---@diagnostic disable-next-line
function meta_mode:entered()
	hs.alert("Meta mode")
	hs.timer.doAfter(3, function()
		meta_mode:exit()
	end)
end

---@diagnostic disable-next-line
function meta_mode:exited()
	hs.alert.closeAll()
end

meta_mode:bind("", "escape", function()
	meta_mode:exit()
end)

meta_mode:bind(app_mod, "e", "Cycle Editor", function()
	hs.alert.closeAll()
	cycle_editor()
	hs.alert("Editor is now " .. current_editor().name)
end)

meta_mode:bind(app_mod, "s", "Toggle slack shortcut", function()
	slack_shortcut_enabled = not slack_shortcut_enabled
	local state_text = slack_shortcut_enabled and "on" or "off"

	hs.alert.closeAll()
	hs.alert("Slack shortcut is now " .. state_text)
end)

meta_mode:bind(app_mod, "space", "Cycle terminal", function()
	hs.alert.closeAll()
	cycle_terminal()
	hs.alert("Terminal is now " .. current_terminal().name)
end)

meta_mode:bind(app_mod, "d", "Cycle database tool", function()
	hs.alert.closeAll()
	cycle_db_tool()
	hs.alert("Database tool is now " .. current_db_tool().name)
end)

local function changeVolume(diff)
	return function()
		local current = hs.audiodevice.defaultOutputDevice():volume()
		local new = math.min(100, math.max(0, math.floor(current + diff)))
		if new > 0 then
			hs.audiodevice.defaultOutputDevice():setMuted(false)
		end
		hs.alert.closeAll(0.0)
		hs.alert.show("Volume " .. new .. "%", {}, 0.5)
		hs.audiodevice.defaultOutputDevice():setVolume(new)
	end
end

hs.hotkey.bind(app_mod, ",", changeVolume(-3))
hs.hotkey.bind(app_mod, ".", changeVolume(3))
