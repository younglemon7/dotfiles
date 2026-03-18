vim.pack.add({ "https://github.com/obsidian-nvim/obsidian.nvim" }, { "https://github.com/nvim-lua/plenary.nvim" })

local mappings = require("obsidian.mappings")

require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    {
      name = "Lemon",
      path = "~/notes",
    },
  },
  notes_subdir = "0 Inbox",
  new_notes_location = "notes_subdir",
  daily_notes = {
    folder = "notes/dailies",
    date_format = "YYYY-MM-DD",
    alias_format = "MMMM d, yyyy",
    default_tags = { "daily-notes" },
    template = "daily",
  },
  frontmatter = {
    enabled = true,
  },
  ui = {
    enable = true,
  },
  templates = {
    folder = "templates",
    date_format = "YYYY-MM-DD",
    time_format = "HH:mm:ss",
  },
  mappings = {
    ["gf"] = mappings.gf_passthrough(),
    ["<leader>ch"] = mappings.toggle_checkbox(),
    ["<cr>"] = mappings.smart_action(),
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  picker = {
    name = "telescope.nvim",
  },
})
