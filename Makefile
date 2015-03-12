#!/usr/bin/make -f

PYBOX_ROOT:=$(shell pwd)

SANDOX_DIR:=$(PYBOX_ROOT)/.pybox

SB:=. $(SANDOX_DIR)/bin/activate &&

all: help

help: #!pybox-command Show this help
	@echo Usage:
	@echo "  pybox <command>"
	@echo 
	@echo Commands:
	@grep '\#!pybox-command' `which pybox` | grep -v grep | sed 's/\(^[^:]*\):.*\#!pybox-command\(.*\)/    \1\t\2/'

init: init-py2 #! pybox-command Init default (python2) sandbox

init-py3:  #!pybox-command Init python2 sandbox
	python3 -m virtualenv $(SANDOX_DIR)

init-py2:  #!pybox-command Init python3 sandbox
	python2 -m virtualenv $(SANDOX_DIR)

shell:  #!pybox-command Start sandboxed shell
	@test -d $(SANDOX_DIR) || (echo "Cant find PyBox dir $(SANDOX_DIR). Run 'pybox init' to setup a fresh sandox"; exit 1)
	$(SB) debian_chroot=PYBOX:$(shell basename $(PYBOX_ROOT)) /bin/bash

clean: #!pybox-command Wipe sandbox
	-rm -Rf $(SANDOX_DIR)