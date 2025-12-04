-- which-key helps you remember key bindings by showing a popup
-- with the active keybindings of the command you started typing.
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", event = "VeryLazy" },
	{ src = "https://github.com/nvim-mini/mini.icons", event = "VeryLazy" },
})

require("which-key").setup({
	preset = "helix",
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,

	-- Built-in plugins
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},

	-- Window styling
	win = {
		no_overlap = true,
		padding = { 1, 2 },
		title = true,
		title_pos = "center",
		border = "rounded",
	},

	-- Icons configuration
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
		mappings = true,
		colors = true,
	},
	spec = {
		{
			mode = { "n", "x" },
			{ "<leader><tab>", group = "tabs" },
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "file/find" },
			{ "<leader>g", group = "git" },
			{ "<leader>q", group = "quit/session" },
			{ "<leader>s", group = "search" },
			{ "<leader>u", group = "ui" },
			{ "<leader>x", group = "diagnostics/quickfix" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
			{ "z", group = "fold" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>w", group = "windows" },
			-- Your specific mappings
		},
	},
	-- keys = {
	--   {
	--     "<leader>?",
	--     function()
	--       require("which-key").show({ global = false })
	--     end,
	--     desc = "Buffer Keymaps (which-key)",
	--   },
	-- },
})
