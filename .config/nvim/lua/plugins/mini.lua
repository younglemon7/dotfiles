vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require("mini.indentscope").setup({
  symbol = "│",
  options = { try_as_border = true },
  draw = {
    animation = require("mini.indentscope").gen_animation.none(),
  },
})

require("mini.trailspace").setup()

require("mini.surround").setup()

require("mini.ai").setup()

require("mini.pairs").setup()

require("mini.comment").setup()

require("mini.bufremove").setup()

vim.keymap.set("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>bD", function()
  require("mini.bufremove").wipeout(0, false)
end, { desc = "Wipeout buffer" })
