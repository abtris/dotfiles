local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	myHome = string.format("/Users/%s", os.getenv("USER"))
	index = string.find(current_dir, myHome, 1, false)
	return string.sub(current_dir, index + string.len(myHome))
end

local process_icons = {
	['docker'] = wezterm.nerdfonts.linux_docker,
	['docker-compose'] = wezterm.nerdfonts.linux_docker,
	['psql'] = '󱤢',
	['usql'] = '󱤢',
	['kuberlr'] = wezterm.nerdfonts.linux_docker,
	['kubectl'] = wezterm.nerdfonts.linux_docker,
	['stern'] = wezterm.nerdfonts.linux_docker,
	['nvim'] = wezterm.nerdfonts.custom_vim,
	['make'] = wezterm.nerdfonts.seti_makefile,
	['vim'] = wezterm.nerdfonts.dev_vim,
	['node'] = wezterm.nerdfonts.mdi_hexagon,
	['go'] = wezterm.nerdfonts.seti_go,
	['zsh'] = wezterm.nerdfonts.dev_terminal,
	['bash'] = wezterm.nerdfonts.cod_terminal_bash,
	['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['cargo'] = wezterm.nerdfonts.dev_rust,
	['sudo'] = wezterm.nerdfonts.fa_hashtag,
	['lazydocker'] = wezterm.nerdfonts.linux_docker,
	['git'] = wezterm.nerdfonts.dev_git,
	['lua'] = wezterm.nerdfonts.seti_lua,
	['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
	['curl'] = wezterm.nerdfonts.mdi_flattr,
	['gh'] = wezterm.nerdfonts.dev_github_badge,
	['ruby'] = wezterm.nerdfonts.cod_ruby,
}

local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == '' then
		return '[?]'
	end

	local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
	if string.find(process_name, 'kubectl') then
		process_name = 'kubectl'
	end

	return process_icons[process_name] or string.format('[%s]', process_name)
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local cwd = wezterm.format({
		{ Attribute = { Intensity = 'Bold' } },
		{ Text = get_current_working_dir(tab) },
	})

	local title = string.format(' %s ~ %s  ', get_process(tab), cwd)

	if has_unseen_output then
		return {
			{ Foreground = { Color = '#28719c' } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

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

config.tab_max_width = 100

config.window_close_confirmation = 'NeverPrompt'

return config
