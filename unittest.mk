#!/usr/bin/make
# WARN: gmake syntax
########################################################
# Makefile for ztpserver
#
# useful targets:
#   make sdist -- builds a source distribution
#   make pyflakes, make pep8 -- source code checks
#   make pylint -- source code checks
#   make tests -- run the tests
#   make test_server -- run all server tests (including neighbordb)
#   make test_server TESTNAME=<name of test>
#   make test_client -- run client tests
#   make test_client TESTNAME=<name of test>
#   make test_actions -- run action tests only
#   make test_actions TESTNAME=<name of test>
#   make test_neighbordb -- run neighbordb tests only
#   make distclean -- cleans distutils
#
########################################################
# variable section

NAME = "Sandbox2"
PYTHON = python
TESTNAME = discover

MODULES = "FooNewTests"

# VERSION := $(shell cat VERSION)

########################################################

# Moves to master Makefile
#all: distclean python

pep8:
	@echo "#############################################"
	@echo "# Running PEP8 Compliance Tests"
	@echo "#############################################"
	-pep8 -r --ignore=E501,E221,W291,W391,E302,E251,E203,W293,E231,E303,E201,E225,E261,E241 ztpserver/ bin/
	-pep8 -r --ignore=E501,E221,W291,W391,E302,E251,E203,W293,E231,E303,E201,E225,E261,E241 --filename "*" client/

pyflakes:
	#pyflakes ztpserver/* bin/*

pylint:
	find . -name \*.py | xargs pylint --ignore=conf.py,conf --rcfile .pylintrc
	#find . -name \*.py | xargs pylint --rcfile .pylintrc

clicoverage:
	nosetests --with-coverage --cover-erase --cover-html $(MODULES)
	@#coverage run --source=. -m FooNewTests

coverage:
	nosetests --verbosity=3 -x --with-xunit --with-coverage --cover-erase --cover-html $(MODULES)

coverageclean:
	rm -rf cover
	rm .coverage

unittest:
	PYTHONPATH=./ $(PYTHON) -m $(MODULES)

distclean:
	@echo "Cleaning up distutils stuff"
	rm -rf build
	rm -rf dist
	rm -rf MANIFEST
	@echo "Cleaning up byte compiled python stuff"
	find . -type f -regex ".*\.py[co]$$" -delete

test_neighbordb: distclean
	PYTHONPATH=./ $(PYTHON)  ./test/server/test_neighbordb.py

test_client: distclean
ifeq ($(TESTNAME),discover)
	$(PYTHON)  -m unittest discover test/client -v
else
	$(PYTHON)  test/client/$(TESTNAME) -v
endif

test_actions: distclean
ifeq ($(TESTNAME),discover)
	$(PYTHON)  -m unittest discover test/actions -v
else
	$(PYTHON)  test/actions/$(TESTNAME) -v
endif

test_server: distclean
ifeq ($(TESTNAME),discover)
	$(PYTHON)  -m unittest discover test/server -v
else
	$(PYTHON)  test/server/$(TESTNAME) -v
endif

tests: distclean unittest coverage
#tests: distclean test_server test_client test_actions

#python:
#	$(PYTHON) setup.py build

#install:
#	$(PYTHON) setup.py install

#sdist: distclean
#	$(PYTHON) setup.py sdist -t MANIFEST.in

