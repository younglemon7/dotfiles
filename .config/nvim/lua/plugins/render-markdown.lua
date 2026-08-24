vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  preset = "obsidian",
  render_modes = { "n", "c", "t" },
  file_types = { "markdown" },
  win_options = {
    conceallevel = {
      default = 0,
      rendered = 3,
    },
    concealcursor = {
      default = "",
      rendered = "",
    },
  },
  code = {
    language_icon = true,
  },
})

vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })
