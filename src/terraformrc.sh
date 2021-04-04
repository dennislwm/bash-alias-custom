#
# external aliases
alias tf='terraform'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfdoc='docker run --rm -v "d:\\denbrige\\180 FxOption\\103 FxOptionVerBack\\083 FX-Git-Pull\\19dscode\\tf\modules":/modules quay.io/terraform-docs/terraform-docs:0.10.1'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfs='terraform show'
alias tfsl='terraform state list'
alias tfsr='terraform state rm'
alias tfv='terraform validate'

#
# internal aliases

#
# external functions
tf-apply() {
    cancel=true
    tfmod=$(inp-tfmod)
    if [ ! -z "$tfmod" ]; then
        echo "tfa -target=module.$tfmod"
        tfa -target=module.$tfmod
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
tf-plan() {
    cancel=true
    tfmod=$(inp-tfmod)
    if [ ! -z "$tfmod" ]; then
        echo "tfp -target=module.$tfmod"
        tfp -target=module.$tfmod
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
tf-destroy() {
    cancel=true
    tfmod=$(inp-tfmod)
    if [ ! -z "$tfmod" ]; then
        echo "tfd -target=module.$tfmod"
        tfd -target=module.$tfmod
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
tf-import() {
    cancel=true
    echo "Import Ssh Key from existing tf:"
    echo "  Use tfs to find the id of digitalocean_ssh_key.objSshKey"
    tfid=$(inp-tfid)
    if [ ! -z "$tfid" ]; then
        echo "terraform import digitalocean_ssh_key.objSshKey $tfid"
        terraform import digitalocean_ssh_key.objSshKey $tfid
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
inp-tfid() {
    read -p "Enter id OR BLANK to quit: " id
    if [ -z $id ]; then
        echo ""
    else
        echo $id
    fi
}
inp-tfmod() {
    read -p "Enter module OR BLANK to quit: " mod
    if [ -z $mod ]; then
        echo ""
    else
        echo $mod
    fi
}