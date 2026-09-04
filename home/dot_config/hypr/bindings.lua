-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Bar panels are SUPER + CTRL + <letter>, but that row is full: only G, J, M,
-- U and Y are unclaimed, and none of them says VPN. V does, and it belongs to
-- the clipboard manager, so this takes SHIFT to get out of its way.
o.bind("SUPER + SHIFT + CTRL + V", "VPN", "omarchy-shell shell toggle cwhite.openconnect")

-- The quickshell.spotify plugin's settings offer to point Super + Shift + M at
-- its own player, but as of 1.0.3 nothing wires that up -- the binding still
-- runs `omarchy launch spotify`, which starts the ~950MB desktop client the
-- plugin exists to avoid. Upstream issue #43. So do the wiring here.
--
-- Each surface gets its own key and its own IPC method rather than going
-- through the plugin's togglePlayer, which dispatches to whichever single
-- surface its "Super + Shift + M · <target>" setting names. One key that
-- changes meaning from a settings panel is worse than two that don't, and that
-- setting sits right next to an unrelated "Open mini-player from bar" toggle
-- for the mouse, which is easy to read as controlling the shortcut.
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Music", "omarchy-shell quickshell.spotify.player toggleFullPlayer")

-- The bar dropdown -- transport, seek, volume, lyrics, and its own keyboard
-- map (Tab and arrows to move, O to expand to the full player, Esc to close).
-- SUPER + CTRL is Omarchy's bar-panel row and this is a bar widget, so it
-- belongs there; M was one of the few letters left in it.
o.bind("SUPER + CTRL + M", "Music mini player", "omarchy-shell quickshell.spotify.player toggleMiniPlayer")
