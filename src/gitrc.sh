#
# external aliases
alias ga='git add'
alias gba='git checkout -b'
alias gbc='git checkout'
alias gbd='git branch -d'
alias gbl='git branch --list'
alias gbm='git merge'
alias gbp='git push -u origin'
alias gbr='git rebase'
alias gc='git commit'
alias gce='git clone'
alias gcg='git config --global'
alias gcgce='git config --global core.editor'
alias gcgct='git config --global commit.template'
alias gcggp='git config --global gc.pruneexpire'
alias gcgl='git config --global --list'
alias gcgun='git config --global user.name'
alias gcgue='git config --global user.email'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout $(cat-default)'
alias gcz='git cz'
alias gds='git diff --stat'
alias gi='git init'
alias gfu='git fetch upstream'
alias gga='git gc --auto'
alias ggc='git gc'
alias ggcp='git gc --prune'
alias gl='git log --graph'
alias glh='git log --pretty=format:"%h -an - %ar - %s"'
alias glp='git log --pretty=format:'
alias glo='git log --oneline --decorate'
alias gls='git log --oneline --stat'
alias gmum='git merge upstream/$(cat-default)'
alias gmv='git mv'
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push -u origin $(cat-default)'
alias gs='git status'
alias gss='git status --short'
alias gsa='git submodule add'
alias gr='git remote'
alias grao='git remote add origin'
alias grau='git remote add upstream'
alias grv='git remote -v'
alias grm='git rm --cached'
# change repository name
alias gru='git remote set-url origin'
alias grh='git revert HEAD'
alias grh1='git revert HEAD~1'
alias gsh='git show'
alias gsq='git rebase -i HEAD~'
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtp='git push origin'

