vim.pack.add { 
  { src = "https://github.com/mikavilpas/yazi.nvim" }
}
require("yazi").setup({
	open_for_directories = false,
	keymaps = {
		show_help = "<f1>",
	},
	yazi_floating_window_border = "none",
})

vim.keymap.set("n", "<leader>n", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in cwd" })
vim.keymap.set("n", "<C-Up>", "<cmd>Yazi toggle<cr>", { desc = "Resume yazi session" })
