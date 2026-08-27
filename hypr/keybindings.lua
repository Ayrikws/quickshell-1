----------------------
--    KEYBINDINGS    --
----------------------

local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"

---------------------
-- CORE KEYBINDINGS --
---------------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), { description = "App: Terminal" })
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Window: Close" })
hl.bind(mainMod .. " + Delete", hl.dsp.exit(), { description = "Session: Exit Hyprland" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "App: File manager" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu), { description = "App: Launcher" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.local/bin/clipboard-manager.sh"), { description = "Utilities: Clipboard manager" })
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Utilities: Color picker" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("/usr/bin/rofi-noter"), { description = "App: Notes" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("python ~/.config/ayrik/ayrik.py --action select-wallpaper"), { description = "Utilities: Wallpaper selector" })
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"), { description = "App: Telegram" })
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("ghostty"), { description = "App: Ghostty" })
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("foot"), { description = "App: Foot" })

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Session: Lock screen" })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("app.zen_browser.zen"), { description = "App: Zen Browser" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"), { description = "App: Firefox" })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("obsidian"), { description = "App: Obsidian" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("thorium-browser-avx2"), { description = "App: Thorium Browser" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Utilities: Screenshot window" })

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.center(), { description = "Window: Center" })

hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Session: Reload Hyprland" })
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Utilities: Screenshot output", locked = true })

------------------------
-- WORKSPACE ROUTING --
------------------------
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, 			hl.dsp.focus({ workspace = i }), { description = "Workspace: Focus " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. i,  hl.dsp.window.move({ workspace = i }), { description = "Window: Send to workspace " .. i })
end
-- Handle workspace 10 mapped to '0'
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }), { description = "Workspace: Focus 10" })
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }), { description = "Window: Send to workspace 10" })

hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }), { description = "Workspace: Focus right" })
hl.bind(mainMod .. " + CTRL + Left",  hl.dsp.focus({ workspace = "r-1" }), { description = "Workspace: Focus left" })
hl.bind(mainMod .. " + CTRL + Down",  hl.dsp.focus({ workspace = "empty" }), { description = "Workspace: Focus empty" })
hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + mouse_up", 	  hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.window.move({ workspace = "special:magic" }))

-----------------------
-- WINDOW MANAGEMENT --
-----------------------
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Window: Fullscreen" })

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })

-- Window Moving (Focus direction)
for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local focusdir = { "l", "r", "u", "d" }
    hl.bind(mainMod .. " + SHIFT + CTRL + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }), { description = "Window: Move " .. arrowkey[i] })
end

-- Mouse Binds (Using native dispatch)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with the mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })

---------------------------
-- HYPRSCROLLING LAYOUT --
---------------------------
hl.bind(mainMod .. " + Right", 		hl.dsp.layout("move +col"), { description = "Layout: Move column right" })
hl.bind(mainMod .. " + Left", 		hl.dsp.layout("move -col"), { description = "Layout: Move column left" })
hl.bind(mainMod .. " + P", 			hl.dsp.layout("promote"), { description = "Layout: Promote window" })
hl.bind(mainMod .. " + L", 			hl.dsp.layout("togglefit"), { description = "Layout: Toggle fit" })
hl.bind(mainMod .. " + SHIFT + E",  hl.dsp.layout("fit active"), { description = "Layout: Fit active" })

hl.bind(mainMod .. " + ALT + Left",  hl.dsp.layout("swapcol l"), { description = "Layout: Swap column left" })
hl.bind(mainMod .. " + ALT + Right", hl.dsp.layout("swapcol r"), { description = "Layout: Swap column right" })
hl.bind(mainMod .. " + ALT + Up", 	 hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"), { description = "Window: Swap up" })
hl.bind(mainMod .. " + ALT + Down",  hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"), { description = "Window: Swap down" })

-----------------------
-- HARDWARE CONTROLS --
-----------------------
-- Audio controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true, description = "Media: Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true, description = "Media: Volume down" })
hl.bind("XF86AudioMute", 	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, description = "Media: Toggle mute" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, description = "Media: Toggle mic" })

-- Screen Brightness (Standard Keys)
hl.bind("XF86MonBrightnessUp", 	 hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true, description = "Screen: Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true, description = "Screen: Brightness down" })

-- Hyprsunset Gamma (SHIFT + Brightness Keys)
hl.bind("SHIFT + XF86MonBrightnessUp",   hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"), { repeating = true, locked = true, description = "Screen: Gamma up" })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"), { repeating = true, locked = true, description = "Screen: Gamma down" })

-- Media Player Controls
hl.bind("XF86AudioNext", 	hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Media: Next" })
hl.bind("XF86AudioPause", 	hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Media: Play/Pause" })
hl.bind("XF86AudioPlay", 	hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", 	hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Media: Previous" })
