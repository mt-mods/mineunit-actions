# mineunit-actions

Executes Minetest Lua mod unit tests with [`mineunit`](https://github.com/mt-mods/mineunit) in `spec` directory with code coverage analysis generating badges for coverage.

Example badges:
* ![mineunit](https://mineunit-badges.000webhostapp.com/S-S-X/fence_connect/coverage)
* ![mineunit](https://mineunit-badges.000webhostapp.com/S-S-X/metatool/metatool-coverage)

Examples in projects:
* https://github.com/S-S-X/metatool
* https://github.com/S-S-X/qos
* https://github.com/mt-mods/technic
* https://github.com/mt-mods/machine_parts

## Example setup

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
      uses: mt-mods/mineunit-actions@v0.3
      with:
        badge-secret: ${{ secrets.MineunitBadgesAPIKey }}
```

You need to create secret `MineunitBadgesAPIKey` with valid API key to generate and update badges.
Optionally you can disable badges by removing `badge-secret` or leaving it empty.

## Mineunit-actions parameters and outputs

#### Optional parameters for `mt-mods/mineunit-actions`:

* **`working-directory`** Working directory for unit tests.
	*default:* `.`
* **`badge-name`** Code coverage badge name (unique id).
    *default:* `coverage`
* **`badge-label`** Code coverage badge label.
	*default:* `Test coverage`
* **`badge-color`** Code coverage badge color.
    *default:* `99CC09`
* **`badge-service`** Custom badge service base URL, see https://github.com/S-S-X/mineunit-badges.
* **`badge-secret`** Badge service API key, no badges generated if empty.
* **`production-branch`** Production branch is what is used for badge generation.
	*default:* `master`
* **`badge-purge-with`** Purge GitHub Camo links in https://github.com/ path, %s substituted for production-branch.
	*default:* `"[account|organization]/[repository]/blob/%s/README.md"`
* **`mineunit-version`** Mineunit version.

#### Outputs that can be used on workflow after Mineunit action completed:

* **`steps.mineunit.outputs.badge-status`** Generated badge status, right hand side text of badge.
* **`steps.mineunit.outputs.badge-url`** Generated badge URL.
* **`steps.mineunit.outputs.mineunit-stdout`** Stdout produced during busted run
* **`steps.mineunit.outputs.mineunit-spec-missing`** Set to true if no spec files found for busted
* **`steps.mineunit.outputs.mineunit-report`** Mineunit detailed test report
* **`steps.mineunit.outputs.coverage-total`** Total test coverage percentage
* **`steps.mineunit.outputs.coverage-files`** Number of files tested and total number of source files
* **`steps.mineunit.outputs.help-busted-spec-missing`** Help for situation where spec files could not be loaded
