#
# external aliases
alias ga='git add'
alias gc='git commit'
alias gce='git clone'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gi='git init'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push -u origin master'
alias gs='git status'
alias gsa='git submodule add'
alias gr='git remote'
alias grv='git remote -v'
alias gro='git remote add origin'
# change repository name
alias gru='git remote set-url origin'

#
# external functions
git-clone() {
    cancel=true
    localgit=$(inp-localgit)
    if [ ! -z "$localgit" ]; then
        echo "Example: user/repo (without .git)"
        remotegit=$(inp-remotegit)
        if [ ! -z "$remotegit" ]; then
            echo "gce ssh://git@github.com/$remotegit.git $localgit"
            gce ssh://git@github.com/$remotegit.git $localgit
            cancel=false
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
#
# Example: curl -X POST -H 'Authorization: token d5aefe02f68f5c375e416293f35dd573546e6a57' -d '{"name":"chrome-ext-code"}' https://api.github.com/user/repos
git-create() {
    cancel=true
    echo "This script creates a remote Git repository for the current user"
    cat-file "$str_file_config"
    name=$(inp-name)
    if [ ! -z "$name" ]; then
        data=$( printf '{"name":"%s"}' "$name" )
        echo "curl -X POST -H 'Authorization: token $githubtoken' -d '$data' https://api.github.com/user/repos"
        eval "curl -X POST -H 'Authorization: token $githubtoken' -d '$data' https://api.github.com/user/repos"
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
git-new() {
    cancel=true
    localpath="/d/denbrige/180 FxOption/103 FxOptionVerBack/083 FX-Git-Pull/"
    remotepath="github.com:dennislwm"
    echo "Git Project details are as follows:"
    echo "  Local path: $localpath"
    echo "  Remote path: $remotepath"
    echo "WARNING: Create an EMPTY remote Git Project first before continuing!"
    echo "WARNING: git-new() adds and commits ALL existing files into repository!"
    echo "WARNING: Ensure .gitignore file exists!"
    echo "WARNING: Run this in $localpath"
    localgit=$(inp-localgit)
    if [ ! -z "$localgit" ]; then
        remotegit=$(inp-remotegit)
        if [ ! -z "$remotegit" ]; then
            cd "$localpath"
            if [ ! -d "$localgit" ]; then
                echo "mkdir $localgit"
                mkdir $localgit
            else
                echo "Existing project"
            fi
            echo "cd $localgit"
            cd $localgit
            if [ ! -d ".git" ]; then
                echo 'gi'
                gi
            else
                echo "Existing git"
            fi
            echo "ga ."
            ga .
            echo "gc"
            gc
            echo "gro git@$remotepath/$remotegit.git"
            gro git@$remotepath/$remotegit.git
            echo "gpom"
            gpom
            cancel=false
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
git-pr() {
    cancel=true
    localgit=$(inp-localgit)
    if [ ! -z "$localgit" ]; then
        echo "Example: user/repo (without .git)"
        remotegit=$(inp-remotegit)
        if [ ! -z "$remotegit" ]; then
            branch=$(inp-branch)
            if [ ! -z "$branch" ]; then
                echo "gce ssh://git@github.com/$remotegit.git $localgit"
                gce ssh://git@github.com/$remotegit.git $localgit
                echo "cd $localgit"
                cd $localgit
                echo "gco $branch"
                gco $branch
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
git-sync() {
    cancel=true
    isgit=$(assert-isgit)
    if [ -z "$isgit" ]; then
        upstream=$(assert-upstream)
        if [ -z "$upstream" ]; then
            echo "Example: user/repo (without .git)"
            remoteup=$(inp-remoteup)
            if [ ! -z "$remoteup" ]; then
                # git remote set-url upstream https://github.com/$remoteup.git
                git remote add upstream https://github.com/$remoteup.git
            fi
        fi
        echo "Sync local repository from upstream and push to GitHub"
        upstream=$(assert-upstream)
        if [ ! -z "$upstream" ]; then
            echo "grv"
            grv
            confirm=$(inp-confirm)
            if [ ! -z "$confirm" ]; then
                echo "Sync local repository from upstream"
                echo "  git fetch upstream"
                git fetch upstream
                echo "  gcom"
                gcom
                echo "Push local repository to GitHub"
                echo "  git merge upstream/master"
                git merge upstream/master
                echo "  gp"
                gp
                cancel=false
            fi
        fi
    else
        echo "ERROR: Ensure you are within a local forked repository folder"
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}

#
# inputs
inp-branch() {
    read -p "Enter branch name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
inp-localgit() {
    read -p "Enter new OR existing local project name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
#
# inputs
inp-remotegit() {
    read -p "Enter new OR existing remote project name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
inp-remoteup() {
    read -p "Enter upstream project name; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
assert-upstream() {
    # returns empty if upstream not set
    git remote -v | grep upstream
}
assert-isgit() {
    # returns empty if folder is a git repository
    git remote -v | grep fatal
}
inp-confirm() {
    read -p "Enter yes to confirm; OR BLANK to quit: " name
    if [ -z $name ]; then
        echo ""
    else
        echo $name
    fi
}
cat-config()
{
    file=$str_file_config
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