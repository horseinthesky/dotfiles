# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options. This allows you to apply configuration changes without
  # restarting zsh. Edit ~/.p10k.zsh and type `source ~/.p10k.zsh`.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  autoload -Uz is-at-least && is-at-least 5.1 || return

  # ==== Right/Left prompt settings ====
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    custom_user             # username
    dir                     # current directory
    vcs                     # git status
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    # =========================[ Line #2 ]=========================
    newline                 # \n
    prompt_char             # prompt symbol
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    # ip                      # ip address and bandwidth usage for a specified network interface
    # public_ip               # public IP address
    custom_host             # os icon and hostname
    # load                  # CPU load
    # ram                   # free RAM
    # battery               # internal battery
  )

  # ==== Custom functions ====
  source /etc/os-release

  typeset -g POWERLEVEL9K_CUSTOM_HOST="custom_host"
  custom_host(){
    case $ID in
      ubuntu) OS_ICON="\uF31B" ;;
      debian) OS_ICON="\uF306" ;;
      centos) OS_ICON="\uF309" ;;
      manjaro) OS_ICON="\uF312" ;;
      arch) OS_ICON="\uF303" ;;
      *) OS_ICON="\uF17C" ;;
    esac

    if [[ -n "$WSL_DISTRO_NAME" ]]; then
      OS_ICON="\uF17A $OS_ICON"
    fi

    echo -n "$OS_ICON $HOST"
  }

  zsh_detect_ssh(){
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      echo -n "$(print_icon 'SSH_ICON') "
    else
      echo -n "$(print_icon 'HOST_ICON') "
    fi
  }

  USERNAME=$(whoami)

  typeset -g POWERLEVEL9K_CUSTOM_USER="custom_user"
  custom_user(){
    case $USERNAME in
      root) USER_ICON=$POWERLEVEL9K_ROOT_ICON ;;
      *) USER_ICON=$POWERLEVEL9K_USER_ICON ;;
    esac

    echo -n "$USER_ICON $USERNAME $(zsh_detect_ssh)"
  }

  # Basic style options that define the overall look of your prompt. You probably don't want to
  # change them.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol

  # ==== P10K Theme ====
  [[ -f '$ZDOTDIR/$P10K_THEME.zsh' ]] || source $ZDOTDIR/$P10K_THEME.zsh

  # Defines character set used by powerlevel10k. It's best to let `p10k configure` set it for you.
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete

  # When set to `moderate`, some icons will have an extra space after them. This is meant to avoid
  # icon overlap when using non-monospace fonts. When set to `none`, spaces are not added.
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate

  # Instant prompt mode.
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, haven't
  #              seen the warning, or if you are unsure what this all means.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # ==== Icon berofe content ====
  # When set to true, icons appear before content on both sides of the prompt. When set
  # to false, icons go after content. If empty or not set, icons go before content in the left
  # prompt and after content in the right prompt.
  #
  # You can also override it for a specific segment:
  #
  #   POWERLEVEL9K_STATUS_ICON_BEFORE_CONTENT=false
  #
  # Or for a specific segment in specific state:
  #
  #   POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=false
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true

  # Add an empty line before each prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Connect left prompt lines with these symbols.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=
  # Connect right prompt lines with these symbols.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=

  # The left end of left prompt.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  # The right end of right prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=

  # Ruler, a.k.a. the horizontal line before each prompt. If you set it to true, you'll
  # probably want to set POWERLEVEL9K_PROMPT_ADD_NEWLINE=false above and
  # POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' ' below.
  typeset -g POWERLEVEL9K_SHOW_RULER=false
  typeset -g POWERLEVEL9K_RULER_CHAR='─'        # reasonable alternative: '·'
  typeset -g POWERLEVEL9K_RULER_FOREGROUND="#665c54"

  # Filler between left and right prompt on the first prompt line. You can set it to '·' or '─'
  # to make it easier to see the alignment between left and right prompt and to separate prompt
  # from command output. It serves the same purpose as ruler (see above) without increasing
  # the number of prompt lines. You'll probably want to set POWERLEVEL9K_SHOW_RULER=false
  # if using this. You might also like POWERLEVEL9K_PROMPT_ADD_NEWLINE=false for more compact
  # prompt.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
  if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
    # The color of the filler.
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND="#665c54"
    # Add a space between the end of left prompt and the filler.
    typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=' '
    # Add a space between the filler and the start of right prompt.
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=' '
    # Start filler from the edge of the screen if there are no left segments on the first line.
    typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
    # End filler on the edge of the screen if there are no right segments on the first line.
    typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
  fi

  # ======== User ========
  typeset -g POWERLEVEL9K_USER_ICON='\uF415' # 
  typeset -g POWERLEVEL9K_ROOT_ICON='\uF198' # 
  # typeset -g POWERLEVEL9K_ROOT_ICON='\uF09C' # 
  typeset -g POWERLEVEL9K_SSH_ICON='\uF489' # 
  typeset -g POWERLEVEL9K_HOST_ICON='' # \uF108
  if [[ -d /sys/class/power_supply/BAT0 ]] && grep -Fxq "1" /sys/class/power_supply/BAT0/present; then
    typeset -g POWERLEVEL9K_HOST_ICON='' # \uF109
  elif [[ -d /sys/class/power_supply/BAT1 ]] && grep -Fxq "1" /sys/class/power_supply/BAT1/present; then
    typeset -g POWERLEVEL9K_HOST_ICON='' # \uF109
  elif [[ -d /sys/class/power_supply/battery ]] && grep -Fxq "1" /sys/class/power_supply/battery/present; then
    typeset -g POWERLEVEL9K_HOST_ICON='' # \uF109
  fi

  # ==== OS ====
  # typeset -g POWERLEVEL9K_LINUX_ICON='\uE712' # 
  # typeset -g POWERLEVEL9K_LINUX_REDHAT_ICON='\uF316' # 
  # typeset -g POWERLEVEL9K_LINUX_UBUNTU_ICON='\uF31B' # 

  # ==== Python ====
  typeset -g POWERLEVEL9K_PYTHON_ICON='\uE606' # 

  # ==== Pyenv ====
  # Hide python version if it doesn't come from one of these sources.
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  # If set to false, hide python version if it's the same as global:
  # $(pyenv version-name) == $(pyenv global).
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

  # Pyenv segment format. The following parameters are available within the expansion.
  #
  # - P9K_CONTENT                Current pyenv environment (pyenv version-name).
  # - P9K_PYENV_PYTHON_VERSION   Current python version (python --version).
  #
  # The default format has the following logic:
  #
  # 1. Display "$P9K_CONTENT $P9K_PYENV_PYTHON_VERSION" if $P9K_PYENV_PYTHON_VERSION is not
  #   empty and unequal to $P9K_CONTENT.
  # 2. Otherwise display just "$P9K_CONTENT".

  # Hide pyenv segment if its content is "system".
  typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT:#system}'
  typeset -g POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_EXPANSION='${${P9K_CONTENT:#system}:+$P9K_VISUAL_IDENTIFIER}'

  # ==== Home ====
  typeset -g POWERLEVEL9K_HOME_ICON='\uF015' # 
  typeset -g POWERLEVEL9K_HOME_SUB_ICON='\uF07C' # 
  typeset -g POWERLEVEL9K_FOLDER_ICON='\uF115' # 

  # ==== ETC ====
  # typeset -g POWERLEVEL9K_ETC_ICON=' '
  typeset -g POWERLEVEL9K_ETC_ICON=' '

  # ==== VCS ====
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  typeset -g POWERLEVEL9K_VCS_GIT_ICON='' # \uF7A1
  # typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=' ' # \uF408
  # typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=' ' # \uF113
  typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON='' # \uF7A1
  typeset -g POWERLEVEL9K_VCS_GIT_GITLAB_ICON=' ' # \uF296
  typeset -g POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=' ' # \uF171
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' ' # \uF418
  typeset -g POWERLEVEL9K_VCS_STASH_ICON=' ' # \uF01C
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON=' ' # \uF055
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON=' ' # \uF00D
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON=' ' # \uF421
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_ICON=' ' # \uF059
  typeset -g POWERLEVEL9K_VCS_COMMITS_BEHIND_ICON=' ' # \uF0AB
  typeset -g POWERLEVEL9K_VCS_COMMITS_AHEAD_ICON=' ' # \uF0AA
  typeset -g POWERLEVEL9K_VCS_PUSH_COMMITS_BEHIND_ICON=' ' # \uF0A8
  typeset -g POWERLEVEL9K_VCS_PUSH_COMMITS_AHEAD_ICON=' ' # \uF0A9
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON=' ' # \uf417

  # ==== Time ====
  POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"

  # ==== Dir ====
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
  typeset -g POWERLEVEL9K_LOCK_ICON=''

  # Shortening rules
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='..'
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

  # DIR_CLASSES allows you to specify custom icons for different directories.
  # It must be an array with 3 * N elements. Each triplet consists of:
  #
  #   1. A pattern against which the current directory is matched. Matching is done with
  #      extended_glob option enabled.
  #   2. Directory class for the purpose of styling.
  #   3. Icon.
  #
  # Triplets are tried in order. The first triplet whose pattern matches $PWD wins. If there
  # are no matches, the directory will have no icon.
  typeset -g POWERLEVEL9K_DIR_CLASSES=(
    '~/dotfiles(|/*)'  DOTFILES     ''
    '~/netinfra(|/*)'  NETINFRA     '歷'
    '~(|/*)'           HOME         ''
    '/etc(|/*)'        ETC          ''
    '/usr(|/*)'        USR          ''
    '/tmp(|/*)'        TMP          '﯊'
    '/bin(|/*)'        BIN          ''
    '/home(|/*)'       HOME         ''
    '/proc(|/*)'       PROC         ''
    '/usr(|/*)'        CODE         '' # '   '
    '*'                DEFAULT      '')

  # You can also set different colors for directories of different classes. Remember to override
  # FOREGROUND, SHORTENED_FOREGROUND and ANCHOR_FOREGROUND for every directory class that you wish
  # to have its own color.
  #
  #   typeset -g POWERLEVEL9K_DIR_WORK_FOREGROUND=31
  #   typeset -g POWERLEVEL9K_DIR_WORK_SHORTENED_FOREGROUND=103
  #   typeset -g POWERLEVEL9K_DIR_WORK_ANCHOR_FOREGROUND=39

  # ==== Battery ====
  # Show battery in blue when it's charging or fully charged.
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND="#83a598"
  # Battery colors for different levels of charge when disconnected.
  typeset -g POWERLEVEL9K_BATTERY_LEVEL_FOREGROUND=(
    167 167 167 214 214 214 214 142 142 142)
  # Battery colors for different levels of charge when charging.
  # typeset -g POWERLEVEL9K_BATTERY_CHARGING_LEVEL_FOREGROUND=(
  #   167 167 167 214 214 214 214 142 142 142)
  # Battery pictograms going from low to high level of charge (when disconnected).
  typeset -g POWERLEVEL9K_BATTERY_STAGES=$'\uf582\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  # Battery pictograms going from low to high level of charge when charging.
  # typeset -g POWERLEVEL9K_BATTERY_CHARGING_STAGES=$'\uf585\uf586\uf587\uf588\uf589\uf58a\uf584'
  # Pictogram to show when the battery is charging and fully charged and connected to power supply.
  # typeset -g POWERLEVEL9K_BATTERY_CHARGED_VISUAL_IDENTIFIER_EXPANSION=$'\uf584' # 
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_VISUAL_IDENTIFIER_EXPANSION=$'\uf583' # 
  # Don't show the remaining time to charge/discharge.
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false

  # ==== Prompt char ====
  # Transparent background
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  # Green prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="#b8bb26"
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND="#fb4934"
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION=''
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION=''
  # Prompt symbol in visual vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  # Prompt symbol in overwrite vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION=''
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  # No line terminator if prompt_char is the last segment.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  # No line introducer if prompt_char is the first segment.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  # No surrounding whitespace.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  # ==== CPU ====
  # Show average CPU load over this many last minutes. Valid values are 1, 5 and 15.
  typeset -g POWERLEVEL9K_LOAD_WHICH=1
  # Load color when load is under 50%.
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="#b8bb26"
  # Load color when load is between 50% and 70%.
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND="#fabd2f"
  # Load color when load is over 70%.
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="#fb4934"

  # ==== RAM ====
  typeset -g POWERLEVEL9K_RAM_FOREGROUND="#83a598"

  # ==== Public IP ====
  # Public IP color.
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND="#875f00"
  # Custom icon.
  typeset -g POWERLEVEL9K_PUBLIC_IP_VISUAL_IDENTIFIER_EXPANSION='' # \uF484

  # ==== IP ====
  # IP address and bandwidth usage for a specified network interface
  typeset -g POWERLEVEL9K_IP_FOREGROUND="#875f00"
  typeset -g POWERLEVEL9K_IP_RX_RATE_FOREGROUND="#5faf00"
  typeset -g POWERLEVEL9K_IP_TX_RATE_FOREGROUND="#00afd7"

  # The following parameters are accessible within the expansion:
  #
  #   Parameter             | Meaning
  #   ----------------------+---------------
  #   P9K_IP_IP         | IP address
  #   P9K_IP_INTERFACE  | network interface
  #   P9K_IP_RX_BYTES   | total number of bytes received
  #   P9K_IP_TX_BYTES   | total number of bytes sent
  #   P9K_IP_RX_RATE    | receive rate (since last prompt)
  #   P9K_IP_TX_RATE    | send rate (since last prompt)
  typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='$P9K_IP_INTERFACE $P9K_IP_IP${P9K_IP_RX_RATE:+ %${POWERLEVEL9K_IP_RX_RATE_FOREGROUND}F $P9K_IP_RX_RATE}${P9K_IP_TX_RATE:+ %${POWERLEVEL9K_IP_TX_RATE_FOREGROUND}F $P9K_IP_TX_RATE} '

  # Show information for the first network interface whose name matches this regular expression.
  # Run `ifconfig` or `ip -4 a show` to see the names of all network interfaces.
  typeset -g POWERLEVEL9K_IP_INTERFACE='e.*|.*br.*'

  # Custom icon.
  # typeset -g POWERLEVEL9K_IP_VISUAL_IDENTIFIER_EXPANSION='⭐'

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
