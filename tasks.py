from __future__ import annotations

from invoke import Context, task


@task
def verify_pre_commit(c: Context) -> None:
    c.run("pre-commit run --all-files")


@task
def check_licenses(c: Context) -> None:
    c.run("poetry export -f requirements.txt -o requirements.txt --without-hashes --without dev")
    c.run("poetry run liccheck -s ./liccheck.ini -r requirements.txt")
    c.run("rm -f requirements.txt")


@task
def check_types(c: Context) -> None:
    c.run("rm -rf .mypy_cache")
    c.run("poetry run mypy .")
