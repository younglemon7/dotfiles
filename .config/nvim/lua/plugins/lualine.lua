-- Simple lualine configuration
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local function obsidian_workspace()
	local current_dir = vim.fn.getcwd()
	if current_dir:match("notes") then
		return "📝 " .. vim.fn.fnamemodify(current_dir, ":t")
	end
	return ""
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { obsidian_workspace, "branch", "diff" },
		lualine_c = {
			{
				"filename",
				path = 1, -- 0: Just filename, 1: Relative path, 2: Absolute path
				file_status = true,
				shorting_target = 40,
				symbols = {
					modified = "[+]",
					readonly = "🔒",
					unnamed = "[No Name]",
				},
			},
		},

		lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		-- lualine_c = {'filename'},
		-- lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
