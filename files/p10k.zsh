if [[ "$P10K_THEME" == "lean" ]]; then
  source $HOME/dotfiles/files/lean.zsh
else
  source $HOME/dotfiles/files/rainbow.zsh
fi

# User
typeset -g POWERLEVEL9K_USER_ICON='\uF415' #  
typeset -g POWERLEVEL9K_ROOT_ICON='\uF198' #  
typeset -g POWERLEVEL9K_HOST_ICON='\uF109' #  
typeset -g POWERLEVEL9K_SSH_ICON='\uF489' #  

# OS
# typeset -g POWERLEVEL9K_ROOT_ICON='\uF09C' #  
# typeset -g POWERLEVEL9K_LINUX_ICON='\uE712' #  
# typeset -g POWERLEVEL9K_LINUX_REDHAT_ICON='\uF309' #  
# typeset -g POWERLEVEL9K_LINUX_UBUNTU_ICON='\uF31B' #  

# Python
typeset -g POWERLEVEL9K_PYTHON_ICON='\uE606' #  

# Pyenv
# Hide python version if it doesn't come from one of these sources.
typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
# If set to false, hide python version if it's the same as global:
# $(pyenv version-name) == $(pyenv global).
typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true
# Hide pyenv segment if its content is "system".
typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT:#system}'
typeset -g POWERLEVEL9K_PYENV_VISUAL_IDENTIFIER_EXPANSION='${${P9K_CONTENT:#system}:+$P9K_VISUAL_IDENTIFIER}'

# Home
typeset -g POWERLEVEL9K_HOME_ICON='\uF015' #  
typeset -g POWERLEVEL9K_HOME_SUB_ICON='\uF07C' #  
typeset -g POWERLEVEL9K_FOLDER_ICON='\uF115' #  

# ETC
# typeset -g POWERLEVEL9K_ETC_ICON=' '
typeset -g POWERLEVEL9K_ETC_ICON=' '

# VCS
typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true
# Custom prefix.
# typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
# Enable counters for staged, unstaged, etc.
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 ' # 
# typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408' #  
typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF113 ' #  
typeset -g POWERLEVEL9K_VCS_GIT_GITLAB_ICON='\uF296 ' #  
typeset -g POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON='\uF171 ' #  
typeset -g POWERLEVEL9K_VCS_GIT_ICON='\uF7A1 ' #  
typeset -g POWERLEVEL9K_VCS_STAGED_ICON='\uF055 ' #  
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='\uF00D ' #  
typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='\uF421 ' #  
typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\uF0AB ' #  
typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\uF0AA ' #  
typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='\uf417 ' # 

# Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
# For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
# can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
# really need it.
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=false

custom_host(){
  if [[ -n "$WSL_DISTRO_NAME" ]]; then
    OS_ICON="\uF17A"
  else
    source /etc/os-release
    case $ID in
      "ubuntu")
        OS_ICON="\uF31B"
        ;;
      "centos")
        OS_ICON="\uF309"
        ;;
    esac
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

custom_user(){
  case $(whoami) in
    "root")
      USER_ICON=$POWERLEVEL9K_ROOT_ICON
      ;;
    *)
      USER_ICON=$POWERLEVEL9K_USER_ICON
      ;;
  esac
  echo -n "$USER_ICON $(whoami) $(zsh_detect_ssh)"
}

# Time block settings
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"

# Dir block settings
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
# POWERLEVEL9K_SHORTEN_DELIMITER='..'
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_VISUAL_IDENTIFIER_EXPANSION=''
# POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=true

# Public IP block settings
# Public IP color.
typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=94
# Custom icon.
typeset -g POWERLEVEL9K_PUBLIC_IP_VISUAL_IDENTIFIER_EXPANSION=''

# Battery block settings
# Show battery in red when it's below this level and not connected to power supply.
typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=167
# Show battery in green when it's charging or fully charged.
typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=142
# Show battery in yellow when it's discharging.
typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=214
# Battery pictograms going from low to high level of charge.
typeset -g POWERLEVEL9K_BATTERY_STAGES=$'\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
# Don't show the remaining time to charge/discharge.
typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false

# Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
# when accepting a command line. Supported values:
#
#   - off:      Don't change prompt when accepting a command line.
#   - always:   Trim down prompt when accepting a command line.
#   - same-dir: Trim down prompt when accepting a command line unless this is the first command
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

# Transparent background. 
typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND= 
# Green prompt symbol if the last command succeeded. 
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=142
# Red prompt symbol if the last command failed.
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=167
# Default prompt symbol.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
# Prompt symbol in command vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
# Prompt symbol in visual vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
# Prompt symbol in overwrite vi mode.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
# No line terminator if prompt_char is the last segment. 
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
# No line introducer if prompt_char is the first segment. 
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL= 
# No surrounding whitespace. 
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE= 

# CPU
# Show average CPU load over this many last minutes. Valid values are 1, 5 and 15.
typeset -g POWERLEVEL9K_LOAD_WHICH=1
# Load color when load is under 50%.
typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=142
# Load color when load is between 50% and 70%. 
typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=214
# Load color when load is over 70%.
typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=167

# RAM color.
typeset -g POWERLEVEL9K_RAM_FOREGROUND=109
