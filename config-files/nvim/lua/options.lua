require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.relativenumber = true
-- o.cursorlineopt ='both' -- to enable cursorline!

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Hide tabline on startup, show when file is opened
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
  callback = function()
    local has_file = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
        has_file = true
        break
      end
    end
    vim.opt.showtabline = has_file and 2 or 0
  end,
})
