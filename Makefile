# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

clean: ## Remove temporary dirs
	@rm -rf dist build *.egg-info

.PHONY: clean

build: clean ## Build wheels
	python setup.py sdist bdist_wheel

.PHONY: build

prepare-env: ## Setup `twine` to release pipy
	pip install twine

.PHONY: prepare-env

release: build ## Release to PiPy
	twine upload dist/*

.PHONY: release