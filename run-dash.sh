#!/usr/bin/env bash

set -e

OBODASH="sh odk.sh "

rm -rf dashboard ontologies
mkdir -p dashboard ontologies
#$OBODASH refresh -B
$OBODASH make run_dashboard