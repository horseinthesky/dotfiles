"""
Configuration example for ``ptpython``.
Copy this file to $XDG_CONFIG_HOME/ptpython/config.py
On Linux, this is: ~/.config/ptpython/config.py
"""
from prompt_toolkit.styles import Style
from ptpython.style import default_ui_style

__all__ = ["configure"]


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.
    :param repl: `PythonRepl` instance.
    """

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = "ipython"  # 'classic' or 'ipython'

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-x C-e in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Use this colorscheme for the code.
    repl.use_code_colorscheme("native")

    # Set color depth (keep in mind that not all terminals support true color).

    # repl.color_depth = "DEPTH_1_BIT"  # Monochrome.
    # repl.color_depth = "DEPTH_4_BIT"  # ANSI colors only.
    repl.color_depth = "DEPTH_8_BIT"  # The default, 256 colors.
    # repl.color_depth = "DEPTH_24_BIT"  # True color.

    # Min/max brightness
    repl.min_brightness = 0.0  # Increase for dark terminal backgrounds.
    repl.max_brightness = 1.0  # Decrease for light terminal backgrounds.

    # Syntax.
    repl.enable_syntax_highlighting = True

    # Install custom colorscheme named 'gruvbox' and use it.
    repl.install_ui_colorscheme("gruvbox", Style.from_dict(gruvbox))
    repl.use_ui_colorscheme("gruvbox")


# Custom colorscheme for the UI. See `ptpython/layout.py` and
# `ptpython/style.py` for all possible tokens.
gruvbox = default_ui_style
_custom_ui_colorscheme = {
    "control-character": "ansiblue",
    "prompt": "bold",
    "in": "#b8bb26 bold",
    "in.number": "",
    "out": "#fb4934",
    "out.number": "",
    "status-toolbar.input-mode": "#d3869b",
    "status-toolbar.key": "#fadb2f",
    "status-toolbar paste-mode-on": "bg:#fb4934 #ffffff",
}
gruvbox.update(_custom_ui_colorscheme)
