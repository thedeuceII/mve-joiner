#!/bin/bash
pipx inject --pip-args '--no-cache-dir --force-reinstall' -f poetry "poetry-plugin-export==1.5.0"
poetry config virtualenvs.prefer-active-python true
poetry config virtualenvs.in-project true
poetry install --sync

poetry run pip install pre-commit
