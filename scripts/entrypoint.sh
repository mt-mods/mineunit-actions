#!/bin/bash

while read -r ENV; do export -- "$ENV"; done < <(env | grep -- '-[^=]*=' | sed -r ':ape s/^([^-=]*)-/\1_/;tape')

cd "${INPUT_WORKING_DIRECTORY}"

echo "Running tests in $(pwd)"
/scripts/run-tests.sh

echo "Generating report in $(pwd)"
/scripts/run-report.sh
