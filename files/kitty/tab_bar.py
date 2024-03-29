from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title

LEFT_SEP, RIGHT_SEP = "", ""


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg

    def draw_sep(which: str) -> None:
        screen.cursor.bg = draw_data.default_bg
        screen.cursor.fg = orig_bg
        screen.draw(which)
        screen.cursor.bg = orig_bg
        screen.cursor.fg = orig_fg

    if max_title_length <= 1:
        draw_sep(LEFT_SEP)
        screen.draw("…")
        draw_sep(RIGHT_SEP)
        draw_sep(" ")
        return screen.cursor.x

    draw_sep(LEFT_SEP)
    screen.draw(" ")
    draw_title(draw_data, screen, tab, index)

    extra = screen.cursor.x - before - max_title_length
    if extra >= 0:
        screen.cursor.x -= extra + 3
        screen.draw("…")
    elif extra == -1:
        screen.cursor.x -= 2
        screen.draw("…")

    screen.draw(" ")
    draw_sep(RIGHT_SEP)
    draw_sep(" ")

    return screen.cursor.x
