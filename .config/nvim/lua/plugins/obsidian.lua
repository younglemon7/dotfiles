vim.pack.add({ "https://github.com/epwalsh/obsidian.nvim" }, { "https://github.com/nvim-lua/plenary.nvim" })

require("obsidian").setup({
	workspaces = {
		{
			name = "Lemon",
			path = "~/notes",
		},
	},
	notes_subdir = "inbox",
	new_notes_location = "notes_subdir",

	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "notes/dailies",
		-- Optional, if you want to change the date format for the ID of daily notes.
		date_format = "%Y-%m-%d",
		-- Optional, if you want to change the date format of the default alias of daily notes.
		alias_format = "%B %-d, %Y",
		-- Optional, default tags to add to each new daily note created.
		default_tags = { "daily-notes" },
		-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		template = "daily",
	},

	disable_frontmatter = true,
	ui = { enable = false }, -- Disable obsidian UI
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M:%S",
	},
	mappings = {
		-- overrides the 'gf' mapping to work on markdown/wiki links within your vault
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
	},
	completion = {
		nvim_cmp = false,
		min_chars = 2,
	},
})
