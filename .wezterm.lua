-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "nordfox"
config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 19

config.enable_tab_bar = false
config.audible_bell = "Disabled"
-- config.default_prog = { "/opt/homebrew/bin/tmux" }

config.window_decorations = "RESIZE"

config.window_padding = {
	---	left = 2,
	---	right = 2,
	---	top = 0,
	bottom = 0,
}
-- and finally, return the configuration to wezterm
return config
