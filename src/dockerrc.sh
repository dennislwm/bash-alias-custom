#
# external aliases
alias di='docker image'
alias dib='docker image build'
alias dil='docker image list'
alias dir='docker image rm'
alias dc='docker container'
alias dcd='docker-compose down'
alias dcdw='docker-compose -f docker-compose-win.yml down'
alias dcl='docker container ls -a'
alias dcr='docker container rm'
alias dcrw='docker-compose -f docker-compose-win.yml run --rm'
alias dcs='docker container stop'
alias dcu='docker-compose up -d'
alias dcuw='docker-compose -f docker-compose-win.yml up -d'
alias dr='docker run'
alias drr='docker run --rm'

#
# internal aliases
alias de='docker exec'

#
# external functions
dc-bash() {
    cancel=true
    diname=$(inp-diname)
    if [ ! -z "$diname" ]; then
        echo "drr -it $diname bash"
        drr -it $diname bash
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
    
}
dc-cli() {
    cancel=true
    diname=$(inp-diname)
    if [ ! -z "$diname" ]; then
        echo "drr -it $diname"
        drr -it $diname
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
    
}
di-build() {
    cancel=true
    diname=$(inp-diname)
    if [ ! -z "$diname" ]; then
        echo "dib -t $diname ."
        dib -t $diname .
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
inp-diname() {
    read -p "Enter name and optional tag (name:tag) OR BLANK to quit: " diname
    if [ -z $diname ]; then
        echo ""
    else
        echo $diname
    fi
}
