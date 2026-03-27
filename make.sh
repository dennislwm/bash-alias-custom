function check_varlock {
  command -v varlock > /dev/null 2>&1 || { echo "[WARN][check_varlock]: varlock not installed. Run 'make install-varlock'."; return 0; }
  echo "[OK]   varlock found ($(varlock --version 2>&1 | head -1))"
}

function check_op {
  command -v op > /dev/null 2>&1 || { echo "[WARN][check_op]: 1Password CLI not installed. Run 'make install-op'."; return 0; }
  echo "[OK]   op CLI found ($(op --version 2>&1 | head -1))"
  if pgrep -x "1Password" > /dev/null 2>&1; then
    echo "[OK]   1Password desktop app is running"
  else
    echo "[WARN][check_op]: 1Password desktop app is not running. varlock load requires it for allowAppAuth."
  fi
}

function check_profile {
  local profile="$HOME/.bash_profile" sentinel="varlock load --format shell"
  if [ -f "$profile" ] && grep -qF "$sentinel" "$profile" 2>/dev/null; then
    echo "[OK]   auto-load block present in ~/.bash_profile"
  else
    echo "[NONE][check_profile]: auto-load block missing from ~/.bash_profile. Run 'make setup'."
  fi
}

function check_link {
  local dest="$1"
  if [ -L "$dest" ]; then
    echo "[OK]   $dest symlink exists -> $(readlink "$dest")"
  elif [ -d "$dest" ]; then
    echo "[WARN][check_link]: Real directory (not symlink) exists at $dest"
  else
    echo "[NONE][check_link]: $dest not set up. Run 'make setup'."
  fi
}

function show_status {
  echo "=== Status ==="
  check_varlock
  check_op
  check_profile
  check_link "$HOME/src"
  check_link "$HOME/.env.schema"
  echo "=============="
}

function setup_profile {
  local profile="$HOME/.bash_profile" sentinel="varlock load --format shell"
  if [ -f "$profile" ] && grep -qF "$sentinel" "$profile" 2>/dev/null; then
    echo "[SKIP] auto-load block already in ~/.bash_profile"
    return 0
  fi
  cat >> "$profile" <<'EOF'

# Load varlock environment variables
if pgrep -x "1Password" > /dev/null; then
  eval "$(varlock load --format shell)"
else
  echo "[varlock] 1Password is not running — environment variables not loaded. Open 1Password and start a new terminal session." >&2
fi
EOF
  echo "[OK]   auto-load block appended to ~/.bash_profile"
}

function setup_commands {
  local base_dir src dest
  base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  setup_profile
  src="$base_dir/src"
  dest="$HOME/src"
  if [ -L "$dest" ]; then
    echo "[SKIP] Symlink already exists at $dest"
  elif [ -d "$dest" ]; then
    echo "[WARN][setup_commands]: Real directory already exists at $dest, skipping"
  else
    ln -s "$src" "$dest"
    echo "[OK]   Created symlink $dest -> $src"
  fi
  dest="$HOME/.env.schema"
  if [ -e "$dest" ]; then
    echo "[SKIP] $dest already exists, skipping"
  else
    cat > "$dest" <<'EOF'
# This env file uses @env-spec - see https://varlock.dev/env-spec for more info
#
# @defaultRequired=infer @defaultSensitive=true
# @generateTypes(lang=ts, path=env.d.ts)
# ----------
# @plugin(@varlock/1password-plugin@0.3.0)
# @initOp(allowAppAuth=true)

DB_PASS=op(op://Varlock/DB_PASS/password)
DB_USER=op(op://Varlock/DB_PASS/username)
EOF
    echo "[OK]   Generated $dest"
  fi
}
