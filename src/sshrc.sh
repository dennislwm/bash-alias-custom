#
# internal aliases
alias bash_scpdir='scp -F c:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1 -r'
alias bash_ssh='ssh -F C:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1'
alias bash_scp='scp -F c:\\Users\\denbrige\\.ssh\\config -i C:\\Users\\denbrige\\.ssh\\id_rsa_do1'

#
# internal variables
str_file_ipaddr='/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/19dscode/config/ipaddr.txt'
str_file_localdir='/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/19dscode/config/localdir.txt'
str_file_remotedir='/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/19dscode/config/remotedir.txt'

#
# external functions
scp-dn() {
    cancel=true
    cat-file "$str_file_ipaddr"
    name1=$(inp-name)
    if [ ! -z "$name1" ]; then
        ipaddr=${!name1}
        echo "User" $ipaddr
        cat-file "$str_file_remotedir"
        name2=$(inp-name)
        if [ ! -z "$name2" ]; then
            remotedir=${!name2}
            echo "User" $remotedir
            localdir="d:\\docker"
            echo "bash_scpdir root@$ipaddr:$remotedir $localdir"
            bash_scpdir root@$ipaddr:$remotedir $localdir
            cancel=""
        fi
    fi
    if [ ! -z $cancel ]; then
        echo "user cancel"
    else
        echo "done"
    fi
}
scp-up() {
    cancel=true
    cat-file "$str_file_ipaddr"
    name=$(inp-name)
    ipaddr=${!name}
    echo "User" $ipaddr
    if [ ! -z "$ipaddr" ]; then
        cat-file "$str_file_localdir"
        name=$(inp-name)
        localdir=${!name}
        echo "User" $localdir
        if [ ! -z "$localdir" ]; then
            remotedir="/root/"
            echo "bash_scpdir $localdir root@$ipaddr:$remotedir"
            cd "d:\\docker"
            bash_scpdir $localdir root@$ipaddr:$remotedir
            cancel=""
        fi
    fi
    if [ ! -z $cancel ]; then
        echo "user cancel"
    else
        echo "done"
    fi
}
ssh-root() {
    cancel=true
    cat-file "$str_file_ipaddr"
    name=$(inp-name)
    ipaddr=${!name}
    echo "User" $ipaddr
    if [ ! -z "$ipaddr" ]; then
        bash_ssh "root@"$ipaddr
        cancel=""
    fi
    if [ ! -z $cancel ]; then
        echo "user cancel"
    else
        echo "done"
    fi
}

#
# inputs
cat-file()
{
    file=$1
    echo "Reading file" "$file"
    if [[ -f $file ]]; then
        source "$file"
        awk -v prefix=" " '{print prefix $0}' "$file"
    fi
}
inp-name() {
    read -p "Enter name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}