#
# external functions
git-bd() {
  gcom
  err=$?
  if [ $err -ne 0 ]; then
    return $err
  fi

  branchgit=$(git branch | grep --invert-match '\*' | cut -c 3- | fzf --preview="git log {} --")

  if [ -n "$branchgit" ]; then
    echo "Delete branch $branchgit?"
    confirm=$(inp-confirm)
  fi
  if [ ! -z "$confirm" ]; then
    echo "gbd $branchgit"
    gbd "$branchgit"
    echo "done"
  else
    echo "user cancel"
  fi
}

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
# Example: curl -X GET https://api.github.com/search/repositories?q=user:dennislwm+is:open+sort:updated-desc | grep -E 'svn_url|open_issues_count'
git-create() {
    cancel=true
    echo "This script creates a remote Git repository for the current user"
    cat-file "$str_file_config"
    name=$(inp-name)
    if [ ! -z "$name" ]; then
        data=$( printf '{"name":"%s"}' "$name" )
        token=$( printf '"Authorization: token %s"' "$githubtoken" )
        echo curl -X POST -d \'"$data"\' https://api.github.com/user/repos -H "$token"
        eval curl -X POST -d \'"$data"\' https://api.github.com/user/repos -H "$token"
        cancel=false
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
git-createnew() {
    cancel=true
    localpath="$str_path/"
    remotepath="github.com:dennislwm"
    echo "This script creates a remote Git repo and adds a non-Git project folder into the master branch."
    echo "  Local path: $localpath"
    echo "  Remote path: $remotepath"
    echo "WARNING: Use this command within a project folder that is non-Git and contains at least ONE (1) file."
    echo "WARNING: Use git-create if the project folder does not exist."
    cat-file "$str_file_config"
    echo ""
    pwd
    echo "Enter the current non-Git project folder name."
    name=$(inp-name)
    if [ ! -z "$name" ]; then
        #---------------------------------
        # Curl to create empty remote repo
        data=$( printf '{"name":"%s"}' "$name" )
        token=$( printf '"Authorization: token %s"' "$githubtoken" )
        echo curl -X POST -d \'"$data"\' https://api.github.com/user/repos -H "$token"
        eval curl -X POST -d \'"$data"\' https://api.github.com/user/repos -H "$token"
        #------------------------
        # Check not a Git project
        if [ ! -d ".git" ]; then
            echo 'gi'
            gi
        else
            echo "Existing git"
        fi
        echo "ga ."
        ga .
        echo "gc"
        gc -m "Initial commit"
        echo "gro git@$remotepath/$name.git"
        grao git@$remotepath/$name.git
        echo "gpom"
        gpom
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
    localpath="$str_path/"
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
    echo "Git create a pull request from a forked repo"
    echo "  Local repo should be a new folder"
    echo "  Remote repo should be your forked repo"
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
                echo "gcob $branch"
                gcob $branch
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
git-prtest() {
    cancel=true
    echo "Test a Git PR locally before merging"
    echo "  number: Git PR ID"
    echo "  branch: New branch name to test PR locally"
    echo "WARNING: Ensure local repository in sync, i.e. git pull, before continuing!"
    id=$(inp-number)
    if [ ! -z "$id" ]; then
        branch=$(inp-branch)
        if [ ! -z "$branch" ]; then
            echo "git fetch origin pull/$id/head:$branch"
            git fetch origin pull/$id/head:$branch
            echo "gco $branch"
            gco $branch
            echo "Once satisfied add and commit any changes you want to the branch."
            echo "  $ ga ."
            echo "  $ gc"
            echo "Next return to master and merge your branch with the master."
            echo "  $ gcom"
            echo "  $ git merge $branch"
            echo "  $ gp"
            cancel=false
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
git-pull() {
    cancel=true
    gbl
    branchgit=$(inp-name)
    if [ ! -z "$branchgit" ]; then
        default=$(cat-default)
        gco $default
        outgit=$(cat-already)
        if [ -z "$outgit" ]; then
            confirm="yes"
        else
            gbl
            echo "Merge $default into $branchgit?"
            confirm=$(inp-confirm)
        fi
        if [ ! -z "$confirm" ]; then
            echo "gbc $branchgit"
            gbc $branchgit
            echo "git merge $(cat-default)"
            git merge $(cat-default)
            cancel=false
        else
            echo "Already up to date."
        fi
    fi
    if $cancel; then
        echo "user cancel"
    else
        echo "done"
    fi
}
git-squash() {
    cancel=true
    glo | head -n 10
    echo "Note: Your local branch should be updated with master"
    echo "  $ git-pull"
    echo "Git squash commits on your local branch"
    echo "  Enter commit name BEFORE your first Pick commit"
    echo "  Your first Pick commit cannot be squashed"
    commitgit=$(inp-name)
    if [ ! -z "$commitgit" ]; then
        echo "git rebase -i $commitgit"
        git rebase -i $commitgit
        echo "Once completed push changes to your remote branch."
        echo "  $ git push -f origin BRANCH"
        cancel=false
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
                git merge upstream/$(cat-default)
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
cat-already()
{
    out=( $( git pull | grep -e 'Already up to date.') )
    if [ "$out" = "Already" ]; then
        echo $out
    else
        echo ""
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
cat-default()
{
    gbl | grep -e "bullish" -e "develop" -e "main" -e "master" | sed 's/ //g' | sed 's/*//g'
}
function select_release_type(){
	echo "Select release type : "
	echo "[ 1 ] major"
	echo "[ 2 ] minor"
	echo "[ 3 ] patch"

	read -p "> " INPUT_RELEASE_TYPE

	if [ "$INPUT_RELEASE_TYPE" = 1  ];then 
		RELEASE_TYPE="major"
	elif [ "$INPUT_RELEASE_TYPE" = 2  ];then 
		RELEASE_TYPE="minor"
	elif [ "$INPUT_RELEASE_TYPE" = 3  ];then 
		RELEASE_TYPE="patch"
	else 
		select_release_type
	fi 
}
function git-tag() {
    echo """
    ---------------------------
        Create tag
    ---------------------------
    """
    CYAN='\033[0;36m'
    RED='\033[0;31m'
    NC='\033[0m' 

    RELEASE_TYPE=$1 

    # Get last version, scan tags across all known branches
    LAST_VERSION=`git describe --abbrev=0 --tags $(git rev-list --tags --max-count=1) 2>/dev/null`
    if [ ! "$LAST_VERSION" = "" ]; then 
        echo "Latest tag released : $LAST_VERSION"
        echo ""
    fi 
    LAST_VERSION=${LAST_VERSION:-'0.0.0'}

    if [ -z "$RELEASE_TYPE" ];then 
        select_release_type
    fi 
    printf "Release type : ${CYAN}$RELEASE_TYPE${NC}\n"

    #Get current hash and see if it already has a tag
    GIT_COMMIT=`git rev-parse HEAD`
    DESCRIBE_CURRENT_COMMIT=`git describe --contains $GIT_COMMIT 2>/dev/null`

    if [ -z "$DESCRIBE_CURRENT_COMMIT" ];then 

        # Extract major.minor.patch version numbers 
        MAJOR="${LAST_VERSION%%.*}"; LAST_VERSION="${LAST_VERSION#*.}"
        MINOR="${LAST_VERSION%%.*}"; LAST_VERSION="${LAST_VERSION#*.}"
        PATCH="${LAST_VERSION%%.*}"; LAST_VERSION="${LAST_VERSION#*.}"

        # Increase version 
        if [ $RELEASE_TYPE = "major" ];then 
            MAJOR=$((MAJOR+1))
            MINOR=0
            PATCH=0
        elif [ $RELEASE_TYPE = "minor" ];then 
            MINOR=$((MINOR+1))
            PATCH=0
        elif [ $RELEASE_TYPE = "patch" ];then 
            PATCH=$((PATCH+1))
        fi 

        NEW_TAG="$MAJOR.$MINOR.$PATCH"

        # Validation 

        printf "Create and push tag with version : ${CYAN}$NEW_TAG${NC}\n"
        read -p "Do you want to continue ? [Y/n] " INPUT_VALIDATION
        if [ -z $INPUT_VALIDATION ] || [ $INPUT_VALIDATION = "y" ] || [ $INPUT_VALIDATION = "Y" ]; then

            # Create tag 
            echo "Create tag $NEW_TAG ..."
            #git tag $NEW_TAG

            # Push 
            echo "Push tag $NEW_TAG ..."
            #git push --tags

            printf "Tag ${CYAN}$NEW_TAG${NC} released "
        else 
            echo "Canceled"
        fi 
    else 
        printf "${RED}Canceled${NC}\n"
        echo "A tag already exists on this commit"
        echo "Associated tag version : $DESCRIBE_CURRENT_COMMIT"
    fi 

    echo """
    ---------------------------
    """
}
