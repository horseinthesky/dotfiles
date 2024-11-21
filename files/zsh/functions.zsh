takedir () {
  mkdir -p $@ && cd ${@:$#}
}

takegit () {
  git clone $1
  cd $(basename ${1%%.git})
}

take () {
  if [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit $1
  else
    takedir $1
  fi
}

hstat() {
  fc -l 1 |
  awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' |
  grep -v "./" | sort -nr | head -20 | column -c3 -s " " -t | nl
}

calc() {
  bc -l <<< $@
}

panes () {
  bash $ZDOTDIR/panes.sh
}

weather () {
  # JSON: weather moscow format=j1
  local options="${2:-1}"
  curl https://wttr.in/"${1}"\?"${options}"
}

erapi_key=71afe1269a1f5f7206152de2b43a9819
rate () {
  local from=${1:-usd}
  local to=${2:-rub}
  local rate=$(curl -s http://api.exchangeratesapi.io/v1/latest\?access_key=${erapi_key} | jq .rates.${(U)to})
  echo 1 ${(U)from} is ${rate} ${(U)to}
}

crate () {
  local coin=${1:-bitcoin}
  local currency=${2:-usd}
  local crate=$(curl -s https://api.coingecko.com/api/v3/simple/price\?ids=${coin}\&vs_currencies=${currency} \
    | jq .${coin}.${currency})
  echo 1 ${coin} is ${crate} $currency
}

cht () {
  local options=${2:-Q}
  curl cht.sh/${1}\?${options}
}

matrix () {
  local lines=$(tput lines)
  cols=$(tput cols)

  awkscript='
  {
    letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
    lines=$1
    random_col=$3
    c=$4
    letter=substr(letters,c,1)
    cols[random_col]=0;
    for (col in cols) {
      line=cols[col];
      cols[col]=cols[col]+1;
      printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
      printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
      if (cols[col] >= lines) {
        cols[col]=0;
      }
    }
  }
  '

  echo -e "\e[1;40m"
  clear

  while :; do
    echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
    sleep 0.05
  done | awk "$awkscript"
}
