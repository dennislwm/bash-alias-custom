PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "

#
# source sub-scripts
source $HOME/src/azrc.sh
source $HOME/src/dockerrc.sh
source $HOME/src/gitrc.sh
source $HOME/src/helprc.sh
source $HOME/src/ledgerrc.sh
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
if [ "$str_os" == "WINDOWS" ]; then
    str_user=$(rc-who)
    if [ "$str_user" == "denni" ]; then
        str_path_config="/d/Users/denni/OneDrive/Documents/GitHub/bash-alias-custom/config"
        str_path="/d/Users/denni/OneDrive/Documents/GitHub"
    else
        str_path_config="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/25bash-alias-custom/config"
        str_path="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull"
    fi
    str_docker_localdir='/d/docker/'
else
    str_path_config="/Users/dennislee/fx-git-pull/02bash-alias-custom/config"
    str_path="/Users/dennislee/fx-git-pull"
    str_docker_localdir='/Users/dennislee/docker/'
fi
str_file_config="$str_path_config/config.txt"
str_file_ipaddr="$str_path_config/ipaddr.txt"
str_file_localdir="$str_path_config/localdir.txt"
str_file_remotedir="$str_path_config/remotedir.txt"
