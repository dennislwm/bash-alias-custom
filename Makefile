.PHONY: help setup status test
SHELL := /bin/bash

help:
	@echo "Targets: help, setup, status, test"
	@echo "This project provides custom bash aliases via ~/.src symlink"
	@source ./make.sh && list_shell_scripts

setup:
	@source ./make.sh && setup_project

status:
	@source ./make.sh && show_project_status

test:
	@source ./make.sh && run_tests