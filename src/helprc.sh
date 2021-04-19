#
# external aliases
alias h='help'
alias ha='help-all'
alias hb='help-bash'
alias hd='help-docker'
alias hl='help-ledger'
alias hg='help-git'
alias hs='help-ssh'
alias ht='help-terraform'
alias hw='help-wp'

#
# external functions
help() {
    echo "Help Aliases"
    echo "  ha          Help ALL"
    echo "  hb          Help bash"
    echo "  hd          Help docker"
    echo "  hg          Help git"
    echo "  hl          Help ledger"
    echo "  hs          Help ssh"
    echo "  ht          Help terraform"
    echo "  hw          Help wp"
}
help-all() {
    help-bash
    help-docker
    help-git
    help-ledger
    help-ssh
    help-terraform
    help-wp
}
help-bash() {
    echo "Bash Aliases"
    echo "  rcc         Edit startup.sh"
    echo "  rcs         Load startup.sh"
    echo "  rc-code     Interactive Edit of Bash scripts"
    echo "  rc-config   Interactive Edit of Config files"
}
help-docker() {
    echo "Docker Aliases"
    echo "  di          Docker image"
    echo "  dib         Docker image build"
    echo "  dil         Docker image list"
    echo "  dip         Docker image prune"
    echo "  dir         Docker image rm"
    echo "  dc          Docker container"
    echo "  dcd         Docker-compose down"
    echo "  dcdw        Docker-compose -f docker-compose-win.yml down"
    echo "  dcl         Docker container ls -a"
    echo "  dclog       Docker-compose logs"
    echo "  dcp         Docker container prune"
    echo "  dcr         Docker container rm"
    echo "  dcs         Docker container stop"
    echo "  dcu         Docker-compose up -d"
    echo "  dcub        Docker-compose up -d --build"
    echo "  dcuw        Docker-compose -f docker-compose-win.yml up"
    echo "  dr          Docker run"
    echo "  drr         Docker run --rm"
    echo "  dc-bash     Interactive Docker bash shell from an image"
    echo "  dc-cli      Interactive Docker command line from an image"
    echo "  di-build    Interactive Docker image build"
}
help-git() {
    echo "Git Aliases"
    echo "  ga          Git add"
    echo "  gba         Git checkout -b <branch>        # add and checkout a branch"
    echo "  gbc         Git checkout <branch>"
    echo "  gbd         Git branch delete <branch>"
    echo "  gbl         Git branch list"
    echo "  gbm         Git merge <branch>              # merge branch into current"
    echo "  gbr         Git rebase <branch>             # rebase branch into current"
    echo "  gc          Git commit"
    echo "  gce         Git clone"
    echo "  gcg         Git config --global <key> '<value>'"
    echo "  gcgce       Git config --global core.editor '<path>'"
    echo "  gcggp       Git config --global gc.pruneexpire '<num> days'"
    echo "  gcgl        Git config --global --list"
    echo "  gcgun       Git config --global user.name '<name>'"
    echo "  gcgue       Git config --global user.email '<email>'"
    echo "  gco         Git checkout <branch>"
    echo "  gcob        Git checkout -b <branch>        # add and checkout a branch"
    echo "  gcom        Git checkout master"
    echo "  gcz         Git cz"
    echo "  gds         Git diff --stat <commit> <commit>"
    echo "  gi          Git init"
    echo "  gga         Git gc --auto                   # automatically detect if gc required"
    echo "  ggc         Git gc                          # git garbage collection removes broken only"
    echo "  ggcp        Git gc --prune                  # git garbage collection removes older than 2 weeks"
    echo "  gl          Git log --graph"
    echo "  glh         Git log --pretty=format:'%h -an - %ar - %s'"
    echo "  glp         Git log --pretty=format:'<format>'"
    echo "  glo         Git log --oneline --decorator"
    echo "  gls         Git log --oneline --stat"
    echo "  gmv         Git mv"
    echo "  gp          Git push"
    echo "  gpo         Git push origin"
    echo "  gpom        Git push -u origin master"
    echo "  gs          Git status"
    echo "  gss         Git status --short"
    echo "  gsa         Git submodule add"
    echo "  gr          Git remote"
    echo "  grv         Git remote -v"
    echo "  gro         Git status add origin"
    echo "  gru         Git remote set-url origin"
    echo "  grm         Git rm --cached <file>          # remove file from index but keep locally"
    echo "  grh         Git revert HEAD                 # revert previous commit but keep history"
    echo "  grh1        Git revert HEAD~1               # revert two previous commits but keep history"
    echo "  gsh         Git show <tag>                  # show tag"
    echo "  gt          Git tag                         # display list of tags"
    echo "  gta         Git tag -a <tag>                # add annotated tag"
    echo "  gtd         Git tag -d <tag>                # delete tag"
    echo "  git-clone   Interactive Git clone"
    echo "  git-create  Interactive Git create remote repo"
    echo "  git-pr      Interactive Git clone PR"
    echo "  git-prtest  Interactive Git test PR locally"
    echo "  git-new     Interactive Git init"
    echo "  git-sync    Interactive Git synchronize"
}
help-ledger() {
    echo "  lb          ledger balance -f"
    echo "  lbas        ledger -M balance ^assets -f"
    echo "  lbbs        ledger -M balance ^assets ^liabilities -f"
    echo "  lbexcm      ledger bal expenses --period 'this month' -f"
    echo "  lbexlm      ledger bal expenses --period 'last month' -f"
    echo "  lbin        ledger -M balance ^income -f"
    echo "  lbpl        ledger -M balance ^income ^expenses -f"
    echo "  le          ledger equity -f"
    echo "  lrli        ledger -M register ^liabilities -f"
}
help-ssh() {
    echo "Ssh Aliases"
    echo "  bash_ip     Read file ipaddr.txt"
    echo "  bash_scp    Scp -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1"
    echo "  bash_ssh    Ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1"
    echo "  bash_sshaws Ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_aws01"
    echo "  scp-dn      Interactive Scp dir download"
    echo "  scp-up      Interactive Scp dir upload"
}
help-terraform() {
    echo "Terraform Aliases"
    echo "  tf          Terraform"
    echo "  tfa         Terraform apply"
    echo "  tfd         Terraform destroy"
    echo "  tfdoc       Terraform-docs"
    echo "  tfi         Terraform init"
    echo "  tfp         Terraform plan"
    echo "  tfs         Terraform show"
    echo "  tfsl        Terraform state list"
    echo "  tfsr        Terraform state rm"
    echo "  tfv         Terraform validate"
    echo "  tf-apply    Interactive Terraform apply"
    echo "  tf-destroy  Interactive Terraform destroy"
    echo "  tf-plan     Interactive Terraform plan"
    echo "  tf-import   Interactive Terraform import Ssh Key"
}
help-wp() {
    echo "Wp Aliases"
    echo "  wp          wp-cli"
    echo "  wpconf      wp config"
    echo "  wpd         wp db"
    echo "  wpi         wp help"
    echo "  wph         wp --info"
    echo "  wpp         wp plugin"
    echo "  wppi        wp plugin install"
    echo "  wppia       wp plugin install --activate"
    echo "  wppl        wp plugin list"
    echo "  wpps        wp plugin search"
    echo "  wppsa       wp plugin search --format=csv --fields=name,slug,version,requires,tested,rating,ratings,num_ratings,downloaded,active_installs,added,last_updated,short_description,tags,homepage"
    echo "  wppsd       wp plugin search --fields=name,short_description,author,tested,homepage"
    echo "  wppsr       wp plugin search --fields=name,rating,ratings,num_ratings,downloaded,last_updated,active_installs"
    echo "  wpp         wp plugin"
    echo "  wppu        wp plugin uninstall"
    echo "  wppud       wp plugin uninstall --deactivate"
    echo "  wpu         wp user"
}
