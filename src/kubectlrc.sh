#
# external aliases
# kc cm su
# -- -- --
# |  |  |
# |  |  |---> subcommand (at least 1 char)
# |  |------> command (at least 1 char)
# |---------> kubectl (kc)
alias ku='kubectl'
alias kua='kubectl apply -f services/hello-blue.yaml'
alias kuc='kubectl create -f services/auth.yaml'
alias kucd='kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0'
alias kucns='kubectl create ns'
alias kud='kubectl describe'
alias kudn='kubectl describe node'
alias kudp='kubectl describe pod'
alias kudel='kubectl delete'
alias kued='kubectl edit deployment'
alias kuep='kubectl edit pod'
alias kuex='kubectl exec'
alias kund='kubectl explain deployment'
alias kuxd='kubectl expose deployment hello-server --type=LoadBalancer --port 8080'
alias kugap='kubectl get authorizationpolicy'
alias kugd='kubectl get deployments'
alias kuggw='kubectl get gateway'
alias kugns='kubectl get namespaces'
alias kugn='kubectl get nodes'
alias kugp='kubectl get pods | grep hello- | wc -l'
alias kugpc='kubectl get pods -o jsonpath="{.spec.containers[*].name}*"'
alias kugr='kubectl get replicasets'
alias kugtls='kubectl get secret cloudflare-tls -n istio-system -o yaml > cloudflare_tls_$(date "+%Y_%m_%d").yaml'
alias kugs='kubectl get service'
alias kugvs='kubectl get virtualservice'
alias kulg='kubectl logs'
alias kurh='kubectl rollout history deployment/hello'
alias kurp='kubectl rollout pause deployment/hello'
alias kurr='kubectl rollout resume deployment/hello'
alias kurs='kubectl rollout status deployment/hello'
alias kuru='kubectl rollout undo deployment/hello'
alias kusd='kubectl scale deployment hello --replicas=3'

ku-tls-deploy() {
    cancel=true
    echo "ku-tls-deploy: Deploy new Origin tls.crt and tls.key into Istio"
    echo "Required:"
    echo "  key: tls.key"
    echo "  cert: tls.crt"
    confirm=$(inp-confirm)
    if [ ! -z "$confirm" ]; then
        if [ -f "tls.key" ]; then
            if [ -f "tls.crt" ]; then
                echo "Type the following commands:"
                echo '  kubectl delete secret cloudflare-tls -n istio-system'
                echo '  kubectl create secret tls cloudflare-tls -n istio-system --key tls.key --cert tls.crt'
            else
                echo "Error (ku-tls-deploy): File tls.crt not found"
            fi
        else
            echo "Error (ku-tls-deploy): File tls.key not found"
        fi
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

ku-tls-annotate() {
    cancel=true
    echo "ku-tls-annotate: Annotate secret cloudflare-tls"
    confirm=$(inp-confirm)
    if [ ! -z "$confirm" ]; then
        echo 'kubectl annotate secret cloudflare-tls -n istio-system reflector.v1.k8s.emberstack.com/reflection-allowed="false"'
        echo 'kubectl annotate secret cloudflare-tls -n istio-system reflector.v1.k8s.emberstack.com/reflection-auto-enabled="false"'
        kubectl annotate secret cloudflare-tls -n istio-system reflector.v1.k8s.emberstack.com/reflection-allowed="false"
        kubectl annotate secret cloudflare-tls -n istio-system reflector.v1.k8s.emberstack.com/reflection-auto-enabled="false"
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
