.PHONY: help clean clean-build clean-pyc clean-test install install-dev format lint typecheck check test test-all coverage build publish

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make install        Sync production dependencies with uv"
	@echo "  make install-dev    Sync development dependencies with uv"
	@echo "  make format         Fix and format code with Ruff"
	@echo "  make lint           Check linting and formatting with Ruff"
	@echo "  make typecheck      Type-check code with ty"
	@echo "  make check          Run linting, type checking, and tests"
	@echo "  make test           Run tests with pytest"
	@echo "  make test-all       Run tests on all supported Python versions with uv"
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
	rm -fr .ruff_cache/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache/

install:
	uv sync --no-dev

install-dev:
	uv sync

format:
	uv run ruff check --fix molprep tests
	uv run ruff format molprep tests

lint:
	uv run ruff check molprep tests
	uv run ruff format --check molprep tests

typecheck:
	uv run ty check

check: lint typecheck test

test:
	uv run pytest

test-all:
	@for version in 3.9 3.10 3.11 3.12 3.13 3.14; do \
		echo "Testing with Python $$version"; \
		uv run --isolated --python $$version pytest || exit 1; \
	done

coverage:
	uv run pytest --cov=molprep --cov-report=html --cov-report=term-missing
	@echo "Coverage report generated in htmlcov/index.html"

build: clean
	uv build

publish: build
	uv publish dist/*
