# Multiline prefix
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{249}\u250f"
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{249}\u2517%F{default}"

# Host block settings
typeset -g POWERLEVEL9K_CUSTOM_HOST="custom_host"
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=039
  typeset -g POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=230
else
  source /etc/os-release
  case $ID in
    "ubuntu")
      typeset -g POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=166
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=229
      ;;
    "centos")
      typeset -g POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=160
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=000
      ;;
  esac
fi

DEFAULT_GREY=237 # grey23

# User block settings
typeset -g POWERLEVEL9K_CUSTOM_USER="custom_user"
if [[ $(whoami) == "root" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_USER_BACKGROUND=88
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=229
else
  # typeset -g POWERLEVEL9K_CUSTOM_USER_BACKGROUND=096
  # typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=229
  typeset -g POWERLEVEL9K_CUSTOM_USER_BACKGROUND=214
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=094
fi

# VCS block settings
typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_FOREGROUND=$DEFAULT_GREY
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=142
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=167 #indianred
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=214 # orange1

# Dir block settings
typeset -g POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{237} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{237}"
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0BC ' #  
# typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0BA ' # 
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4' # 
# typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6' # 
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0C6' #  
# typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0C7' #  
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0C0 ' #  
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0CE' #  
# typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0C8 ' #  

typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND=167
typeset -g POWERLEVEL9K_DIR_{DEFAULT,HOME,HOME_SUBFOLDER,ETC,NOT_WRITABLE}_FOREGROUND=$DEFAULT_GREY
typeset -g POWERLEVEL9K_DIR_{DEFAULT,HOME,HOME_SUBFOLDER}_BACKGROUND=033 # dodgerblue1
typeset -g POWERLEVEL9K_DIR_ETC_BACKGROUND=142

# Dir Writable settings
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=167
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=214

# Virtualenv block settings
typeset -g POWERLEVEL9K_{PYENV,VIRTUALENV}_FOREGROUND=004 # dodgerblue3
typeset -g POWERLEVEL9K_{PYENV,VIRTUALENV}_BACKGROUND=220 # gold1

# Battery background color
typeset -g POWERLEVEL9K_BATTERY_{LOW,CHARGING,CHARGED,DISCONNECTED}_BACKGROUND=$DEFAULT_GREY