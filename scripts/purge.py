"""Purge accepted ontologies from NOR Dashboard."""

from pathlib import Path

import click
import requests
import yaml

HERE = Path(__file__).parent.resolve()
ROOT = HERE.parent.resolve()
DASHBOARD_DIRECTORY = ROOT.joinpath("dashboard")
DASHBOARD_CONFIG_PATH = ROOT.joinpath("dashboard-config.yml")

URL = "https://raw.githubusercontent.com/OBOFoundry/OBOFoundry.github.io/master/registry/ontologies.yml"


@click.command()
def main():
    """Purge accepted ontologies from NOR Dashboard."""
    #: A set of prefixes for active ontologies in the OBO Foundry
    prefixes = {
        record["id"]
        for record in yaml.safe_load(requests.get(URL).content)["ontologies"]
        if record["activity_status"] in {"active"}
    }

    # Remove folders corresponding to active ontologies
    for directory in DASHBOARD_DIRECTORY.iterdir():
        if directory.is_dir() and directory.name in prefixes:
            for path in directory.iterdir():
                click.echo(f"removing file: {path}")
                path.unlink()
            click.echo(f"removing directory: {directory}")
            directory.rmdir()

    # Remove configuration corresponding to active ontologies
    config = yaml.safe_load(DASHBOARD_CONFIG_PATH.read_text())
    config["ontologies"]["custom"] = [
        row for row in config["ontologies"]["custom"] if row["id"] not in prefixes
    ]


if __name__ == "__main__":
    main()
