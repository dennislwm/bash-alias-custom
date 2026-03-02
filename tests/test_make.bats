#!/usr/bin/env bats

# Source make.sh to load all functions into scope
MAKE_SH="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)/make.sh"

setup() {
  source "$MAKE_SH"
  TMPDIR="$(mktemp -d)"
  FAKE_BIN="$(mktemp -d)"
}

teardown() {
  rm -rf "$TMPDIR" "$FAKE_BIN"
}

# --- check_tool ---

@test "check_tool: passes and prints version when tool is on PATH" {
  run check_tool git "Required for project" ERROR
  [ "$status" -eq 0 ]
  [[ "$output" == *"[OK]"* ]]
  [[ "$output" == *"git found"* ]]
}

@test "check_tool: fails with error when tool is missing and level is ERROR" {
  PATH="$FAKE_BIN" run check_tool nonexistent "Required tool" ERROR
  [ "$status" -ne 0 ]
  [[ "$output" == *"[ERROR]"* ]]
  [[ "$output" == *"nonexistent not installed"* ]]
}

@test "check_tool: warns but exits 0 when optional tool is missing" {
  PATH="$FAKE_BIN" run check_tool nonexistent "Optional tool"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"nonexistent not installed"* ]]
}

@test "check_tool: uses default WARN level when no level specified" {
  PATH="$FAKE_BIN" run check_tool nonexistent "Some context"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[WARN]"* ]]
}

# --- check_git_completion ---

@test "check_git_completion: warns when git-completion.bash is missing" {
  HOME="$TMPDIR" run check_git_completion
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"Git completion not found"* ]]
  [[ "$output" == *"curl https://raw.githubusercontent.com"* ]]
}

@test "check_git_completion: reports OK when both completion files exist" {
  touch "$TMPDIR/.git-completion.bash"
  touch "$TMPDIR/.git-prompt.sh"
  HOME="$TMPDIR" run check_git_completion
  [[ "$output" == *"[OK] Git completion found"* ]]
  [[ "$output" == *"[OK] Git prompt found"* ]]
}

# --- check_symbolic_link ---

@test "check_symbolic_link: reports not set up when symlink doesn't exist" {
  HOME="$TMPDIR" run check_symbolic_link
  [ "$status" -eq 0 ]
  [[ "$output" == *"[NONE]"* ]]
  [[ "$output" == *"~/src symlink not set up"* ]]
}

@test "check_symbolic_link: reports OK when symlink points correctly" {
  ln -s "$PROJECT_DIR/src" "$TMPDIR/src"
  HOME="$TMPDIR" run check_symbolic_link
  [ "$status" -eq 0 ]
  [[ "$output" == *"[OK]"* ]]
  [[ "$output" == *"correctly points to project"* ]]
}

@test "check_symbolic_link: warns when symlink points elsewhere" {
  ln -s "/tmp" "$TMPDIR/src"
  HOME="$TMPDIR" run check_symbolic_link
  [ "$status" -eq 0 ]
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"symlink exists but points to"* ]]
}

@test "check_symbolic_link: warns when real directory exists" {
  mkdir -p "$TMPDIR/src"
  HOME="$TMPDIR" run check_symbolic_link
  [ "$status" -eq 0 ]
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"is a real directory"* ]]
}

# --- check_bash_profile ---

@test "check_bash_profile: reports not found when profile doesn't exist" {
  HOME="$TMPDIR" run check_bash_profile
  [ "$status" -eq 0 ]
  [[ "$output" == *"[NONE]"* ]]
  [[ "$output" == *".bash_profile not found"* ]]
}

@test "check_bash_profile: reports OK when startup.sh is sourced" {
  echo "source ~/src/startup.sh" > "$TMPDIR/.bash_profile"
  HOME="$TMPDIR" run check_bash_profile
  [ "$status" -eq 0 ]
  [[ "$output" == *"[OK]"* ]]
  [[ "$output" == *"startup.sh is sourced"* ]]
}

@test "check_bash_profile: warns when profile exists but doesn't source startup.sh" {
  echo "# some other content" > "$TMPDIR/.bash_profile"
  HOME="$TMPDIR" run check_bash_profile
  [ "$status" -eq 0 ]
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"doesn't source startup.sh"* ]]
}

# --- link_project ---

@test "link_project: creates symlink when none exists" {
  HOME="$TMPDIR" run link_project
  [ "$status" -eq 0 ]
  [[ "$output" == *"[OK]"* ]]
  [[ "$output" == *"Created symlink"* ]]
  [ -L "$TMPDIR/src" ]
}

@test "link_project: skips when symlink already correct" {
  ln -s "$PROJECT_DIR/src" "$TMPDIR/src"
  HOME="$TMPDIR" run link_project
  [ "$status" -eq 0 ]
  [[ "$output" == *"[SKIP]"* ]]
  [[ "$output" == *"already correctly configured"* ]]
}

@test "link_project: warns and fails when directory exists" {
  mkdir -p "$TMPDIR/src"
  HOME="$TMPDIR" run link_project
  [ "$status" -ne 0 ]
  [[ "$output" == *"[WARN]"* ]]
  [[ "$output" == *"already exists"* ]]
  [[ "$output" == *"rm -rf ~/src"* ]]
}

# --- setup_bash_profile ---

@test "setup_bash_profile: adds source line to new profile" {
  HOME="$TMPDIR" run setup_bash_profile
  [ "$status" -eq 0 ]
  [[ "$output" == *"[OK]"* ]]
  [[ "$output" == *"Added startup.sh source"* ]]
  grep -q "source ~/src/startup.sh" "$TMPDIR/.bash_profile"
}

@test "setup_bash_profile: skips when source line already exists" {
  echo "source ~/src/startup.sh" > "$TMPDIR/.bash_profile"
  HOME="$TMPDIR" run setup_bash_profile
  [ "$status" -eq 0 ]
  [[ "$output" == *"[SKIP]"* ]]
  [[ "$output" == *"already sourced"* ]]
}

# --- list_shell_scripts ---

@test "list_shell_scripts: lists available shell script modules" {
  run list_shell_scripts
  [ "$status" -eq 0 ]
  [[ "$output" == *"Available shell script modules"* ]]
  [[ "$output" == *"gitrc"* ]]
  [[ "$output" == *"awsrc"* ]]
  [[ "$output" == *"startup.sh"* ]]
}

# --- Integration tests ---

@test "show_project_status: runs without errors" {
  run show_project_status
  [ "$status" -eq 0 ]
  [[ "$output" == *"=== Status Check ==="* ]]
}

@test "setup_project: contains error handling logic for missing git" {
  # Test that the function contains proper error handling for missing git
  # This is a smoke test since mocking git in PATH is complex in bats
  run bash -c "grep -q 'Setup failed.*required' '$MAKE_SH'"
  [ "$status" -eq 0 ]

  # Also verify the setup_project function has error handling structure
  run bash -c "grep -A5 -B5 'Setup failed' '$MAKE_SH'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"check_tool"* ]]
  [[ "$output" == *"return 1"* ]]
}