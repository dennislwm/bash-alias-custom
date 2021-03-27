#
# external aliases
# kc cm su
# -- -- --
# |  |  |
# |  |  |---> subcommand (at least 1 char)
# |  |------> command (at least 1 char)
# |---------> kubectl (kc)
alias kca='kubectl apply -f services/hello-blue.yaml'
alias kcc='kubectl create -f services/auth.yaml'
alias kccd='kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0'
alias kced='kubectl edit deployment hello'
alias kcnd='kubectl explain deployment'
alias kcxd='kubectl expose deployment hello-server --type=LoadBalancer --port 8080'
alias kcgd='kubectl get deployments'
alias kcgp='kubectl get pods | grep hello- | wc -l'
alias kcgr='kubectl get replicasets'
alias kcgs='kubectl get service'
alias kcrh='kubectl rollout history deployment/hello'
alias kcrp='kubectl rollout pause deployment/hello'
alias kcrr='kubectl rollout resume deployment/hello'
alias kcrs='kubectl rollout status deployment/hello'
alias kcru='kubectl rollout undo deployment/hello'
alias kcsd='kubectl scale deployment hello --replicas=3'