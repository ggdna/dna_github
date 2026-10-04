<!--
@license
Copyright (c) ggdna

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# dna_github

DNA layer: GitHub repository setup (branch rules, PR settings, quick check
workflow).

## What it sets up

- `scripts/setup-github-repo.js` — previews and applies the repository
  settings: squash merges only, auto merge, branches deleted after merge,
  and a `Default` ruleset on the default branch (no deletion, no force
  push, linear history, pull requests required, quick check must pass);
  `--require-review` also requires one approving review and resolved
  review threads
- `.github/workflows/quick_check.yaml` — the quick check the ruleset
  requires

## Guides

- `dna/guides/setup-github-guide.md` — add the layer, merge it into
  `main`, preview the settings with `node scripts/setup-github-repo.js`
  and apply them with `--apply`; requires the
  [GitHub CLI](https://cli.github.com) (`gh auth login`)

## Layers

Orthogonal: this layer carries only its own topic and is combined with
other layers by the consuming repo.

## Variables

- `dnaCopyrightHolder` — the name in the license header of every file
- `dnaCompany` — the company name

## Usage

Declare it as a dev-dependency and initialize once:

```bash
pnpm add -D @ggdna/dna-github   # TypeScript projects
dart pub add dev:dna_github     # Dart projects
helix init
```

The placed test instantiates and verifies the DNA on every test run.

## Development

The `dna/` folder is hand-authored source and is never generated. The repo
instantiates its own DNA — run `dart test` after changes; commit first, a
file the DNA would overwrite must not carry uncommitted work.
