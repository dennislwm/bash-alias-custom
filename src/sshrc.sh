#
# internal aliases
alias bash_scpdir='scp -F c:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1 -r'
alias bash_ssh='ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1'

#
# external functions
scp-dn() {
  cancel=true
  ipaddr=$(inp-ipaddr)
  if [ ! -z "$ipaddr" ]; then 
    remotedir=$(inp-remotedir)
    if [ ! -z "$remotedir" ]; then 
      localdir="d:\\docker"
      echo "bash_scpdir root@$ipaddr:$remotedir $localdir"
      bash_scpdir root@$ipaddr:$remotedir $localdir
      cancel=false
    fi
  fi
  if $cancel; then
    echo "user cancel"
  else
    echo "done"
  fi
}
scp-up() {
  cancel=true
  ipaddr=$(inp-ipaddr)
  if [ ! -z "$ipaddr" ]; then 
    localdir=$(inp-dockerdir)
    if [ ! -z "$localdir" ]; then 
      remotedir="/root/"
      echo "bash_scpdir $localdir root@$ipaddr:$remotedir"
      cd "d:\\docker"
      bash_scpdir $localdir root@$ipaddr:$remotedir
      cancel=false
    fi
  fi
  if $cancel; then
    echo "user cancel"
  else
    echo "done"
  fi
}

#
# inputs
inp-dockerdir() {
  value=("caddy" "couchdb" "teedy")
  PS3="Which 1-3) OR q)uit: "
  select val in "${value[@]}"
  do
    case $REPLY in
      "1"|"2"|"3")
        echo $val
        break
        ;;
      "q")
        echo ""
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
}

inp-localdir() {
  value=("d:\\docker" "d:\\docker\\caddy" "d:\\docker\\couchdb" "d:\\docker\\teedy")
  PS3="Which 1-4) OR q)uit: "
  select val in "${value[@]}"
  do
    case $REPLY in
      "1"|"2"|"3"|"4")
        echo $val
        break
        ;;
      "q")
        echo ""
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
}

inp-ipaddr() {
  key=("do3couchdb" "do3jitsi" "do3teedy")
  keyold=("do2all" "do2couchdb" "do2teedy")
  value=("134.209.100.112" "178.128.127.42" "167.71.204.230")
  valueold=("165.22.241.114" "209.97.171.141" "167.71.198.35")

  PS3="Which 1) ${key[0]} 2) ${key[1]} 3) ${key[2]} 4) ${keyold[0]} 5) ${keyold[1]} 6) ${keyold[2]} OR q)uit: "
  select val in "${value[@]}" "${valueold[@]}"
  do
    case $REPLY in
      "1"|"2"|"3")
        echo $val
        break
        ;;
      "3"|"4"|"5")
        echo $val
        break
        ;;
      "q")
        echo ""
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
}

inp-remotedir() {
  value=("/root/" "/root/bin/" "/root/caddy/" "/root/couchdb/" "/root/teedy/")
  PS3="Which 1-5) OR q)uit: "
  select val in "${value[@]}"
  do
    case $REPLY in
      "1"|"2"|"3"|"4"|"5")
        echo $val
        break
        ;;
      "q")
        echo ""
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
}