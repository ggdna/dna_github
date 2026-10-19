<!--
@license
Copyright (c) ggdna

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# dna_github

[English](README.md) | Deutsch

[![CI](https://github.com/ggdna/dna_github/actions/workflows/quick_check.yaml/badge.svg)](https://github.com/ggdna/dna_github/actions/workflows/quick_check.yaml)

Gibt einem Repo die GitHub-Einstellungen, die Branch-Regeln und den
Quick-Check-Workflow, der jeden Pull Request prüft.

## Motivation

GitHub hält die Merge-Einstellungen und die Branch-Regeln eines Repos in seinen
Einstellungen fest, nicht im Code. Von Hand gesetzt, können sie von Repo zu Repo
abweichen: Eines erlaubt Merge-Commits, ein anderes behält gemergte Branches,
ein drittes lässt einen Pull Request ohne grünen Check durch. Diese Schicht legt
den Quick-Check-Workflow ins Repo und setzt mit einem Skript überall dieselben
Einstellungen: nur Squash-Merges, Auto-Merge, Branches nach dem Merge gelöscht
und ein geschützter Default-Branch, der nur Pull Requests annimmt, die den
Quick Check bestanden haben.

## Verwendung

Als Dev-Dependency eintragen und einmal initialisieren:

```bash
pnpm add -D @ggdna/dna-github   # TypeScript projects
dart pub add dev:dna_github     # Dart projects
helix init
```

`helix init` legt einen Test ab, der die DNA bei jedem Testlauf instanziiert
und prüft. Er kopiert den Workflow nach `.github/workflows/`, das Skript nach
`scripts/` und den Guide nach `guides/`.

Merge den Workflow zuerst in `main`: Die Branch-Regeln können nur einen Check
verlangen, den es dort gibt. Dann die Einstellungen ansehen und anwenden. Das
Skript braucht Node.js und die [GitHub CLI](https://cli.github.com),
angemeldet mit `gh auth login`:

```bash
node scripts/setup-github-repo.js           # print the settings, change nothing
node scripts/setup-github-repo.js --apply   # apply them
```

Das Skript arbeitet mit dem Repo des aktuellen Verzeichnisses oder mit dem als
Argument übergebenen `org/repo`. `--require-review` verlangt zusätzlich ein
zustimmendes Review und aufgelöste Review-Threads.

## Guides

- `dna/guides/setup-github-guide.md` — die Schicht hinzufügen, den Workflow in
  `main` mergen, die Einstellungen ansehen und anwenden und den README-Check
  blockierend machen

## Skripte

- `dna/scripts/setup-github-repo.js` — gibt die Repo-Einstellungen aus oder
  wendet sie mit `--apply` an: nur Squash-Merges mit dem Titel des Pull
  Requests als Commit-Titel, Auto-Merge, Branches nach dem Merge gelöscht und
  ein Ruleset namens `Default` auf dem Default-Branch ohne Löschen, ohne Force
  Push, mit linearer Historie, Pflicht zum Pull Request und dem Quick Check als
  verlangtem Status-Check; der Setup-Guide ruft es auf

## Konfiguration

- `dna/dot-github/workflows/quick_check.yaml` — der Quick Check bei jedem Push
  auf `main` und jedem Pull Request dagegen. Er führt
  `npx @tssuite/ggwsm one did commit` aus und richtet danach, wenn das Repo
  `scripts/check-readme.js` aus dna_readme hat, Node.js 22 ein und startet
  `node scripts/check-readme.js`. Ein Repo ohne das Skript überspringt beide
  Schritte.

Der README-Check ist standardmäßig nur ein Hinweis: Seine Befunde erscheinen
als Warnungen am Lauf, und der Quick Check bleibt grün. Setze die
GitHub-Variable `README_CHECK` des Repos auf `required`, damit ein Befund zum
Fehler wird, der den Quick Check scheitern lässt und den Merge blockiert:

```bash
gh variable set README_CHECK --body required
```

## Umfang

Die Schicht richtet nur GitHub ein: die Repo-Einstellungen, die Branch-Regeln
und den Workflow, den sie verlangen. Was der Quick Check prüft, kommt von
`@tssuite/ggwsm` und von dna_readme. Die Schicht legt das Repo nicht an, und
sie setzt `README_CHECK` nicht: `setup-github-repo.js` lässt diese Variable in
Ruhe. dna_scripts liefert ein eigenes `scripts/setup-github-repo.js`.

## Schichten

Die Schicht ist orthogonal: `dna/_dna.json` nennt keine Eltern-Schichten. Sie
trägt nur ihr eigenes Thema und wird vom nutzenden Repo mit anderen Schichten
kombiniert, z. B. von dna_gg.

## Variablen

- `dnaGitQuickCheckPipelineName` — der Name des Quick-Check-Jobs; das Skript
  macht ihn zum verlangten Status-Check, sodass beide immer übereinstimmen
- `dnaCopyrightHolder` — der Rechteinhaber im Copyright-Kopf jeder abgelegten
  Datei
- `dnaCompany` — der Name der Firma; keine Datei dieser Schicht nutzt ihn

`mustOverride` in `dna/_dna.json` zwingt jedes Repo und jede Schicht, die diese
Schicht einbindet, `dnaGitQuickCheckPipelineName` und `dnaCopyrightHolder` in
der eigenen `dna/_vars.json` zu setzen, weil beide die Organisation nennen und
keinen sinnvollen Standardwert haben. `README_CHECK` ist eine GitHub-Variable
des Repos, keine DNA-Variable.

## Entwicklung

Der Ordner `dna/` ist handgeschriebene Quelle und wird nie generiert. Das Repo
instanziiert seine eigene DNA — nach Änderungen `dart test` laufen lassen;
vorher committen, denn eine Datei, die die DNA überschreiben würde, darf keine
uncommittete Arbeit enthalten.

Bearbeite die Dateien unter `dna/`, nie ihre Kopien in `.github/`, `scripts/`
und `guides/`: Der Test überschreibt sie.

## Lizenz

MIT — siehe [LICENSE](LICENSE).
