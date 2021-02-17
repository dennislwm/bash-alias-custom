#
# external aliases
alias tf='terraform'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfs='terraform show'

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

#
# inputs
inp-tfmod() {
    read -p "Enter module OR BLANK to quit: " mod
    if [ -z $mod ]; then
        echo ""
    else
        echo $mod
    fi
}