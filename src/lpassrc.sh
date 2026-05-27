#--------
# aliases
alias lp='lpass'
alias lpc='code ~/.lpass/env'
alias lph='lpass --help'
alias lpls='lpass ls'
alias lpshn='lpass show --notes'
alias lpsy='lpass sync'
alias lpl='lpass login'
alias lpex='lp_env_export'
alias lpaa='lpa_env_add'
alias lpae='lpa_env_edit'
alias lpad='lpa_env_del'
alias lpes='lp_env_shell'

#----------
# functions
lpa_default_note() {
  local remote
  remote=$(git config remote.origin.url 2>/dev/null) || return 1
  local note
  note="$(basename "$remote" .git)/env"
  echo "Using note: $note" >&2
  echo "$note"
}

lp_env_export() {
  [ -z "$1" ] && { echo "Usage: lp_env_export <group/name>"; return 1; }
  lpass status --quiet 2>/dev/null || { echo "Error: not logged in — run lpass login"; return 1; }
  eval "$(lpass show --notes "$1")"
}

lpa_env_add() {
  local note="$1"
  if [ -z "$note" ]; then
    note=$(lpa_default_note) || { echo "Usage: lpa_env_add <group/name>"; echo "       cat file.env | lpa_env_add <group/name>"; echo "       echo 'KEY=val' | lpa_env_add <group/name>"; return 1; }
  fi
  lpass status --quiet 2>/dev/null || { echo "Error: not logged in — run lpass login"; return 1; }
  local content
  content=$(cat)
  [ -z "$content" ] && { echo "Error: no content provided"; return 1; }
  lpass sync
  local exist=$(lpass ls | grep -F "$note")
  [ -n "$exist" ] && { echo "Error: '$note' already exists — use lpa_env_edit to update"; return 1; }
  printf '%s\n' "$content" | lpass add --notes --non-interactive "$note"
}

lpa_env_edit() {
  local note="$1"
  if [ -z "$note" ]; then
    note=$(lpa_default_note) || { echo "Usage: lpa_env_edit <group/name>"; echo "       cat file.env | lpa_env_edit <group/name>"; echo "       echo 'KEY=val' | lpa_env_edit <group/name>"; return 1; }
  fi
  lpass status --quiet 2>/dev/null || { echo "Error: not logged in — run lpass login"; return 1; }
  local content
  content=$(cat)
  [ -z "$content" ] && { echo "Error: no content provided"; return 1; }
  local existing
  existing=$(lpass show --notes "$note")
  [ -z "$existing" ] && { echo "Error: '$note' does not exist — use lpa_env_add to create"; return 1; }
  printf '%s\n' "$existing" >&2
  local tmp_content tmp_existing
  tmp_content=$(mktemp /tmp/lpass_content_XXXXXX.env)
  tmp_existing=$(mktemp /tmp/lpass_existing_XXXXXX.env)
  chmod 600 "$tmp_content" "$tmp_existing"
  printf '%s\n' "$content"  > "$tmp_content"
  printf '%s\n' "$existing" > "$tmp_existing"
  local merged
  merged=$(awk -F= '
    NR==FNR { if ($1 != "" && substr($1,1,1) != "#") a[$1]=$0; next }
    { if ($1 in a) { print a[$1]; delete a[$1] } else print }
    END { for (k in a) print a[k] }
  ' "$tmp_content" "$tmp_existing")
  rm -f "$tmp_content" "$tmp_existing"
  [ -z "$merged" ] && { echo "Error: merge failed"; return 1; }
  [ "$merged" = "$existing" ] && { echo "[SKIP] no changes"; return 0; }
  lpass sync
  printf '%s\n' "$merged" | lpass edit --notes --non-interactive "$note"
}

lpa_env_del() {
  local force=false
  [ "$1" = "-f" ] && { force=true; shift; }
  local note="$1"
  if [ -z "$note" ]; then
    note=$(lpa_default_note) || { echo "Usage: lpa_env_del [-f] <group/name> <KEY> [KEY2 ...]"; echo "       lpa_env_del group/name KEY1 KEY2 KEY3"; return 1; }
  else
    shift
  fi
  [ -z "$1" ] && { echo "Usage: lpa_env_del [-f] <group/name> <KEY> [KEY2 ...]"; return 1; }
  lpass status --quiet 2>/dev/null || { echo "Error: not logged in — run lpass login"; return 1; }
  local existing
  existing=$(lpass show --notes "$note" 2>/dev/null)
  [ -z "$existing" ] && { echo "Error: '$note' does not exist"; return 1; }
  printf '%s\n' "$existing" >&2
  local updated="$existing"
  for key in "$@"; do
    if printf '%s\n' "$updated" | awk -F= -v key="$key" '$1 == key {found=1} END {exit !found}'; then
      updated=$(printf '%s\n' "$updated" | awk -F= -v key="$key" '$1 != key')
    else
      echo "Warning: key '$key' not found — skipping" >&2
    fi
  done
  [ "$updated" = "$existing" ] && { echo "[SKIP] no keys removed"; return 0; }
  if [ "$force" = false ]; then
    [ -t 0 ] || { echo "Error: not a terminal — use -f to force"; return 1; }
    local confirm
    confirm=$(lp_yesno "Delete keys from '$note'? ")
    [ "$confirm" != "true" ] && { echo "Exit: user cancel"; return 0; }
  fi
  lpass sync
  printf '%s' "$updated" | lpass edit --notes --non-interactive "$note"
}

lp_env_shell() {
  local note="$1"
  if [ -z "$note" ]; then
    note=$(lpa_default_note) || { echo "Usage: lp_env_shell <group/name>"; return 1; }
  fi
  lpass status --quiet 2>/dev/null || { echo "Error: not logged in — run lpass login"; return 1; }
  local content
  content=$(lpass show --notes "$note" 2>/dev/null)
  [ $? -ne 0 ] && { echo "Error: '$note' not found"; return 1; }
  [ -z "$content" ] && { echo "Error: '$note' is empty"; return 1; }
  ( eval "$content"; exec "$SHELL" -i )
}

lp_login() {
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
