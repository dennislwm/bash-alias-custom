#
# external aliases
alias ab='archivebox'
alias aba='archivebox add'
alias abcs='archivebox config --set'
alias abmyconf='archivebox config --set CHROME_HEADLESS=True'
alias abmymthd='archivebox config --set SAVE_TITLE=True SAVE_FAVICON=False SAVE_WGET=True SAVE_WARC=False SAVE_PDF=True SAVE_SCREENSHOT=False SAVE_DOM=False SAVE_SINGLEFILE=False SAVE_READABILITY=False SAVE_MERCURY=False SAVE_GIT=False SAVE_MEDIA=False SAVE_ARCHIVE_DOT_ORG=False'
alias abr='archivebox remove'
alias abs='archivebox server'
alias abv='archivebox version'

ab-import() {
  AB_COUCHDB_URI="https://couchdb.markit.work/db-inkdrop"
  AB_COUCHDB_DOC="note:XFhz43AsJ"
  if [ ! -z "$1" ]; then
    AB_COUCHDB_DOC="$1"
  fi
  AB_BODY=$( curl "$AB_COUCHDB_URI/$AB_COUCHDB_DOC" | jq -r .body )
  if [ -z "$AB_BODY" ]; then
    return
  fi
  AB_LIST=( $AB_BODY )
  AB_TOTAL=${#AB_LIST[@]}
  echo "Import ${AB_TOTAL} URLs into ArchiveBox? "
  confirm=$( ab-confirm)
  if [ $confirm == "yes" ]; then
    for (( i=0; i<${AB_TOTAL}; i++ )); do
      echo "${AB_LIST[i]}" | archivebox add
    done
  else
    echo "user cancel"
  fi
}

ab-confirm() {
  read -p "Enter yes to confirm; OR BLANK to quit: " name
  if [ -z $name ]; then \
    echo "" 
  else
    echo $name
  fi
}
