"""Defines the main command that can ve run within the mve_join application"""

import typer

from mve_joiner_redux.mve_joiner import mve_joiner

app = typer.Typer()

app.command("mve_join")(mve_joiner)

if __name__ == "__main__":
    app()
