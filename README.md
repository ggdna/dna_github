<!--
@license
Copyright (c) ggdna

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# dna_github

English | [Deutsch](README.de.md)

[![CI](https://github.com/ggdna/dna_github/actions/workflows/quick_check.yaml/badge.svg)](https://github.com/ggdna/dna_github/actions/workflows/quick_check.yaml)

Gives a repo the GitHub settings, the branch rules and the quick check workflow
that checks every pull request.

## Motivation

GitHub keeps the merge settings and the branch rules of a repo in its settings,
not in the code. Set by hand, they can differ from repo to repo: one allows
merge commits, another keeps merged branches, a third lets a pull request in
without a green check. This layer puts the quick check workflow into the repo
and applies the same settings with one script: squash merges only, auto merge,
branches deleted after the merge, and a protected default branch that only
takes pull requests that passed the quick check.

## Usage

Declare it as a dev-dependency and initialize once:

```bash
pnpm add -D @ggdna/dna-github   # TypeScript projects
dart pub add dev:dna_github     # Dart projects
helix init
```

`helix init` places a test that instantiates and verifies the DNA on every
test run. It copies the workflow to `.github/workflows/`, the script to
`scripts/` and the guide to `guides/`.

Merge the workflow into `main` first: the branch rules can only require a check
that exists there. Then preview the settings and apply them. The script needs
Node.js and the [GitHub CLI](https://cli.github.com), logged in with
`gh auth login`:

```bash
node scripts/setup-github-repo.js           # print the settings, change nothing
node scripts/setup-github-repo.js --apply   # apply them
```

The script works on the repo of the current directory, or on the `org/repo`
given as an argument. `--require-review` also requires one approving review and
resolved review threads.

## Guides

- `dna/guides/setup-github-guide.md` — add the layer, merge the workflow into
  `main`, preview and apply the settings, and make the README check blocking

## Scripts

- `dna/scripts/setup-github-repo.js` — prints or, with `--apply`, applies the
  repo settings: squash merges only with the pull request title as the commit
  title, auto merge, branches deleted after the merge, and a ruleset named
  `Default` on the default branch with no deletion, no force push, a linear
  history, pull requests required and the quick check as a required status
  check; the setup guide calls it

## Configuration

- `dna/dot-github/workflows/quick_check.yaml` — the quick check on every push
  to `main` and every pull request against it. It runs
  `npx @tssuite/ggwsm one did commit`, then, when the repo has
  `scripts/check-readme.js` from dna_readme, sets up Node.js 22 and runs
  `node scripts/check-readme.js`. A repo without the script skips both steps.

The README check is advisory by default: its findings show up as warnings on
the run, and the quick check stays green. Set the GitHub variable
`README_CHECK` of the repo to `required` to make a finding an error that fails
the quick check and blocks the merge:

```bash
gh variable set README_CHECK --body required
```

## Scope

The layer only sets up GitHub: the repo settings, the branch rules and the
workflow they require. What the quick check checks comes from
`@tssuite/ggwsm` and from dna_readme. The layer does not create the repo, and
it does not set `README_CHECK`: `setup-github-repo.js` leaves that variable
alone. dna_scripts ships a `scripts/setup-github-repo.js` of its own.

## Layers

The layer is orthogonal: `dna/_dna.json` lists no parent layers. It carries
only its own topic and is combined with other layers by the consuming repo,
e.g. by dna_gg.

## Variables

- `dnaGitQuickCheckPipelineName` — the name of the quick check job; the script
  makes it the required status check, so both always match
- `dnaCopyrightHolder` — the holder named in the copyright header of every
  placed file
- `dnaCompany` — the name of the company; no file of this layer uses it

`mustOverride` in `dna/_dna.json` forces every repo or layer that lists this
layer to set `dnaGitQuickCheckPipelineName` and `dnaCopyrightHolder` in its own
`dna/_vars.json`, because both name the organization and have no sensible
default. `README_CHECK` is a GitHub variable of the repo, not a DNA variable.

## Development

The `dna/` folder is hand-authored source and is never generated. The repo
instantiates its own DNA — run `dart test` after changes; commit first, a file
the DNA would overwrite must not carry uncommitted work.

Edit the files below `dna/`, never their copies in `.github/`, `scripts/` and
`guides/`: the test overwrites them.

## License

MIT — see [LICENSE](LICENSE).
