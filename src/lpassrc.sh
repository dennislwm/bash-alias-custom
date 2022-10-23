#--------
# aliases
alias lp='lpass'
alias lpc='code ~/.lpass/env'
alias lph='lpass --help'
alias lpls='lpass ls'
alias lpshn='lpass show --notes'
alias lpsy='lpass sync'

#----------
# functions
lp-login() {
  cancel=true
  strName=$( inp-str email )
  if [ ! -z "$strName" ]; then
    lpass login "$strName"
  else
    echo "user cancel"
  fi
}
lp_note_add() {
  cancel=true
  ls -lart
  strName=$( inp-str "group/file" )
  if [ ! -z "$strName" ]; then
    group="${strName%/*}"
    file="${strName##*/}"
    if [ -f "$group/$file" ]; then
      if [ -d "$group" ]; then
        #---------
        # Is note?
        exist=$( lp_is_note "$group/$file" )
        if [ ! -z "$exist" ]; then
          #---------
          # Replace?
          ok=$( lp_yesno "Replace existing note $group/$file? " )
        else
          ok=$( lp_yesno "Add new note $group/$file? ")
        fi
        if [ ok ]; then
          cat "$group/$file" | lpass edit --notes --non-interactive "$group/$file"
          lpass sync
          cancel=false
        fi
      fi
    else
      echo "Error: No such folder or file [$group/$file]"
      return 1
    fi
  fi
  if $cancel; then
    echo "Exit: user cancel"
  else
    echo "Exit: success"
  fi
}

#-------
# inputs
lp_name() {
  read -p "Enter name$1, OR BLANK to quit: " name
  if [ -z $name ]; then
    echo ""
  else
    echo $name
  fi
}

lp_is_note() {
  if [ -z $1 ]; then
    return
  else
    # -w exact word 
    echo -n $( lpass ls | grep -w $1 )
  fi
}

lp_yesno() {
  read -p "$1(only 'yes' accepted): " yesno
  ret=true
  if [ -z $yesno ]; then
    ret=false
  elif [ $yesno != "yes" ]; then
    ret=false
  fi
  echo $ret
}
