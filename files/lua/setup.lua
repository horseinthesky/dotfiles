-- Install plugins
-- no need to load this immediately, since we have packer_compiled
vim.defer_fn(function()
  require "plugins"
end, 0)

-- Set colorscheme
require "colorscheme"

-- Sensible defaults
require "settings"

-- Key mappings
require "keymappings"

-- Plugin settings
require "plugin_settings"

-- Global functions
require "globals"
