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

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	-- If wezterm.gui is not available use Light as de
	return "Light"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "tokyonight_night"
		-- return "Gruvbox dark, hard (base16)"
		-- return "Everforest Dark (Hard)"
	else
		-- return "Gruvbox light, hard (base16)"
		return "Everforest Light (Hard)"
	end
end

local fonts = wezterm.font_with_fallback({
	{
		family = "monospace",
		harfbuzz_features = { "ss02" },
	},
	{
		family = "Symbols Nerd Font Mono",
		scale = 0.75,
	},
})

local keys = {
	{ key = "F", mods = "CTRL|SHIFT", action = select_and_open_url },
	{ key = "G", mods = "CTRL|SHIFT", action = act.ScrollToBottom },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
	{ key = "K", mods = "CTRL|SHIFT", action = act.ScrollByPage(-0.5) },
	{ key = "J", mods = "CTRL|SHIFT", action = act.ScrollByPage(0.5) },
}

return {
	font = fonts,
	font_size = 12,
	term = "wezterm",
	color_scheme_dirs = { "~/.config/wezterm/colors" },
	-- color_scheme = "tokyonight_night",
	color_scheme = scheme_for_appearance(get_appearance()),
	check_for_updates = false,
	-- show_update_window = false,
	hide_tab_bar_if_only_one_tab = true,
	keys = keys,
	-- window_padding = { left = 0, top = 0, right = 0, bottom = 0 },
}
