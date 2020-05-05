#
# external aliases
alias tf='terraform'
alias tfa='terraform apply'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfs='terraform show'

#
# internal aliases
alias bash_tfd='terraform destroy'

#
# external functions
tf-destroy() {
  cancel=true
  tfmod=$(inp-tfmod)
  if [ ! -z "$tfmod" ]; then 
    echo "bash_tfd -target=module.$tfmod"
    bash_tfd -target=module.$tfmod
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