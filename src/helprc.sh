#
# external aliases
alias h='help'
alias ha='help-all'
alias hab='help-archivebox'
alias hb='help-bash'
alias hd='help-docker'
alias hku='help-kubectl'
alias hl='help-ledger'
alias hlp='help-lpass'
alias hg='help-git'
alias hs='help-ssh'
alias ht='help-terraform'
alias hw='help-wp'

#
# external functions
help() {
    echo "Help Aliases $RC_VERSION"
    echo "  ha          Help ALL"
    echo "  hab         Help archivebox"
    echo "  hb          Help bash"
    echo "  hd          Help docker"
    echo "  hg          Help git"
    echo "  hku         Help kubectl"
    echo "  hl          Help ledger"
    echo "  hlp         Help lpass"
    echo "  hs          Help ssh"
    echo "  ht          Help terraform"
    echo "  hw          Help wp"
}
help-all() {
    help-bash
    help-docker
    help-git
    help-ledger
    help-lpass
    help-ssh
    help-terraform
    help-wp
}
help-archivebox() {
    echo "ArchiveBox Aliases"
    echo "  ab          Archivebox"
    echo "  aba         Archivebox add"
    echo "  abcs        Archivebox config --set"
    echo "  ab-import   Archivebox import document from Couchdb RESTful API"
    echo "  abmyconf    Archivebox set my config"
    echo "  abmymthd    Archivebox set my method"
    echo "  abr         Archivebox remove"
    echo "  abs         Archivebox server"
    echo "  auu         Archivebox update --status unarchived"
    echo "  abv         Archivebox version"
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
    echo "  gbp         Git push -u origin <branch>     # push branch into remote and track new remote branch"
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
    echo "  gfu         Git fetch upstream              # fetch changes from upstream"
    echo "  gga         Git gc --auto                   # automatically detect if gc required"
    echo "  ggc         Git gc                          # git garbage collection removes broken only"
    echo "  ggcp        Git gc --prune                  # git garbage collection removes older than 2 weeks"
    echo "  gl          Git log --graph"
    echo "  glh         Git log --pretty=format:'%h -an - %ar - %s'"
    echo "  glp         Git log --pretty=format:'<format>'"
    echo "  glo         Git log --oneline --decorator"
    echo "  gls         Git log --oneline --stat"
    echo "  gmum        Git merge upstream/main         # Merge changes from upstream main branch into your local main"
    echo "  gmv         Git mv"
    echo "  gp          Git push"
    echo "  gpo         Git push origin"
    echo "  gpom        Git push -u origin master       # push files to remote and track as master branch"
    echo "  gs          Git status"
    echo "  gss         Git status --short"
    echo "  gsa         Git submodule add"
    echo "  gr          Git remote"
    echo "  grao        Git remote add origin https://<url>.git     # <url> of forked repo (your copy)"
    echo "  grau        Git remote add upstream https://<url>.git   # <url> of non-forked repo (original)"
    echo "  grv         Git remote -v"
    echo "  gro         Git status add origin"
    echo "  gru         Git remote set-url origin"
    echo "  grm         Git rm --cached <file>          # remove file from index but keep locally"
    echo "  grh         Git revert HEAD                 # revert previous commit but keep history"
    echo "  grh1        Git revert HEAD~1               # revert two previous commits but keep history"
    echo "  gsh         Git show <tag>                  # show tag"
    echo "  gsq         Git rebase -i HEAD~             # interactive squash commits"
    echo "  gt          Git tag                         # display list of tags"
    echo "  gta         Git tag -a <tag>                # add annotated tag"
    echo "  gtd         Git tag -d <tag>                # delete tag"
    echo "  gtp         Git push origin <tag>           # push tag to remote"
    echo "  git-clone   Interactive Git clone"
    echo "  git-create  Interactive Git create remote repo"
    echo "  git-createnew Interactive Git create remote repo, init and push locally"
    echo "  git-pr      Interactive Git clone PR"
    echo "  git-prtest  Interactive Git test PR locally"
    echo "  git-pull    Interactive Git pull"
    echo "  git-new     Interactive Git init"
    echo "  git-squash  Interactive Git squash"
    echo "  git-sync    Interactive Git synchronize" 
    echo "  git-tag     Interactive Git tag"
}
help-kubectl() {
    echo "  ku              Kubectl"
    echo "  kua             Kubectl apply -f services/hello-blue.yaml"
    echo "  kuc             Kubectl create -f services/auth.yaml"
    echo "  kucd            Kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0"
    echo "  kucns           Kubectl create ns"
    echo "  kud             Kubectl describe"
    echo "  kudn            Kubectl describe node"
    echo "  kudp            Kubectl describe pod"
    echo "  kudel           Kubectl delete"
    echo "  kued            Kubectl edit deployment"
    echo "  kuep            Kubectl edit pod"
    echo "  kuex            Kubectl exec"
    echo "  kund            Kubectl explain deployment"
    echo "  kuxd            Kubectl expose deployment hello-server --type=LoadBalancer --port 8080"
    echo "  kugap           Kubectl get authorizationpolicy"
    echo "  kugd            Kubectl get deployments"
    echo "  kuggw           Kubectl get gateway"
    echo "  kugns           Kubectl get namespaces"
    echo "  kugn            Kubectl get nodes"
    echo "  kugp            Kubectl get pods | grep hello- | wc -l"
    echo "  kugpc           Kubectl get pods -o jsonpath='{.spec.containers[*].name}*'"
    echo "  kugr            Kubectl get replicasets"
    echo "  kugs            Kubectl get service"
    echo "  kugtls          Kubectl get secret cloudflare-tls -n istio-system -o yaml > cloudflare_tls_$(date '+%Y_%m_%d').yaml"
    echo "  kugvs           Kubectl get virtualservice"
    echo "  kulg            Kubectl logs"
    echo "  kurh            Kubectl rollout history deployment/hello"
    echo "  kurp            Kubectl rollout pause deployment/hello"
    echo "  kurr            Kubectl rollout resume deployment/hello"
    echo "  kurs            Kubectl rollout status deployment/hello"
    echo "  kuru            Kubectl rollout undo deployment/hello"
    echo "  kusd            Kubectl scale deployment hello --replicas=3"
    echo "  ku-tls-deploy   Interactive Kubectl deploy new origin tls.crt and tls.key into Istio"
    echo "  ku-tls-annotate Interactive Annotate secret cloudflare-tls"
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
help-lpass() {
    echo "  lp          lpass"
    echo "  lpc         Edit ~/.lpass/env"
    echo "  lph         lpass --help"
    echo "  lpls        lpass ls"
    echo "  lpshn       lpass show --notes"
    echo "  lpsy        lpass sync"
    echo "  lp-login    Interactive lpass login"
    echo "  lp_note_add Interactive lpass edit --notes"
}
help-ssh() {
    echo "Ssh Aliases"
    echo "  bash_ip     Read file ipaddr.txt"
    echo "  bash_scp    Scp -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1"
    echo "  bash_ssh    Ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1"
    echo "  bash_sshaws Ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_aws01"
    echo "  bash_tgz    Tar czvf"
    echo "  bash_ugz    Tar xzvf"
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
