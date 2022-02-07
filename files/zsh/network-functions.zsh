# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHTGREY="\e[37m"
GREY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
WHITE="\e[97m"

NORMAL="\e[0m"
BOLD="\e[1m"

# Network
ip4 () {
  curl -w '\n' https://api.ipify.org
}

ip6 () {
  curl -w '\n' https://api64.ipify.org
}

ports() {
  sudo ss -tulpn | grep LISTEN | fzf
}

# RIPEstat
prfx () {
  if [[ ! ${1} ]]; then
    echo -e "${GREY}Returns a list of prefixes owned by AS${NORMAL}\n"
    echo -e "${LIGHTRED}prfx requires AS number.${NORMAL}"
    echo -e "${YELLOW}Example: ${GREEN}prfx as200350${NORMAL}"
    return 1
  fi

  local as="${1}"
  local prefixes=$(curl -s https://stat.ripe.net/data/announced-prefixes/data.json\?resource\="${as}" | jq -r '.data.prefixes[] | .prefix')
  echo -e "${GREEN}$prefixes${NORMAL}"
}

lg () {
  if [[ ! ${1} ]]; then
    echo -e "${GREY}Returns a list of BGP announces of the prefix provided${NORMAL}\n"
    echo -e "${LIGHTRED}lg requires prefix.${NORMAL}"
    echo -e "${YELLOW}Example: ${GREEN}lg 84.201.188.0/23${NORMAL}\n"
    echo -e "${GREY}AS number as a second argument might be provided to filter as_path${NORMAL}"
    echo -e "${YELLOW}Example: ${GREEN}lg 84.201.188.0/23 31133${YELLOW} or ${GREEN}lg 84.201.188.0/23 \"31133 200350\"${NORMAL}"
    return 1
  fi

  local resource="${1}"
  local filter="${2}"
  curl -s https://stat.ripe.net/data/looking-glass/data.json\?resource\="${resource}" | jq --arg as_path "${filter}" '.data.rrcs[].peers[] | select(.as_path | contains($as_path))'
}

rpki () {
  if [[ ${#} -ne 2 ]]; then
    echo -e "${GREY}Returns a status of ROA validation${NORMAL}\n"
    echo -e "${LIGHTRED}rpki requires AS number AND a prefix${NORMAL}"
    echo -e "${YELLOW}Example: ${GREEN}rpki as200350 84.201.188.0/23${NORMAL}"
    return 1
  fi

  local as="${1}"
  local prefix="${2}"
  local rpki_status=$(curl -s https://stat.ripe.net/data/rpki-validation/data.json\?resource\="${as}"\&prefix="${prefix}" | jq -r '.data.status')

  if [[ $rpki_status = "valid" ]]; then
    local color=$GREEN
  elif [[ $rpki_status = "invalid" ]]; then
    local color=$LIGHTRED
  else
    local color=$YELLOW
  fi

  echo -e "${color}$rpki_status${NORMAL}"
}

# Tiny DNS resolver
get_record() {
  grep -E "\s$1\s" | head -n 1 | awk '{print $5}'
}

lookup () {
  echo Querying $2 for $3 >&2
  dig -t $1 +norecurse +noall +authority +answer +additional @$2 $3
}

resolve() {
  local domain=$1
  [[ -z $domain ]] && echo "No domain specified" && return 1

  local record nameserver

  # Start with a root (RIPE NCC) nameserver. That's easy.
  if [[ $2 == "-6" ]]; then
    record="AAAA" && nameserver="2001:7fd::1"
  else
    record="A" && nameserver="193.0.14.129"
  fi

  while true
  do
    local response=$(lookup $record $nameserver $domain)
    local ip=$(echo $response | grep $domain | get_record $record )
    local glueip=$(echo $response | get_record $record | grep -v $domain)
    local ns=$(echo $response | get_record "ns")

    if [[ -n $ip ]]; then
      echo $ip && return
    fi

    if [[ -n $glueip ]]; then
      nameserver=$glueip
    elif [[ -n $ns ]]; then
      nameserver=$(resolve $ns)
    else
      echo "No ip found for $domain" && return 1
    fi
  done
}
