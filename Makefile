.PHONY: help setup status test install-op install-1password install-varlock

help:
	@echo ""
	@echo "=== Targets ==="
	@echo "  help                List targets"
	@echo "  setup               Set up symlinks for this project"
	@echo "  status              Check if the local machine has already been set up"
	@echo "  test                Run all unit tests"
	@echo "  install-op          Install 1Password CLI via brew"
	@echo "  install-1password   Install 1Password desktop app via brew cask"
	@echo "  install-varlock     Install varlock via brew"
	@echo ""
	@source ./make.sh && list_shell_scripts

setup:
	@source ./make.sh && setup_commands && setup_bash_profile

status:
	@source ./make.sh && show_status && show_project_status

test:
	@source ./make.sh && run_tests

install-op:
	brew install 1password-cli

install-1password:
	brew install --cask 1password

install-varlock:
	brew install varlock
