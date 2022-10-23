#
# inputs
inp-confirm() {
    read -p "Enter y to confirm; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
inp-name() {
    read -p "Enter $1 name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
inp-number() {
    read -p "Enter number; OR BLANK to quit: " number
    if [ -z $number ]; then
        echo ""
    else
        echo $number
    fi
}
inp-str() {
    read -p "Enter $1; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
