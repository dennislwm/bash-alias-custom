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
lp_note_add() {
  cancel=true
  ls
  name=$( lp_name " of file" )
  if [ ! -z "$name" ]; then
    if [ -f "$name" ]; then
      project=$( lp_name " of group" )
      if [ ! -z "$project" ]; then
        #---------
        # Is note?
        exist=$( lp_is_note "$project/$name" )
        if [ ! -z "$exist" ]; then
          #---------
          # Replace?
          ok=$( lp_yesno "Replace existing note $project/$name? " )
        else
          ok=$( lp_yesno "Add new note $project/$name? ")
        fi
        if [ ok ]; then
          cat $name | lpass edit --notes --non-interactive "$project/$name"
          lpass sync
          cancel=false
        fi
      fi
    else
      echo "Error: No such file or directory"
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
