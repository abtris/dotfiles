local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end

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

local process_icons = {
	["docker"] = {
		Text = nf.linux_docker,
	},
	["docker-compose"] = {
		Text = nf.linux_docker,
	},
	["kuberlr"] = {
		Text = nf.linux_docker,
	},
	["kubectl"] = {
		Text = nf.linux_docker,
	},
	["nvim"] = {
		Text = nf.custom_vim,
	},
	["vim"] = {
		Text = nf.custom_vim, --nf.dev_vim,
	},
	["node"] = {
		Text = nf.md_hexagon,
	},
	["zsh"] = {
		Text = nf.md_lambda,
		-- Text = nf.dev_terminal_badge,
		-- Text = nf.mdi_apple_keyboard_command,
	},
	["bash"] = {
		Text = nf.cod_terminal_bash,
	},
	["btm"] = {
		Text = nf.md_chart_donut_variant,
	},
	["htop"] = {
		Text = nf.md_chart_donut_variant,
	},
	["cargo"] = {
		Text = nf.dev_rust,
	},
	["rust"] = {
		Text = nf.dev_rust,
	},
	["go"] = {
		Text = nf.md_language_go,
	},
	["lazydocker"] = {
		Text = nf.linux_docker,
	},
	["git"] = {
		Text = nf.dev_git,
	},
	["lua"] = {
		Text = nf.seti_lua,
	},
	["wget"] = {
		Text = nf.md_arrow_down_box,
	},
	["curl"] = {
		Text = nf.md_flattr,
	},
	["gh"] = {
		Text = nf.dev_github_badge,
	},
}

local function get_proc_title(pane)
	return (pane:get_foreground_process_name())
end

wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, _max_width)
	local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	local title = get_proc_title(tab.active_pane)

	local icon
	if process_icons[title] ~= nil then
		icon = wezterm.format({
			{ Text = " " },
			process_icons[title],
			{ Text = " " },
		})
	else
		icon = wezterm.format({
			{ Text = string.format(" %s", title) },
		})
	end
	return {
		hover or "ResetAttributes",
		{ Text = icon },
		{ Text = tab.tab_title == "" and title or tab.tab_title },
	}
end)

config.font_size = 18.0
config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

return config
