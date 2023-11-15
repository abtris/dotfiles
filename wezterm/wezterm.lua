local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end

-- https://wezfurlong.org/wezterm/hyperlinks.html#implicit-hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- print all: wezterm show-keys --lua
config.keys = {
	{
		key = 'd',
		mods = 'CMD',
		action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
		key = 'd',
		mods = 'SHIFT|CMD',
		action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},
	{
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.TogglePaneZoomState,
  },
	{
		key = 'w',
		mods = 'CMD',
		action = wezterm.action.CloseCurrentPane { confirm = true },
	},
	{
		key = 'LeftArrow',
		mods = 'CMD',
		action = act.ActivatePaneDirection 'Left',
	},
	{
		key = 'RightArrow',
		mods = 'CMD',
		action = act.ActivatePaneDirection 'Right',
	},
	{
		key = 'UpArrow',
		mods = 'CMD',
		action = act.ActivatePaneDirection 'Up',
	},
	{
		key = 'DownArrow',
		mods = 'CMD',
		action = act.ActivatePaneDirection 'Down',
	},
	{
		key = 'LeftArrow',
		mods = 'CTRL|CMD',
		action = act.ActivateTabRelative(-1),
	},
	{
		key = 'RightArrow',
		mods = 'CTRL|CMD',
		action = act.ActivateTabRelative(1),
	},
}

config.font_size = 18.0
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

config.window_close_confirmation = 'NeverPrompt'

return config
