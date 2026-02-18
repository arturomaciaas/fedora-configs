require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Fix Ctrl+Backspace to delete word in insert mode
map("i", "<M-BS>", "<C-W>", { desc = "Delete word backward" })

-- Tmux Navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate previous" })

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

-- Smart split function handles NvimTree vs normal buffers
local function smart_split(direction)
  local api_ok, api = pcall(require, "nvim-tree.api")
  if api_ok and vim.bo.filetype == "NvimTree" then
    local node = api.tree.get_node_under_cursor()
    if node then
      if direction == "horizontal" then
        api.node.open.horizontal()
      elseif direction == "vertical" then
        api.node.open.vertical()
      end
    end
  else
    if direction == "horizontal" then
      vim.cmd("split")
    elseif direction == "vertical" then
      vim.cmd("vsplit")
    end
  end
end

-- Split shortcuts
map("n", "<C-s>s", function() smart_split("horizontal") end, { desc = "Horizontal split" })
map("n", "<C-s>v", function() smart_split("vertical") end, { desc = "Vertical split" })

-- Override NvChad's buffer close with window close
map("n", "<leader>x", "<cmd>bp|bd #<cr>", { desc = "Close current buffer, keep window" })

-- LSP diagnostics
map("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show full error/diagnostic" })

-- Toggle NvimTree with <leader>e
map("n", "<leader>e", function()
  local api_ok, nvimtree = pcall(require, "nvim-tree.api")
  if api_ok then
    nvimtree.tree.toggle()
  else
    vim.cmd("NvimTreeToggle")
  end
end, { desc = "Toggle file explorer" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
