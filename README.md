# Repo to manage the OBO Foundry Dashboard for New Ontology Requests (NORs)

Page deployed at: https://obofoundry.github.io/obo-nor.github.io/

## Update

1. change `dashboard-config.yml`
2. run `sh run-dash.sh`

## Remove accepted ontologies

After ontologies have been accepted into the OBO Foundry, they will be displayed on the
main [OBO Dashboard](https://dashboard.obofoundry.org/) and can be safely removed from the NOR dashboard. This is
automated with the following code:

```shell
pip install tox
tox -e purge
```

This is also automatically run nightly via GitHub Actions. [![Remove Accepted Ontologies](https://github.com/OBOFoundry/obo-nor.github.io/actions/workflows/purge.yml/badge.svg)](https://github.com/OBOFoundry/obo-nor.github.io/actions/workflows/purge.yml)