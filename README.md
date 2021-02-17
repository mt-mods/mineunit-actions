# mineunit-actions
GitHub actions for mt-mods/mineunit

Executes Lua unit tests with `busted` in `spec` directory with code coverage analysis using `cluacov` and generates badge for coverage.

Example badges:
* ![](https://byob.yarr.is/S-S-X/metatool/metatool-coverage)
* ![](https://byob.yarr.is/S-S-X/metatool/sharetool-coverage)

Examples in projects:
* https://github.com/S-S-X/metatool
* https://github.com/mt-mods/technic

Example workflow file `.github/workflows/mineunit.yml`:
```yaml
name: mineunit
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - id: mineunit
      uses: mt-mods/mineunit-actions@master
    - uses: RubbaBoy/BYOB@v1.2.0
      with:
        NAME: "${{ steps.mineunit.outputs.badge-name }}"
        LABEL: "${{ steps.mineunit.outputs.badge-label }}"
        STATUS: "${{ steps.mineunit.outputs.badge-status }}"
        COLOR: "${{ steps.mineunit.outputs.badge-color }}"
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Optional parameters for `mt-mods/mineunit-actions`:
* working-directory
* badge-name
* badge-label
* badge-color
* luacov-exclude
