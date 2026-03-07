-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "carbonfox",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.plugins = "plugins/init.lua"

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    show_numbers = false,
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs" },
  }
}

return M
