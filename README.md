# mineunit-actions

GitHub actions for mt-mods/mineunit

Executes Lua unit/integration tests with `mineunit` in `spec` directory with code coverage analysis using `cluacov`.
Additionally generates badge parameters for coverage badges as well as plain text coverage reports.

Example badges:
* ![](https://byob.yarr.is/S-S-X/metatool/metatool-coverage)
* ![](https://byob.yarr.is/S-S-X/metatool/sharetool-coverage)

Examples in projects:
* https://github.com/S-S-X/metatool
* https://github.com/S-S-X/qos
* https://github.com/mt-mods/technic
* https://github.com/mt-mods/machine_parts

Example workflow file `.github/workflows/mineunit.yml`:
```yaml
name: mineunit
on: [push, pull_request]

jobs:
  mineunit:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - id: mineunit
      uses: mt-mods/mineunit-actions@master
      with:
        badge-color: "CC9909"
    - uses: RubbaBoy/BYOB@v1.3.0
      with:
        NAME: "${{ steps.mineunit.outputs.badge-name }}"
        LABEL: "${{ steps.mineunit.outputs.badge-label }}"
        STATUS: "${{ steps.mineunit.outputs.badge-status }}"
        COLOR: "${{ steps.mineunit.outputs.badge-color }}"
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Optional parameters for `mt-mods/mineunit-actions`:

* **`working-directory`** Working directory for unit tests, can be used when testing modpacks or multiple mods.
* **`badge-name`** Code coverage badge name.
* **`badge-label`** Code coverage badge label.
* **`badge-color`** Code coverage badge color.
* **`mineunit-args`** Mineunit extra arguments, for example to specify `--engine-version 5.7.0`.
* **`mineunit-version`** Mineunit version.

Outputs:

* **`steps.mineunit.outputs.badge-name`** Code coverage badge name.
* **`steps.mineunit.outputs.badge-label`** Code coverage badge label.
* **`steps.mineunit.outputs.badge-status`** Code coverage badge status.
* **`steps.mineunit.outputs.badge-color`** Code coverage badge color.
* **`steps.mineunit.outputs.mineunit-stdout`** Stdout produced during mineunit run.
* **`steps.mineunit.outputs.mineunit-spec-missing`** Set to true if no spec files found for busted.
* **`steps.mineunit.outputs.mineunit-report`** Mineunit code coverage summary report.
* **`steps.mineunit.outputs.coverage-total`** Total test coverage percentage.
* **`steps.mineunit.outputs.coverage-files`** Number of files tested and total number of source files.
* **`steps.mineunit.outputs.help-busted-spec-missing`** Help for situation where spec files could not be loaded.

Based on Docker image https://hub.docker.com/r/mineunit/mineunit
