<!--
@license
Copyright (c) ggdna

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# dna_github

DNA layer: GitHub repository setup (branch rules, PR settings, quick check
workflow).

## Create a new DNA repo from this template

1. Copy the repo and replace `dna_github` / `dna-github` /
   `dnaTemplateVersion` in `pubspec.yaml`, `package.json`, `README.md`,
   `example/`, `lib/src/` and `test/` (including the file names)
2. Set `dnaCopyrightHolder` and `dnaCompany` in `dna/_vars.json`
3. Rename `dna/doc/guides/topic-guide.md` and
   `dna/dot-claude/skills/topic/` to your topic and fill in the TODOs
4. Replace the example files in `dna/` with your own
5. Reset `CHANGELOG.md`, run `dart test`, commit

## Guides

- `dna/doc/guides/topic-guide.md` — TODO: what is configured and how to
  extend or override it

## Skills

- `/topic` — TODO: what the skill does

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
