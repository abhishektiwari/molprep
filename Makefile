.PHONY: help clean clean-build clean-pyc clean-test format lint test test-all coverage install install-dev build publish

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make install        Install package in production mode"
	@echo "  make install-dev    Install package in development mode with dev dependencies"
	@echo "  make format         Format code with black and isort"
	@echo "  make lint           Check code quality with flake8 and mypy"
	@echo "  make test           Run tests with pytest"
	@echo "  make test-all       Run tests on multiple Python versions with tox"
	@echo "  make coverage       Generate test coverage report"
	@echo "  make build          Build source and wheel distributions"
	@echo "  make clean          Remove all build, test, and Python artifacts"
	@echo "  make publish        Publish package to PyPI"

clean: clean-build clean-pyc clean-test

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache/

install:
	pip install -e .

install-dev:
	pip install -e ".[dev]"

format:
	black molprep tests
	isort molprep tests

lint:
	flake8 molprep tests
	mypy molprep
	black --check molprep tests
	isort --check-only molprep tests

test:
	pytest

test-all:
	tox

coverage:
	pytest --cov=molprep --cov-report=html --cov-report=term-missing
	@echo "Coverage report generated in htmlcov/index.html"

build: clean
	python -m build

publish: build
	python -m twine upload dist/*
