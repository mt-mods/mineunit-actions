#!/bin/bash

# Generate luacov report and write it to output
mineunit -r
OUT="$(awk -v p=0 '/^----/{p++;next}p==2{exit}p' luacov.report.out | sort -hrk4)"
printf 'mineunit-report<<END-OF-MINEUNIT-CONTENT\n%s\nEND-OF-MINEUNIT-CONTENT\n' "${OUT}" >> "${GITHUB_OUTPUT}"

# Read and sort coverage information from luacov report
COVERAGE_TOTAL="$(tail -n 2 luacov.report.out | grep ^Total | grep -o '[0-9.]\+%$')"
echo "coverage-total=${COVERAGE_TOTAL}" >> "${GITHUB_OUTPUT}"
awk -v p=0 '/^----/{p++;next}p==2{exit}p' luacov.report.out | sort -hrk4 > luacov.report.sum
COVERAGE_FILES="$(grep -cv '\s0\.00%' luacov.report.sum)/$(wc -l<luacov.report.sum)"
echo "coverage-files=${COVERAGE_FILES}" >> "${GITHUB_OUTPUT}"

# badge-wrapper-actions-issue-1
echo "badge-name=${INPUT_BADGE_NAME}" >> "${GITHUB_OUTPUT}"
echo "badge-label=${INPUT_BADGE_LABEL}" >> "${GITHUB_OUTPUT}"
echo "badge-color=${INPUT_BADGE_COLOR}" >> "${GITHUB_OUTPUT}"
echo "badge-status=${COVERAGE_TOTAL} in ${COVERAGE_FILES} files" >> "${GITHUB_OUTPUT}"
