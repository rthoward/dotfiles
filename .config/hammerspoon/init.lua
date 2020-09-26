-- hs config
hs.alert.defaultStyle.radius = 5
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }

positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.05, y=0.05, w=0.9, h=0.9},

  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left55 = {x=0, y=0, w=0.55, h=1},
  left60 = {x=0, y=0, w=0.60, h=1},
  left66 = {x=0, y=0, w=0.66, h=1},

  right34 = {x=0.66, y=0, w=0.34, h=1},
  right40 = {x=0.60, y=0, w=0.40, h=1},
  right45 = {x=0.55, y=0, w=0.45, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5}
}

screens = {
	macbook = "Color LCD",
	home_external = "DELL",
}

apps = {
  sublime = { name = "Sublime Text", path = "/Applications/Sublime Text.app" },
  vscode = { name = "Code", path = "/Applications/Visual Studio Code.app" },
  alacritty = { name = "Alacritty", path = "/Applications/Alacritty.app" },
  iterm2 = { name = "iTerm2", path = "/Applications/iTerm.app" },
  firefox = { name = "Firefox", path = "/Applications/Firefox.app" },
  slack = { name = "Slack", path = "/Applications/Slack.app" },
  spotify = { name = "Spotify", path = "/Applications/Spotify.app" },
  zoom = { name = "Zoom", path = "/Applications/zoom.us.app" },
}

app_mod = {"cmd", "shift"}
layout_mod = {"cmd", "alt", "ctrl"}

-- state

editors = { apps.vscode, apps.sublime }
editor_index = 1
terminals = { apps.iterm2, apps.alacritty }
terminal_index = 1
slack_shortcut_enabled = true

-- helpers

function current_editor()
  return editors[editor_index]
end

function current_terminal()
  return terminals[terminal_index]
end

function cycleEditor ()
  editor_index = (editor_index % #editors) + 1
end

function cycleTerminal ()
  terminal_index = (terminal_index % #terminals) + 1
end

-- application hotkeys

hs.hotkey.bind(app_mod, "W", function()
    hs.application.launchOrFocus(apps.firefox.path)
end)

hs.hotkey.bind(app_mod, "space", function()
    hs.application.launchOrFocus(terminals[terminal_index].path)
end)

hs.hotkey.bind(app_mod, "s", function()
    if slack_shortcut_enabled then
      hs.application.launchOrFocus(apps.slack.path)
    end
end)

hs.hotkey.bind(app_mod, "e", function()
    hs.application.launchOrFocus(editors[editor_index].path)
end)

hs.hotkey.bind(app_mod, "m", function()
    hs.application.launchOrFocus(apps.spotify.path)
end)

hs.hotkey.bind(app_mod, "z", function()
    hs.application.launchOrFocus(apps.zoom.path)
end)

-- focus current terminal and run last command
hs.hotkey.bind(app_mod, "return", function()
  local term_window = hs.window.find(terminals[terminal_index].name)
  if term_window then
    hs.window.focus(term_window)
    hs.eventtap.keyStroke({"ctrl"}, "p")
    hs.eventtap.keyStroke({}, "return")
  end
end)

-- layout hotkeys

hs.hotkey.bind(layout_mod, "p", function ()
  local ext_screen = hs.screen.find(screens.home_external)
  local mac_screen = hs.screen.find(screens.macbook)

  two_monitor_layout = {
    {apps.firefox.name,         nil,    ext_screen,   positions.centered,   nil,    nil},
    {current_editor().name,     nil,    ext_screen,   positions.left55,     nil,    nil},
    {current_terminal().name,   nil,    ext_screen,   positions.right45,    nil,    nil},

    {apps.slack.name,           nil,    mac_screen,   positions.maximized,  nil,    nil},
    {apps.spotify.name,         nil,    mac_screen,   positions.maximized,  nil,    nil},
  }

  one_monitor_layout = {
    {current_editor().name,     nil,    mac_screen,   positions.maximized,  nil,    nil},
    {current_terminal().name,   nil,    mac_screen,   positions.maximized,  nil,    nil},
    {apps.slack.name,           nil,    mac_screen,   positions.maximized,  nil,    nil},
    {apps.spotify.name,         nil,    mac_screen,   positions.maximized,  nil,    nil},
  }

  local layout_to_use = nil
  if ext_screen == nil then
    layout_to_use = one_monitor_layout
  else
    layout_to_use = two_monitor_layout
  end

  hs.layout.apply(layout_to_use)
end)

-- move window to left 2/3 of screen
hs.hotkey.bind(layout_mod, "h", function()
  hs.window.focusedWindow():moveToUnit(positions.left66)
end)

-- move window to right 2/3 of screen
hs.hotkey.bind(layout_mod, "l", function()
  hs.window.focusedWindow():moveToUnit(positions.right66)
end)

hs.hotkey.bind(layout_mod, "up", function()
  hs.window.focusedWindow():moveOneScreenNorth(false, true)
end)

hs.hotkey.bind(layout_mod, "down", function()
  hs.window.focusedWindow():moveOneScreenSouth(false, true)
end)

-- mode hotkeys
meta_mode = hs.hotkey.modal.new(layout_mod, "return")

function meta_mode:entered()
  hs.alert("Meta mode")
  hs.timer.doAfter(3, function () meta_mode:exit() end)
end

function meta_mode:exited()
  hs.alert.closeAll()
end

meta_mode:bind('', 'escape', function ()
  meta_mode:exit()
end)

meta_mode:bind(app_mod, 'e', 'Cycle Editor', function ()
  hs.alert.closeAll()
  cycleEditor()
  hs.alert("Editor is now " .. current_editor().name)
end)

meta_mode:bind(app_mod, 's', 'Toggle slack shortcut', function ()
  slack_shortcut_enabled = not slack_shortcut_enabled
  state_text = slack_shortcut_enabled and "on" or "off"

  hs.alert.closeAll()
  hs.alert("Slack shortcut is now " .. state_text)
end)

meta_mode:bind(app_mod, 'space', 'Toggle Terminal', function ()
  hs.alert.closeAll()
  cycleTerminal()
  hs.alert("Terminal is now " .. current_terminal().name)
end)

function changeVolume(diff)
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

hs.hotkey.bind(app_mod, ',', changeVolume(-3))
hs.hotkey.bind(app_mod, '.', changeVolume(3))
hs.hotkey.bind(app_mod, '/', function ()
  if hs.sound.isPlaying() then
    hs.sound.pause()
  else
    hs.sound.resume()
  end
end)
