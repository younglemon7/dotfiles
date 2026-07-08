vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter"
})

local ts = require("nvim-treesitter")

ts.setup({})

local parsers = {
  "bash",
  "c",
  "go",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local installed = ts.get_installed()
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, parsers)

if vim.fn.executable("tree-sitter") == 1 and #missing > 0 then
  ts.install(missing)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
