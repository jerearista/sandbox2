# Master Makefile for Sandbox2 test project
#

VERSION := $(shell cat VERSION)

include *.mk

clean: sphinxclean distclean coverageclean

#all: distclean python
