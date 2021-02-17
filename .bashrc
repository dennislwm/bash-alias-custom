PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "

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
# external functions
rc-code() { cancel=true;
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

#
# inputs
inp-rcfile() { read -p "Enter filename OR BLANK to quit: " rcfile;
    if [ -z $rcfile ]; then
        echo ""
    else
        echo $rcfile
    fi
}