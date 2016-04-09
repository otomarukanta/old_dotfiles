DOTFILES_PATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
IGNORE_FILES := .DS_Store .git .gitmodules
DOTFILES := $(filter-out $(IGNORE_FILES), $(wildcard .??*))

all:
	@echo $(DOTFILES_PATH)

symlink:
	@printf "Start to symlink dotfiles to home directory.\n"
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init-git-user:
	bash ./scripts/setup_git.sh
