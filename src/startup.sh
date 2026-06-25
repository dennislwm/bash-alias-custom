if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM="auto"
    PS1="\[\033[36m\]\u@\[\033[35m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[32m\]$(__git_ps1 ' (%s)')\[\033[m\]\$ "
else
    PS1="\[\033[36m\]\u@\[\033[35m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
fi
RC_VERSION="0.1.4"

#
# source sub-scripts
source $HOME/src/archiveboxrc.sh
source $HOME/src/azrc.sh
source $HOME/src/dockerrc.sh
source $HOME/src/gitrc.sh
source $HOME/src/helprc.sh
source $HOME/src/kubectlrc.sh
source $HOME/src/ledgerrc.sh
source $HOME/src/lpassrc.sh
source $HOME/src/sshrc.sh
source $HOME/src/terraformrc.sh
source $HOME/src/watsonrc.sh
source $HOME/src/wprc.sh
source $HOME/src/inputrc.sh

#
# external aliases
alias rcc='code ~/src/startup.sh'
alias rcs='source ~/src/startup.sh'

#
# external functions
rc-open() {
    local dir="${1:-$HOME/src}"
    ls "$dir"
    local rcfile
    rcfile=$(inp-rcfile)
    if [ -n "$rcfile" ]; then
        echo "code $dir/$rcfile"
        code "$dir/$rcfile"
        echo "done"
    else
        echo "user cancel"
    fi
}
rc-code()   { rc-open "$HOME/src"; }
rc-config() { rc-open "$str_path_config"; }
rc-who() {
    USER=$(whoami)
    echo $USER
}

#
# inputs
inp-rcfile() { read -p "Enter filename OR BLANK to quit: " rcfile;
    if [ -z $rcfile ]; then
        echo ""
    else
        echo $rcfile
    fi
}

#
# global variables
str_user=$(rc-who)
str_path_config="/Users/$str_user/fx-git-pull/02bash-alias-custom/config"
str_path="/Users/$str_user/fx-git-pull"
str_docker_localdir="/Users/$str_user/docker/"
str_path_ssh="/Users/$str_user/.ssh"
str_file_ssh_config="/Users/$str_user/.ssh/config"
str_file_ssh_do1="/Users/$str_user/.ssh/id_rsa_do1"
str_file_config="$str_path_config/config.txt"
str_file_ipaddr="$str_path_config/ipaddr.txt"
str_file_localdir="$str_path_config/localdir.txt"
str_file_remotedir="$str_path_config/remotedir.txt"
