#
# source sub-scripts
source $HOME/src/dockerrc.sh
source $HOME/src/gitrc.sh
source $HOME/src/helprc.sh
source $HOME/src/sshrc.sh
source $HOME/src/terraformrc.sh
source $HOME/src/wprc.sh

#
# external aliases
alias rcc='code ~/.bashrc'
alias rcs='source ~/.bashrc'

#
# global variables
str_path_config="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/25bash-alias-custom/config"
str_file_config="$str_path_config/config.txt"
str_file_ipaddr="$str_path_config/ipaddr.txt"
str_file_localdir="$str_path_config/localdir.txt"
str_file_remotedir="$str_path_config/remotedir.txt"

#
# external functions
rc-code() {
    cancel=true
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

#
# inputs
inp-rcfile() {
    read -p "Enter filename OR BLANK to quit: " rcfile
    if [ -z $rcfile ]; then
        echo ""
    else
        echo $rcfile
    fi
}