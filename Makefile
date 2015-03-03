#!/usr/bin/make -f

PYBOX_ROOT:=$(shell pwd)

SANDOX_DIR:=$(PYBOX_ROOT)/.pybox

SB:=. $(SANDOX_DIR)/bin/activate &&

all:

init: init-py2

init-py3:
	python3 -m virtualenv $(SANDOX_DIR)

init-py2:
	python2 -m virtualenv $(SANDOX_DIR)

shell:
	@test -d $(SANDOX_DIR) || (echo "Cant find PyBox dir $(SANDOX_DIR). Run 'pybox init' to setup a fresh sandox"; exit 1)
	$(SB) debian_chroot=PYBOX:$(shell basename $(PYBOX_ROOT)) /bin/bash

clean: $(SANDOX_DIR)
	rm -Rf $(SANDOX_DIR)