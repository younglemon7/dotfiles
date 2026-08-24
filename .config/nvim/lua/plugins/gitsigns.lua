vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "▎" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▁" },
    topdelete = { text = "▔" },
    changedelete = { text = "▎" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  current_line_blame = false,
  current_line_blame_opts = {
    delay = 400,
  },
  current_line_blame_formatter = "  <author>, <author_time:%R>",
  watch_gitdir = { follow_files = true },
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, "Next git hunk")

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, "Previous git hunk")

    map("n", "<leader>gp", gitsigns.preview_hunk, "Preview git hunk")
    map("n", "<leader>gr", gitsigns.reset_hunk, "Reset git hunk")
    map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle git blame")
    map("n", "<leader>gw", gitsigns.toggle_word_diff, "Toggle git word diff")
  end,
})
