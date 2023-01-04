local wezterm = require("wezterm")
local act = wezterm.action
---
--- Actions
---
local select_and_open_url = act.QuickSelectArgs({
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
---
--- Final configuration table
---
return {
	font = wezterm.font("monospace"),
	font_size = 16,
	color_scheme_dirs = { "~/.config/wezterm/colors" },
	color_scheme = "Everforest Light (Hard)",
	unix_domains = {
		{
			name = "unix",
		},
	},
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ key = "P", mods = "CTRL|SHIFT", action = select_and_open_url },
		{ key = "S", mods = "CTRL|SHIFT", action = act.ScrollToBottom },
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
	},
}
