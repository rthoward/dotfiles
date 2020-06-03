-- hs config
hs.alert.defaultStyle.radius = 5
hs.alert.defaultStyle.atScreenEdge = 2
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }

-- state

editors = {
  { name = 'Code', path = '/Applications/Visual Studio Code.app' },
  { name = 'intellij', path = '/Applications/IntelliJ IDEA CE.app' },
  { name = 'spacemacs', path = '/Applications/Emacs.app' },
}
editor_index = 1
terminals = {
  { name = 'Alacritty', path = '/Applications/Alacritty.app' },
  { name = 'iTerm2', path = '/Applications/iTerm.app' },
}
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

hs.hotkey.bind({"cmd", "shift"}, "W", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind({"cmd", "shift"}, "space", function()
    hs.application.launchOrFocus(terminals[terminal_index].path)
end)

hs.hotkey.bind({"cmd", "shift"}, "s", function()
    if slack_shortcut_enabled then
      hs.application.launchOrFocus("/Applications/Slack.app")
    end
end)

hs.hotkey.bind({"cmd", "shift"}, "e", function()
    hs.application.launchOrFocus(editors[editor_index].path)
end)

hs.hotkey.bind({"cmd", "shift"}, "m", function()
    hs.application.launchOrFocus("Spotify")
end)

hs.hotkey.bind({"cmd", "shift"}, "z", function()
    hs.application.launchOrFocus("zoom.us")
end)

hs.hotkey.bind({"cmd", "shift"}, "return", function()
  local term_window = hs.window.find(terminals[terminal_index].name)
  if term_window then
    hs.window.focus(term_window)
    hs.eventtap.keyStroke({"ctrl"}, "p")
    hs.eventtap.keyStroke({}, "return")
  end
end)

-- layout hotkeys

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "p", function ()
  local screen = "DELL P2715Q"
  local devLayout = {
    {current_editor().name,     nil,    screen,     hs.layout.left60,     nil,    nil},
    {current_terminal().name,   nil,    screen,     hs.layout.right60,    nil,    nil},
    {"Firefox",                 nil,    screen,     hs.layout.left60,    nil,    nil},
  }
  hs.layout.apply(devLayout)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.55
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w * 0.45
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "n", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "u", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "b", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
  hs.window.focusedWindow():moveOneScreenNorth(false, true)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "down", function()
  hs.window.focusedWindow():moveOneScreenSouth(false, true)
end)

-- mode hotkeys
meta_mode = hs.hotkey.modal.new({"cmd", "alt", "ctrl"}, "return")

function meta_mode:entered()
  hs.alert("Meta mode")
  hs.timer.doAfter(2, function () meta_mode:exit() end)
end

function meta_mode:exited()
  hs.alert.closeAll()
end

meta_mode:bind('', 'escape', function ()
  meta_mode:exit()
end)

meta_mode:bind('cmd-shift', 'e', 'Cycle Editor', function ()
  hs.alert.closeAll()
  cycleEditor()
  hs.alert("Editor is now " .. current_editor().name)
end)

meta_mode:bind('cmd-shift', 's', 'Toggle slack shortcut', function ()
  slack_shortcut_enabled = not slack_shortcut_enabled
  state_text = slack_shortcut_enabled and "on" or "off"

  hs.alert.closeAll()
  hs.alert("Slack shortcut is now " .. state_text)
end)

meta_mode:bind('cmd-shift', 'space', 'Toggle Terminal', function ()
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

hs.hotkey.bind('cmd-shift', ',', changeVolume(-3))
hs.hotkey.bind('cmd-shift', '.', changeVolume(3))
hs.hotkey.bind('cmd-shift', '/', function ()
  if hs.sound.isPlaying() then
    hs.sound.pause()
  else
    hs.sound.resume()
  end
end)
