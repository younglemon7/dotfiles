vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter"
})
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "python", "yaml"},
	auto_install = true,
}
      
