SHELL := /bin/bash

test:
	poetry run pytest -n auto

check:
	poetry run mypy .

.PHONY: test migrate check
