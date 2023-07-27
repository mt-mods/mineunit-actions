#!/bin/bash

# Run tests, collect output and save return code
set +eo pipefail
exec 3>&1
OUT="$(mineunit -c ${INPUT_MINEUNIT_ARGS} | tee >(cat - >&3); exit ${PIPESTATUS[0]})"
ERR=$?
exec 3>&-

# Check for some hard errors
grep_eronly=(grep '0 successes / 0 failures / [1-9] error.\? / 0 pending')
grep_nospec=(grep 'No test files found')
("${grep_eronly[@]}"<<<"$OUT" && "${grep_nospec[@]}"<<<"$OUT")&>/dev/null && echo "mineunit-spec-missing=true" >> "${GITHUB_OUTPUT}"

# Remove some shell stuff and write output
OUT="$(sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'<<<"$OUT")"
printf 'mineunit-stdout<<END-OF-MINEUNIT-CONTENT\n%s\nEND-OF-MINEUNIT-CONTENT\n' "${OUT}" >> "${GITHUB_OUTPUT}"

# Return original error code
exit $ERR
