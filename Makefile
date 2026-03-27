.PHONY: help setup status install-op install-1password install-varlock

help:
	@echo ""
	@echo "=== Targets ==="
	@echo "  help                List targets"
	@echo "  setup               Set up symlinks for this project"
	@echo "  status              Check if the local machine has already been set up"
	@echo "  install-op          Install 1Password CLI via brew"
	@echo "  install-1password   Install 1Password desktop app via brew cask"
	@echo "  install-varlock     Install varlock via brew"
	@echo ""

setup:
	@source ./make.sh && setup_commands

status:
	@source ./make.sh && show_status

install-op:
	brew install 1password-cli

install-1password:
	brew install --cask 1password

install-varlock:
	brew install varlock
