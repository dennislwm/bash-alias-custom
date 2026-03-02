#!/bin/bash

# Define project directory once
readonly PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Tool definitions: tool:context:level
readonly TOOLS=(
  "git:Required for this project:ERROR"
  "curl:wprc.sh functions will not work"
  "jq:wprc.sh functions will not work"
)

readonly OPTIONAL_TOOLS=(
  "aws:awsrc.sh aliases will not work"
  "gcloud:gcloudrc.sh aliases will not work"
  "az:azrc.sh aliases will not work"
  "docker:dockerrc.sh aliases will not work"
  "kubectl:kubectlrc.sh aliases will not work"
  "terraform:terraformrc.sh aliases will not work"
  "ledger:ledgerrc.sh functions will not work"
  "lpass:lpassrc.sh aliases will not work"
  "watson:watsonrc.sh aliases will not work"
)

function check_tool() {
  local tool=$1 context=$2 level=${3:-WARN}
  command -v "$tool" >/dev/null 2>&1 || {
    echo "[$level] $tool not installed. $context"
    return $([ "$level" = "ERROR" ] && echo 1 || echo 0)
  }
  local version_output
  if [ "$tool" = "kubectl" ]; then
    version_output=$(kubectl version --client 2>&1 | head -1)
  else
    version_output=$($tool --version 2>&1 | head -1)
  fi
  echo "[OK] $tool found ($version_output)"
}

function check_git_completion {
  if [ ! -f ~/.git-completion.bash ]; then
    echo "[WARN] Git completion not found. Install with:"
    echo "       curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash"
  else
    echo "[OK] Git completion found"
  fi

  if [ ! -f ~/.git-prompt.sh ]; then
    echo "[WARN] Git prompt not found. Install with:"
    echo "       curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
  else
    echo "[OK] Git prompt found"
  fi
}

function check_symbolic_link {
  local dest="$HOME/src"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$PROJECT_DIR/src" ]; then
    echo "[OK] ~/src symlink correctly points to project"
  elif [ -L "$dest" ]; then
    echo "[WARN] ~/src symlink exists but points to $(readlink "$dest")"
  elif [ -d "$dest" ]; then
    echo "[WARN] ~/src is a real directory, not a symlink"
  else
    echo "[NONE] ~/src symlink not set up"
  fi
}

function check_bash_profile {
  local profile_file="$HOME/.bash_profile"
  local startup_line="source ~/src/startup.sh"

  if [ -f "$profile_file" ] && grep -q "$startup_line" "$profile_file"; then
    echo "[OK] startup.sh is sourced in ~/.bash_profile"
  elif [ -f "$profile_file" ]; then
    echo "[WARN] ~/.bash_profile exists but doesn't source startup.sh"
  else
    echo "[NONE] ~/.bash_profile not found"
  fi
}

function list_shell_scripts {
  echo "Available shell script modules:"
  for script in src/*rc.sh; do
    [ -f "$script" ] || continue
    local name=$(basename "$script" .sh)
    local tool=$(echo "$name" | sed 's/rc$//')
    printf "  %-15s - %s\n" "$name" "Aliases and functions for $tool"
  done
  echo "  startup.sh      - Main loader script"
}

function link_project {
  local dest="$HOME/src"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$PROJECT_DIR/src" ]; then
    echo "[SKIP] ~/src symlink already correctly configured"
    return 0
  fi

  if [ -e "$dest" ]; then
    echo "[WARN] ~/src already exists. Please remove it first: rm -rf ~/src"
    return 1
  fi

  ln -s "$PROJECT_DIR/src" "$dest"
  echo "[OK] Created symlink ~/src -> $PROJECT_DIR/src"
}

function setup_bash_profile {
  local profile_file="$HOME/.bash_profile"
  local startup_line="source ~/src/startup.sh"

  if [ -f "$profile_file" ] && grep -q "$startup_line" "$profile_file"; then
    echo "[SKIP] startup.sh already sourced in ~/.bash_profile"
    return 0
  fi

  echo -e "\n# Load bash-alias-custom\n$startup_line" >> "$profile_file"
  echo "[OK] Added startup.sh source to ~/.bash_profile"
}

function show_project_status {
  echo "=== Status Check ==="

  # Check required tools
  for tool_def in "${TOOLS[@]}"; do
    IFS=: read -r tool context level <<< "$tool_def"
    check_tool "$tool" "$context" "$level"
  done

  echo -e "\n=== Optional Tools ==="
  for tool_def in "${OPTIONAL_TOOLS[@]}"; do
    IFS=: read -r tool context <<< "$tool_def"
    check_tool "$tool" "$context"
  done

  echo -e "\n=== Project Setup ==="
  check_symbolic_link
  check_bash_profile
  check_git_completion
}

function setup_project {
  echo "=== Setup ==="
  echo "Project: $PROJECT_DIR"

  # Check required tools
  for tool_def in "${TOOLS[@]}"; do
    IFS=: read -r tool context level <<< "$tool_def"
    check_tool "$tool" "$context" "$level" || { echo "Setup failed: $tool is required"; return 1; }
  done

  link_project || return 1
  setup_bash_profile || return 1

  echo -e "\n=== Complete ===\nRestart terminal or run: source ~/.bash_profile"
}

function run_tests {
  echo "=== Running Tests ==="

  if ! command -v bats >/dev/null 2>&1; then
    echo "[ERROR] bats not installed. Install with:"
    echo "        brew install bats-core  # macOS"
    echo "        apt install bats        # Ubuntu/Debian"
    return 1
  fi

  if [ ! -d "tests" ]; then
    echo "[ERROR] tests directory not found"
    return 1
  fi

  echo "Running bats tests..."
  bats tests/
}