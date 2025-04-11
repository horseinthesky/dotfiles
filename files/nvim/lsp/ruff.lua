return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "requirements.txt",
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
  },
  settings = {
    args = {
      "--line-length",
      "100",
      "--select",
      "I,F,W,E,B,A,C,RET",
      "--ignore",
      "E501,F401,F821",
    },
  },
}
