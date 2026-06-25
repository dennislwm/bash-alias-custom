.PHONY: help setup status test

help:
	@echo ""
	@echo "=== Targets ==="
	@echo "  help                List targets"
	@echo "  setup               Set up symlinks for this project"
	@echo "  status              Check if the local machine has already been set up"
	@echo "  test                Run all unit tests"
	@echo ""
	@source ./make.sh && list_shell_scripts

setup:
	@source ./make.sh && setup_commands && setup_bash_profile && setup_lpass_profile "$(NOTE)"

status:
	@source ./make.sh && check_link "$$HOME/src" && show_project_status

test:
	@source ./make.sh && run_tests

