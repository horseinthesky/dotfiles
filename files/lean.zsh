# Elements settings
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_user
  # dir_writable
  dir
  vcs
  virtualenv
  pyenv
  newline
  prompt_char
)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  custom_host
  load
  ram
  battery
)

# Prefixes
typeset -g POWERLEVEL9K_{CUSTOM_HOST,VCS}_PREFIX='%F{249}on '
typeset -g POWERLEVEL9K_{DIR,VIRTUALENV}_PREFIX='%F{249}in '
typeset -g POWERLEVEL9K_PYENV_PREFIX='%F{249}with '

# Host block settings
typeset -g POWERLEVEL9K_CUSTOM_HOST="custom_host"
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=039
else
  source /etc/os-release
  case $ID in
    "ubuntu")
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=166
      ;;
    "centos")
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=160
      ;;
  esac
fi

# User block settings
typeset -g POWERLEVEL9K_CUSTOM_USER="custom_user"
if [[ $(whoami) == "root" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=167
else
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=214
fi

# VCS block settings
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=142
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=167 #indianred
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=214 # orange1

# Dir block settings
typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol

typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND=167
typeset -g POWERLEVEL9K_DIR_{DEFAULT,HOME,HOME_SUBFOLDER}_FOREGROUND=033 # dodgerblue1
typeset -g POWERLEVEL9K_DIR_ETC_FOREGROUND=142

# Dir Writable settings
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=167
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_ICON=' '

# Virtualenv block settings
typeset -g POWERLEVEL9K_{VIRTUALENV,PYENV}_FOREGROUND=220

# Battery background color
typeset -g POWERLEVEL9K_BATTERY_{LOW,CHARGING,CHARGED,DISCONNECTED}_BACKGROUND=

# CPU and RAM
typeset -g POWERLEVEL9K_{CPU,RAM}_BACKGROUND=
