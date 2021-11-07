alias sfte="sft enroll --team block-one"
alias sftl="sft login"

vault-login() {
    cancel=true
    echo "vault-login: Login to vault"
    echo "Input:"
    echo "  dev - {branch, custody, dev, qa, staging, uat}"
    echo "  prod - {internal, next, prod}"
    echo "  perf"
    echo "  scratch"
    echo "  sec"
    echo -n "First param ENV - "
    TLS_ENV=$(inp-name)
    if [ ! -z "$TLS_ENV" ]; then
        cancel=false
        echo "Type the following commands:"
        echo "  export VAULT_ADDR='https://vault-1-d-sin-g-admin-b1fs-$TLS_ENV.node.d-sin-g-admin-b1fs-$TLS_ENV.int.b1fs.net:8200'"
        echo "  vault login -method=oidc"
        echo "Check (increase) the TTL by tuning the secrets engine:"
        echo "  vault read sys/mounts/pki/tune"
        echo "  vault secrets tune -default-lease-ttl=8760h pki/"
        echo ""
        echo "Alternatively, SSH to remote server:"
        echo "  sft login"
        echo "  sft ssh vault-1-d-sin-g-admin-b1fs-$TLS_ENV"
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

vault-write() {
    cancel=true
    echo "vault-write: Generate a new TLS certificate with your common_name"
    echo "Input:"
    echo "  TLS_NAME - short TLS name as a prefix to file names, e.g. rabbitmq"
    echo "  COMMON_NAME - domain, e.g. rabbitmq-blockchain-atoms-b1fs-staging.service.c-sin-g-atoms-b1fs-dev.int.b1fs.net"
    echo -n "First param TLS_NAME - "
    TLS_NAME=$(inp-name)
    if [ ! -z "$TLS_NAME" ]; then
        echo -n "Second param COMMON_NAME - "
        COMMON_NAME=$(inp-name)
        if [ ! -z "$COMMON_NAME" ]; then
            echo "  COMMON_NAME=$COMMON_NAME"
            echo "Output:"
            echo "  $TLS_NAME-full-certificates.txt"
            echo "  $TLS_NAME-ca-chain.cer"
            echo "  $TLS_NAME-certificate.cer"
            echo "  $TLS_NAME-private-key.cer"
            confirm=$(inp-confirm)
            if [ ! -z "$confirm" ]; then
                echo "vault write pki/issue/auto-service common_name=$COMMON_NAME ttl=8760h > ${TLS_NAME}-full-certificates.txt"
                vault write pki/issue/auto-service common_name="$COMMON_NAME" ttl=8760h > ${TLS_NAME}-full-certificates.txt
                if [ -f "${TLS_NAME}-full-certificates.txt" ]; then
                    cat ${TLS_NAME}-full-certificates.txt | awk ' /ca_chain/ {p = 1; n++; file = "temp-ca-chain.cer"} p { print > file } /----]/ {p = 0} '
                    cat ${TLS_NAME}-full-certificates.txt | awk ' /certificate/ {p = 1; n++; file = "temp-certificate.cer"} p { print > file } /END CERTIFICATE/ {p = 0} '
                    cat ${TLS_NAME}-full-certificates.txt | awk ' /private_key/ {p = 1; n++; file = "temp-private-key.cer"} p { print > file } /END RSA PRIVATE KEY/ {p = 0} '
                    mv temp-ca-chain.cer ${TLS_NAME}-ca-chain.cer
                    mv temp-certificate.cer ${TLS_NAME}-certificate.cer
                    mv temp-private-key.cer ${TLS_NAME}-private-key.cer
                    echo "IMPORTANT: You must edit all the *.cer files." 
                    echo "  Remove any extra characters before -----BEGIN----- and after -----END-----."
                    echo "  For *-ca-chain.cer you must ensure -----BEGIN----- and -----END----- are on separate lines."
                    echo ""
                    echo "Check that the expiration date (Unix epoch time) is correct."
                    cat ${TLS_NAME}-full-certificates.txt | grep expiration
                    echo "  https://www.epochconverter.com"
                else
                    echo "Error (vault-write): Could not write to ${TLS_NAME}-full-certificates.txt"
                fi
                cancel=false
            fi
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
