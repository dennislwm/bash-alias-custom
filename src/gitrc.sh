#
# external aliases
alias ga='git add'
alias gc='git commit'
alias gi='git init'
alias gp='git push'
alias gpo='git push -u origin master'
alias gs='git status'
alias gr='git remote'
alias gro='git remote add origin'

#
# external functions
git-new() {
  cancel=true
  localpath="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/"
  remotepath="github.com:dennislwm"
  echo "Git Project details are as follows:"
  echo "  Local path: $localpath"
  echo "  Remote path: $remotepath"
  echo "WARNING: Create an EMPTY remote Git Project first before continuing!"
  echo "WARNING: git-new() adds and commits ALL existing files into repository!"
  echo "WARNING: Ensure .gitignore file exists!"
  localgit=$(inp-localgit)
  if [ ! -z "$localgit" ]; then 
    remotegit=$(inp-remotegit)
    if [ ! -z "$remotegit" ]; then
      cd "$localpath"
      if [ ! -d "$localgit" ]; then
        echo "mkdir $localgit"
        mkdir $localgit
      else
        echo "Existing project"
      fi
      echo "cd $localgit"
      cd $localgit
      if [ ! -d ".git" ]; then
        echo 'gi'
        gi
      else
        echo "Existing git"
      fi
      echo "ga ."
      ga .
      echo "gc"
      gc
      echo "gro git@$remotepath/$remotegit.git"
      gro git@$remotepath/$remotegit.git
      echo "gpo"
      gpo
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
inp-localgit() {
  read -p "Enter new OR existing local project name; OR BLANK to quit: " name
  if [ -z $name ]; then
    echo ""
  else
    echo $name
  fi
}
#
# inputs
inp-remotegit() {
  read -p "Enter new OR existing remote project name; OR BLANK to quit: " name
  if [ -z $name ]; then
    echo ""
  else
    echo $name
  fi
}