local M = {}

M.luafmt = {
  formatCommand = "luafmt -i 2 --stdin",
  formatStdin = true
}

M.flake8 = {
  lintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = {"%f:%l:%c: %m"}
}

M.isort = {
  formatCommand = "isort -",
  formatStdin = true
}

M.autopep8 = {
  formatCommand = "autopep8 --ignore E501 -",
  formatStdin = true
}

M.yapf = {
  formatCommand = "yapf",
  formatStdin = true
}

M.mypy = {
  lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
  lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
}

M.prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

M.shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
}

return M
