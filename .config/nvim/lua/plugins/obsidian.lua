vim.pack.add({
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    {
      name = "Lemon",
      path = "~/notes",
    },
  },
  notes_subdir = "0 Inbox",
  new_notes_location = "current_dir",
  note_id_func = function(title)
    if title ~= nil then
      local slug = title:lower()
      slug = slug:gsub("%s+", "-")
      slug = slug:gsub("[^a-z0-9-]", "")
      slug = slug:gsub("-+", "-")
      slug = slug:gsub("^-", "")
      slug = slug:gsub("-$", "")

      if slug ~= "" then
        return slug
      end
    end

    local suffix = ""
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
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
    enable = false,
  },
  templates = {
    folder = "templates",
    date_format = "YYYY-MM-DD",
    time_format = "HH:mm:ss",
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  picker = {
    name = "telescope.nvim",
  },
})
