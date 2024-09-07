#
# external aliases
alias di='docker image'
alias dib='DOCKER_BUILDKIT=1 docker image build --no-cache'
alias dil='docker image list'
alias dip='docker image prune'
alias dir='docker image rm'
alias dc='docker container'
alias dcd='docker-compose down'
alias dcdw='docker-compose -f docker-compose-win.yml down'
alias dcl='docker container ls -a'
alias dclog='docker-compose logs'
alias dcp='docker container prune'
alias dcr='docker container rm'
alias dcrw='docker-compose -f docker-compose-win.yml run --rm'
alias dcs='docker container stop'
alias dcu='docker-compose up -d'
alias dcub='DOCKER_BUILDKIT=1 docker-compose up -d --build --no-cache'
alias dcuw='docker-compose -f docker-compose-win.yml up -d'
alias dr='docker run'
alias drr='docker run --rm'
alias dlgh='docker login ghcr.io -u dennislwm --password-stdin'
alias dp='docker push'

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

di-tag() {
    cancel=true
    echo "Creating a Docker tag..."
    src_image=$(inp-diname)
    if [ ! -z "$src_image" ]; then
        read -p "Enter the new tag (name:tag): " new_tag
        if [ ! -z "$new_tag" ]; then
            echo "docker tag $src_image $new_tag"
            docker tag $src_image $new_tag
            cancel=false
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

di-pull() {
    cancel=true
    echo "Pulling a Docker image..."
    image_name=$(inp-diname)
    if [ ! -z "$image_name" ]; then
        read -p "Enter optional platform (leave blank for default): " platform
        if [ -z "$platform" ]; then
            echo "docker pull $image_name"
            docker pull $image_name
        else
            echo "docker pull --platform $platform $image_name"
            docker pull --platform $platform $image_name
        fi
        cancel=false
        docker image ls
        di-tag
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
