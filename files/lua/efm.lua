local M = {}

local luafmt = {
  formatCommand = "luafmt -i 2 --stdin",
  formatStdin = true,
}

local stylua = {
  formatCommand = "stylua --config-path $HOME/.config/stylua/stylua.toml -",
  formatStdin = true,
}

local flake8 = {
  lintCommand = "flake8 --ignore=E501,W503 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %m" },
  -- lintCategoryMap = {
  --   W = "W",
  --   E = "E",
  --   F = "E",
  --   C = "E",
  -- },
}

local isort = {
  formatCommand = "isort --profile black -l 100 -",
  formatStdin = true,
}

local autopep8 = {
  formatCommand = "autopep8 --max-line-length 100 -",
  formatStdin = true,
}

local yapf = {
  formatCommand = "yapf",
  formatStdin = true,
}

local black = {
  formatCommand = "black --quiet -l 100 -",
  formatStdin = true,
}

local mypy = {
  lintCommand = "mypy --show-column-numbers --ignore-missing-imports --disable-error-code name-defined --cache-dir=/dev/null",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

M.languages = {
  python = { isort, flake8, black, mypy },
  lua = { stylua },
  yaml = { prettier },
  json = { prettier },
  html = { prettier },
  css = { prettier },
  markdown = { prettier },
}

return M
