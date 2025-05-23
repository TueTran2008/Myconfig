---@type ChadrcConfig
local M = {}

M.ui = {
	theme = 'chadracula'
	-- theme_toggle = {"chadracula"},
	-- transparency = false
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
