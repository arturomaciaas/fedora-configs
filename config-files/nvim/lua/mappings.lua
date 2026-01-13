require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

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

-- Split shortcuts
map("n", "<C-x>", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<C-v>", "<cmd>vsplit<cr>", { desc = "Vertical split" })

-- Override NvChad's buffer close with window close
map("n", "<leader>x", "<cmd>bp|bd #<cr>", { desc = "Close current buffer, keep window" })

-- LSP diagnostics
map("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show full error/diagnostic" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
