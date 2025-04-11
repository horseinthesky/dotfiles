local utils = require "config.utils"

local config = {
  cmd = { "gopls" },
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gotmpl",
  },
  root_markers = {
    "go.mod",
  },
}

---- Yandex specifics
if utils.is_yandex() then
  config = vim.tbl_extend("force", config, {
    -- Custom gopls clubs/arcadia/29210
    -- Custom gopls index dirs IGNIETFERRO-2091
    -- Need to create a .arcadia.root file in the root go.mod dir
    -- root_markers = {
    --   "YAOWNERS",
    --   "ya.make",
    --   ".arcadia.root",
    --   "go.mod",
    -- },
    cmd = { os.getenv "HOME" .. "/.ya/tools/v4/gopls-linux/gopls" },
    settings = {
      gopls = {
        arcadiaIndexDirs = {
          os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/cloudgate",
          os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/healthcheck",
        },
      },
    },
  })
end

return config
