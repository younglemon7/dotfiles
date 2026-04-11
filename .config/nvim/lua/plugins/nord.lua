vim.pack.add {
  { src = "https://github.com/shaunsingh/nord.nvim" },
}

local function apply_git_sign_highlights()
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#A3BE8C" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#EBCB8B" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#BF616A" })
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#4C566A", italic = true })
end

local function apply_render_markdown_highlights()
  vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#3B4252" })
  vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#3B4252", fg = "#ECEFF4" })
  vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { fg = "#4C566A" })

  vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#88C0D0", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#81A1C1", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#8FBCBB", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#EBCB8B", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#D8DEE9", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#B48EAD", bold = true })

  vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#81A1C1" })
  vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = "#8FBCBB" })
  vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = "#88C0D0", underline = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownWikiLink", { fg = "#81A1C1", underline = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = "#D8DEE9", bold = true })
  vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = "#E5E9F0" })
end

local function apply_ui_highlights()
  apply_git_sign_highlights()
  apply_render_markdown_highlights()
end

vim.cmd.colorscheme("nord")
apply_ui_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nord",
  callback = apply_ui_highlights,
})
