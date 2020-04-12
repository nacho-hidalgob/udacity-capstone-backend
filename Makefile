## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test
.PHONY: clean-pyc clean-build help
.PHONY: lint test
.DEFAULT_GOAL := help

help:
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | sort | awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'

clean: clean-build clean-pyc

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

setup: ## Create python virtualenv & source it
	python3 -m venv .venv

install-requirements: ## install package requirements
	pip install -r requirements/base.txt

install-test-requirements: ## install requirements for testing
	pip install -r requirements/test.txt

lint:  ## check style Dockerfile and python
	hadolint Dockerfile
	pylint --disable=R,C,W1202,W1203 app.py

all: install lint test
