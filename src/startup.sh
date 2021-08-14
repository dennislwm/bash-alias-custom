PS1="\[\033[36m\]\u@\[\033[35m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
RC_VERSION="0.1.2"

#
# source sub-scripts
source $HOME/src/archiveboxrc.sh
source $HOME/src/azrc.sh
source $HOME/src/dockerrc.sh
source $HOME/src/gitrc.sh
source $HOME/src/helprc.sh
source $HOME/src/ledgerrc.sh
source $HOME/src/lpassrc.sh
source $HOME/src/sshrc.sh
source $HOME/src/terraformrc.sh
source $HOME/src/wprc.sh

#
# external aliases
alias rcc='code ~/src/startup.sh'
alias rcs='source ~/src/startup.sh'

#
# external functions
rc-code() { 
    cancel=true;
    ls $HOME/src
    rcfile=$(inp-rcfile)
    if [ ! -z "$rcfile" ]; then
        echo "code $HOME/src/$rcfile"
        code $HOME/src/$rcfile
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
rc-config() {
    cancel=true
    ls "$str_path_config"
    rcfile=$(inp-rcfile)
    if [ ! -z "$rcfile" ]; then
        echo "code $str_path_config/$rcfile"
        code "$str_path_config/$rcfile"
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
rc-os() {
    UNAME=$(uname)
    if [[ "$UNAME" == MINGW* ]]; then
        echo "WINDOWS"
    else
        echo "LINUX"
    fi
}
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
str_os=$(rc-os)
str_user=$(rc-who)
if [ "$str_os" == "WINDOWS" ]; then
    if [ "$str_user" == "denni" ]; then
        str_path_config="/d/Users/denni/OneDrive/Documents/GitHub/bash-alias-custom/config"
        str_path="/d/Users/denni/OneDrive/Documents/GitHub"
    else
        str_path_config="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/25bash-alias-custom/config"
        str_path="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull"
    fi
    str_docker_localdir='/d/docker/'
else
    str_path_config="/Users/$str_user/fx-git-pull/02bash-alias-custom/config"
    str_path="/Users/$str_user/fx-git-pull"
    str_docker_localdir="/Users/$str_user/docker/"
    str_path_ssh="/Users/$str_user/.ssh"
    str_file_ssh_config="/Users/$str_user/.ssh/config"
    str_file_ssh_do1="/Users/$str_user/.ssh/id_rsa_do1"
fi
str_file_config="$str_path_config/config.txt"
str_file_ipaddr="$str_path_config/ipaddr.txt"
str_file_localdir="$str_path_config/localdir.txt"
str_file_remotedir="$str_path_config/remotedir.txt"
