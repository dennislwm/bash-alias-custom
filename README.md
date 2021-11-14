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

# Shell script `wprc.sh` for WordPress

<details>
	<summary>Click here to view <strong>Shell script wprc.sh for WordPress</strong>.</summary><br>

## Function `wp-upload`

### Understand function `wp-upload`

This function loops through all files found within a given path, and executes the `curl` command for each file.

```
wp-upload: Minimizes and uploads image(s) to WordPress
Usage: [WP_DEBUG=false] wp-upload [WP_PATH]
Input:
  [WP_PATH]: /path/to (default: /Users/dennislwm/fx-git-pull/01transfiguration.sg/minify)
```

The function accepts one parameter, which is the given path the the image files, e.g. `/path/to`. We should assert that at least one valid file in the path before running the loop.

The onus is on the user to ensure that all files in the given path are image files, e.g. `jpeg` or `png`, that are supported by the HTTP `application/type`. For example `image/jpeg` is supported, but not `jpg`.

Some common image types are:
* `image/apng`
* `image/avif`
* `image/gif`
* `image/jpeg`
* `image/png`
* `image/svg+xml`
* `image/webp`

The Shell method extracts and sets the `image/TYPE` from the extension of each file, e.g. `filename.jpeg`. If the image type is invalid, then the `curl` command will fail. Hence, the user has to ensure that the extension of each file corresponds to a valid image type, e.g. `filename.svg+xml`.

### Execute command `wp-upload`

The environment variables `WP_USERNAME` and `WP_PASSWORD` are required for WordPress authentication. You can save these variables in a separate file, one variable per line, such as `env.sh` and load the variables with `source env.sh` before running the function.

Alternatively, you can set these variables at each command as follows:

`$ WP_USERNAME=USERNAME WP_PASSWORD=PASSWORD wp-upload`

The function prompts for a user confirmation before executing the `curl` command.

```
  WP_PATH=/Users/dennislwm/fx-git-pull/01transfiguration.sg/minify
Upload 2 image(s) to WordPress? 
Enter yes to confirm; OR BLANK to quit: yes
```

The only accepted value is `yes`, as all other values will terminate the function. For each file upload that succeeds, the media `id` is returned, e.g. `5873` and `5874`.

```
Uploading BlessingsInHarmony.jpeg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  275k    0  4243  100  271k   1731   110k  0:00:02  0:00:02 --:--:--  112k
5873
Uploading Order_Xmas T-Shirt.png
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  760k    0  4213  100  756k    974   175k  0:00:04  0:00:04 --:--:--  176k
5874
done
```

### Debug function `wp-upload`

The function has a debug mode `WP_DEBUG=true` that prints the `curl` command for each file without executing it. 

<details>
	<summary>Click here to <strong>debug function wp-upload</strong>.</summary><br>

`$ WP_DEBUG=true wp-upload`

The result is as follows:

```
Uploading BlessingsInHarmony.jpeg
curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "@/Users/dennislwm/fx-git-pull/01transfiguration.sg/minify/BlessingsInHarmony.jpeg" -H "content-disposition: attachment; filename=BlessingsInHarmony.jpeg" -H "authorization: Basic ZGVubmlzbHdtOmx2Y2cgRUFYTSBib29GIDlNTU4gSEROZiBzU3RO" -H "cache-control: no-cache" -H "content-type: image/jpeg" --location
Uploading Order_Xmas T-Shirt.png
curl -X POST --url https://transfiguration.sg/wp-json/wp/v2/media --data-binary "@/Users/dennislwm/fx-git-pull/01transfiguration.sg/minify/Order_Xmas T-Shirt.png" -H "content-disposition: attachment; filename=Order_Xmas T-Shirt.png" -H "authorization: Basic ZGVubmlzbHdtOmx2Y2cgRUFYTSBib29GIDlNTU4gSEROZiBzU3RO" -H "cache-control: no-cache" -H "content-type: image/png" --location
done
```

</details>

# Troubleshooting

## Error bash: __git_ps1: command not found

If you are seeing this error, this is because the `__git_ps1` function from the completion functionality was moved into a new file `git-prompt.sh`.

You can either source the `git-prompt.sh` that comes with your installed version of Git, if it has it, or you can download and install a new one.

```sh
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
```