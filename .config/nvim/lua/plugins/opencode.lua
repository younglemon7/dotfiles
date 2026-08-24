vim.pack.add({
  { src = "https://github.com/nickjvandyke/opencode.nvim" },
})

local opencode_port = 53124
local tmux_pane_id = nil

local function pane_exists(pane_id)
  if not pane_id or vim.fn.executable("tmux") ~= 1 then
    return false
  end

  local result = vim.system({ "tmux", "list-panes", "-a", "-F", "#{pane_id}" }, { text = true }):wait()
  if result.code ~= 0 then
    return false
  end

  for id in result.stdout:gmatch("[^\n]+") do
    if id == pane_id then
      return true
    end
  end

  return false
end

local function start_tmux_opencode()
  if vim.fn.executable("tmux") ~= 1 or vim.env.TMUX == nil then
    require("opencode.terminal").open("opencode --port " .. opencode_port .. " -c", {
      split = "right",
      width = math.floor(vim.o.columns * 0.35),
    })
    return
  end

  if pane_exists(tmux_pane_id) then
    return
  end

  local split = vim.system({
    "tmux",
    "split-window",
    "-h",
    "-l",
    "35%",
    "-P",
    "-F",
    "#{pane_id}",
    "opencode --port " .. opencode_port .. " -c",
  }, { text = true }):wait()

  if split.code == 0 then
    tmux_pane_id = vim.trim(split.stdout)
  else
    vim.notify("Failed to open opencode in tmux pane", vim.log.levels.ERROR)
  end
end

local function stop_tmux_opencode()
  if pane_exists(tmux_pane_id) then
    vim.system({ "tmux", "kill-pane", "-t", tmux_pane_id }, { text = true }):wait()
  end
  tmux_pane_id = nil
end

vim.g.opencode_opts = {
  server = {
    port = opencode_port,
    start = start_tmux_opencode,
    stop = stop_tmux_opencode,
    toggle = function()
      if pane_exists(tmux_pane_id) then
        stop_tmux_opencode()
      else
        start_tmux_opencode()
      end
    end,
  },
}
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>ox", function()
  require("opencode").select()
end, { desc = "Open opencode actions" })

vim.keymap.set({ "n", "t" }, "<leader>ot", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })
