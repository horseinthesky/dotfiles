-- Install plugins
require "plugins"

-- Sensible defaults
require "settings"

-- Key mappings
require "keymappings"

-- Set colorscheme
require "colorscheme"

-- Plugin settings
require "plugin_settings"

-- Which-key
require "which_key"

-- Setup Lua language server using submodule
require "lsp"

-- Statusline
require "statusline"

-- For debugging purpose
function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, {...})
	print(unpack(objects))
end
