<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Topic Guide

TODO: One or two sentences on what this DNA layer provides.

## What is configured

- TODO: List what the files in `dna/` set up
- Variables available in templates: `dnaCopyrightHolder`, `dnaCompany`
  (values in `dna/_vars.json`)

## Add a file

- Put it in `dna/`. A leading `dot-` becomes a `.` in the consuming repo
  (`dna/dot-foo/bar.json` → `.foo/bar.json`)
- Run `dart test` to instantiate the DNA and update `dna/_generated.json`

## Override in a consuming repo

- A same-path file in a later layer replaces this one whole
- A `<name>.overrides.json` merges instead: objects deep-merge, `"key!"`
  replaces without merging, `"key+"` appends to an array — see the helix
  README for the full syntax
