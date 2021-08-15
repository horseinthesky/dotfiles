-- Set colorscheme
require "colorscheme"

-- Sensible defaults
require "settings"

-- Install plugins
-- no need to load this immediately, since we have packer_compiled
vim.defer_fn(function()
  require "plugins"
end, 0)

-- Key mappings
require "keymappings"

-- Plugin settings
require "plugin_settings"

-- For debugging purpose
function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, {...})
	print(unpack(objects))
end
