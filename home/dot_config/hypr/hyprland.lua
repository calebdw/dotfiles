-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- The NetworkManager OpenConnect auth dialog, raised by the VPN widget when a
-- profile needs authenticating. It is a small GTK window and tiles badly:
-- without this it lands as a ~240x270 tile among whatever else is on the
-- workspace, which reads as the widget having done nothing at all.
o.window("^(nm-openconnect-auth-dialog)$", { float = true, center = true })

-- Xiphos' Copy/Export dialog. It is a separate toplevel of the same class as
-- the main window, so the only thing that tells them apart is the title -- the
-- main window's always ends in "- Xiphos". Tiled, the dialog takes a full half
-- of the screen and squeezes the passage it was opened from into the other
-- half, which is the wrong way round for a form with two buttons on it.
--
-- Floated with no size rule on purpose: GTK asks for the size the form
-- actually needs, and a dialog is the one case where that is the right answer.
o.window({ class = "^(xiphos)$", title = "^(Copy/Export Passage)$" }, { float = true, center = true })

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
