-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "monekai",
  changed_themes = {
    monekai = {
      base_16 = {
         base00 = "#27292c",
      },
      base_30 = {
        darker_black = "#1f2123",
        black = "#27292c",
        black2 = "#323742",
        statusline_bg = "#323742",
        lightbg = "#323742"
      }
    }
  }
}

return M
