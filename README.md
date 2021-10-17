# bash-alias-custom

# Setup

## Install Git Bash autocompletion

Run the following command:

```sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
```

This should create the `.git-completion.bash` file in your home dir.

In the `startup.sh` file, add the following code:

```sh
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM="auto"
    PS1="\[\033[36m\]\u@\[\033[35m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[32m\]$(__git_ps1 ' (%s)')\[\033[m\]\$ "
else
    PS1="\[\033[36m\]\u@\[\033[35m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
fi
```

For example:
```sh
dennislwm@dbmacm3:~/fx-git-pull/02bash-alias-custom (master *=)$
```

## Git status
This will display the branch name next to the folder name in the bash prompt.

Symbols after the branch name indicate additional information about the repo state:

* `*` The branch has modifications
* `$` There are stashed changes
* `=` The branch is equal with the remote branch
* `<` The branch is behind the remote branch (can be fast-forwarded)
* `>` The branch is ahead of the remote branch (remote branch can be fast-forwarded)
* `<>` The branch and remote branch have diverged (will need merge)

# Troubleshooting

## Error bash: __git_ps1: command not found

If you are seeing this error, this is because the `__git_ps1` function from the completion functionality was moved into a new file `git-prompt.sh`.

You can either source the `git-prompt.sh` that comes with your installed version of Git, if it has it, or you can download and install a new one.

```sh
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
```