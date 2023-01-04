local wezterm = require("wezterm")
local select_and_open_url = wezterm.action.QuickSelectArgs({
	label = "open url",
	patterns = {
		[[https?://[\w./-]+]],
	},
	action = wezterm.action_callback(function(window, pane)
		local url = window:get_selection_text_for_pane(pane)
		wezterm.log_info("opening: " .. url)
		wezterm.open_with(url)
	end),
})

return {
	font = wezterm.font("monospace"),
	font_size = 18,
	color_scheme_dirs = { "~/.config/wezterm/colors" },
	color_scheme = "Everforest Light (Hard)",
	unix_domains = {
		{
			name = "unix",
		},
	},
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{
			key = "P",
			mods = "CTRL",
			action = select_and_open_url,
		},
	},
}
