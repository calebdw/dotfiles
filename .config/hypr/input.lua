-- Caps Lock stays Caps Lock. Omarchy's compose:caps plus
-- shift:both_capslock_cancel fights this board: home-row mods put
-- Shift on A and H, so both-shifts-together fires while typing, and
-- the ZMK caps-word shift-morph sends CapsLock which would become
-- Compose.
--
-- Compose is the Menu key instead. Fun-layer K_APP already sends it.
hl.config({
  input = {
    kb_options = "compose:menu",
  },
})
