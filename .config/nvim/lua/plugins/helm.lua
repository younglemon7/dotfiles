vim.pack.add({
  { src = "https://github.com/towolf/vim-helm" },
})

vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
    [".*/templates/.*%.yml"] = "helm",
    [".*/templates/.*%.tpl"] = "helm",
  },
})
