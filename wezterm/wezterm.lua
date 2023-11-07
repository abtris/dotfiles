local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
	config:set_strict_mode(false)
end

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

config.font_size = 18.0
config.color_scheme = "Catppuccin Macchiato" -- or Macchiato, Frappe, Latte

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 30

return config
