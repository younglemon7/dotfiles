-- Render markdown.nvim configuration for beautiful markdown rendering
vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- Required for icons
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Required for parsing
})

require('render-markdown').setup({
  enabled = true,
  max_width = 80,
  padding = { top = 1, bottom = 1 },
  heading = {
    sign = true,
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    signs = { '󰫎 ' },
    width = 'full',
  },
  code = {
    sign = true,
    sign_hl = 'RenderMarkdownCode',
    language_pad = 2,
    width = 'full',
    border = 'thick',
  },
  dash = {
    enabled = true,
    icon = '─',
  },
  bullet = {
    icons = { '●', '○', '◆', '◇' },
  },
  quote = {
    icon = '▋',
    repeat_linebreak = false,
  },
  checkbox = {
    checked = { icon = '󰸞 ', hl = '@markup.list.checked' },
    unchecked = { icon = '󰄱 ', hl = '@markup.list.unchecked' },
  },
  pipe_table = {
    padding = { left = 1, right = 1 },
    min_width = 20,
    border = {
      '┌', '┬', '┐',
      '├', '┼', '┤',
      '└', '┴', '┘',
    },
    alignment_indicator = '━',
  },
  callout = {
    note = { icon = '󰋽 ', hl = 'RenderMarkdownInfo' },
    tip = { icon = '󰌶 ', hl = 'RenderMarkdownSuccess' },
    important = { icon = '󰅾 ', hl = 'RenderMarkdownHint' },
    warning = { icon = '󰀪 ', hl = 'RenderMarkdownWarn' },
    caution = { icon = '󰳦 ', hl = 'RenderMarkdownError' },
  },
  link = {
    image = '󰥶 ',
    email = '󰀓 ',
    hyperlink = '󰌹 ',
    highlight = 'RenderMarkdownLink',
  },
  win_options = {
    conceallevel = {
      default = vim.api.nvim_get_option_value('conceallevel', {}),
      rendered = 3,
    },
  },
  custom_handlers = {},
})