# NOR Dashboard

## Repo to manage the OBO Foundry Dashboard for New Ontology Requests

Page deployed at: https://obofoundry.github.io/obo-nor.github.io/

To update:

1. change `dashboard-config.yml`
2. run `sh run-dash.sh`

## Technical Review Procedure for New Ontology Requests

The overall technical review process is described in the OBO Foundry NOR (New Ontology Request) Manager documentation:

https://obofoundry.org/roles/nor-manager/

This document provides additional technical guidance for reviewers and describes the specific steps required to complete the technical review.

### Overview

The technical review consists of three main steps:

1. Validate the OBO Foundry pre-registration checklist.
2. Add the ontology metadata to the dashboard configuration.
3. Perform lexical matching.

Each step should be completed before moving on to the next. If significant issues are identified during any stage of the review, they should be addressed by the submitter before the review proceeds.

---

# 1. Validate the OBO Foundry Pre-registration Checklist

This step is performed manually and should not be treated as a simple verification of checked boxes. Experience shows that checklist items are often marked as completed without being fully validated.

Reviewers should carefully verify the following elements:

- Presence of a **Version IRI**.
- Presence of a clearly specified **license annotation**.
- Compliance with OBO Foundry **IRI conventions**.
- Appropriate reuse of object properties from the **Relation Ontology (RO)**.
- Appropriate reuse of annotation properties from the **Ontology Metadata Ontology (OMO)**.
- General structural quality and consistency of the ontology.

This stage is also an opportunity to perform a broader assessment of the ontology and identify any fundamental modeling or architectural issues.

Any issues identified during this phase should be communicated to the submitter and resolved before continuing with the review process.

---

# 2. Add the Ontology to the Dashboard Configuration

Once the ontology satisfies the pre-registration requirements, a new ontology record should be added to the `ontologies -> custom` section of the `dashboard-config.yml` file.

The following template can be used as a starting point:

```yaml
- id: ontology_namespace
  mirror_from: https://example.org/path/to/ontology.owl
  title: Ontology Name
  contact:
    email: submitter@example.org
    label: Submitter Name
    orcid: 0000-0000-0000-0000
    github: github_username
  description: Short description of the ontology
  domain: Ontology domain
  homepage: https://ontology-homepage.org
  products:
    - id: ontology.owl
  tracker: https://github.com/organization/repository/issues
  license:
    url: https://creativecommons.org/licenses/by/4.0/
    label: CC BY 4.0
````
## Metadata Requirements

Only information explicitly provided in the New Ontology Request should be added to the dashboard configuration.

Additional fields may be included when supporting information is available.

### Important Notes

The ontology identifier (id) should be the ontology namespace in lowercase.

mirror_from should point directly to the raw ontology file.

The ontology product must be provided as an .owl file.

Contact information should correspond to the submitter identified in the request.

License information should accurately reflect the license declared by the ontology developers.


## Submitting the Changes

Dashboard configuration updates should be submitted as a pull request (PR) rather than committed directly.

After the pull request has been merged:

Merge the automatically generated Update Dashboard Run PR.
Wait for the dashboard to refresh.
Review the dashboard results and provide feedback to the submitter if necessary.

# 3. Perform lexical matching

## Overview

The `obo-lexical-review` command is available through the PyOBO CLI. A convenient way to run it is with `uv`, which creates an isolated environment and installs the required dependencies automatically. In some cases, running pyobo need to explicitely assert the dependency with the `Gilda` library.

## Prerequisites

### 1. Install Python

Verify that Python is installed:

```bash
python --version
```

or

```bash
python3 --version
```

A recent Python version (3.11 or later) is recommended.

### 2. Install uv

Installation instructions [here](https://docs.astral.sh/uv/getting-started/installation/)

Verify the installation:

```bash
uv --version
```

## Running PyOBO Without Permanent Installation

Display the CLI help:

```bash
uv run --with "pyobo[gilda]" pyobo --help
```

Display help for the lexical review command:

```bash
uv run --with "pyobo[gilda]" pyobo obo-lexical-review --help
```

## Running OBO Lexical Review

General syntax:

```bash
uv run --with "pyobo[gilda]" pyobo obo-lexical-review [OPTIONS]
```

Example using a local ontology file:

```bash
uv run --with "pyobo[gilda]" pyobo obo-lexical-review MY_ONTOLOGY_NAMESPACE --location "\folder\location\my_ontology.owl" --skip-upper
```

