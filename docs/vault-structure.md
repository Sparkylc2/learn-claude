# Vault structure

How this learning system is laid out on disk, and what each part is for. The rules Claude follows live in [`vault/CLAUDE.md`](../vault/CLAUDE.md); this page explains the structure and the reasoning behind it.

## Three places

| Where | What lives there | Source of truth for |
| --- | --- | --- |
| This repo | Skills (`skills/`), this doc, a mirror of the vault config (`vault/`) | Skills |
| Obsidian vault — `OneDrive-ImperialCollegeLondon/Year 3/` | Classes, course files, notes, the live `CLAUDE.md` files and templates | `CLAUDE.md` files and templates |
| `~/.claude/skills/` | Symlinks to this repo's skills, so they work in every Claude Code session (desktop Code tab and terminal). *Not set up yet — part of the install step.* | — |

Why split it this way:

- **Skills stay out of OneDrive.** Git repos and symlinks inside OneDrive sync badly, so skills are versioned here and symlinked into `~/.claude/skills/`.
- **The vault's `CLAUDE.md` files and templates are edited where they're used** — in the vault. `scripts/sync-from-vault.sh` copies them into `vault/` so they're versioned too. Run it and commit after changing them.

## The vault

```
Year 3/
  CLAUDE.md                     vault-wide rules for Claude
  Misc/
    Templates/                  Topic Index, Note, Probes
    Obsidian Attachements/      images and SVGs
  Past Exams/
  <Class>/                      one folder per class
    CLAUDE.md                   class-specific overrides
    Index.md                    my own class index
    Files/                      lectures, tutorials, coursework, code, project files
    Notes/                      my own notes
      Learning/                 everything from sessions with Claude
        <Topic>/                one folder per larger subtopic
          <Topic>.md            topic index
          <notes>.md            notes, named for what they are
          Probes.md             quiz log
```

Classes: Aerodynamics 3, Aerospace Vehicle Design, Control Systems, Group Design Project, High Performance Computing, Mathematics 3, Structures 3, Advanced Creative Writing.

### Class folders

- **`Files/`** is whatever the class produces — slides and PDFs for maths, code for HPC, CAD and reports for the design project. Claude reads it on demand as the primary source (notation, scope, what's assessed) and never edits it.
- **`Notes/`** holds my own notes. Claude only writes inside `Notes/Learning/`.
- **`CLAUDE.md`** holds only what differs for that class (e.g. LaTeX-heavy derivations for maths, runnable C++ for HPC). Claude Code loads `CLAUDE.md` from the session folder *and every parent*, so a session opened in a class folder gets both the vault-wide rules and the class overrides — no copies or symlinks needed.

### Learning folders

A session is opened in a class folder and works inside one topic under `Notes/Learning/`.

- **Topic index (`<Topic>.md`)** — the memory between sessions: goal, sources, a loose plan with a dependency map, current level per strand (from probes), where the last session got to, and a log of plan changes. Claude reads it first every session and updates it at the end. A Dataview table lists the topic's notes automatically.
- **Notes** — written *during* the conversation, when something is worth keeping. They loosely fall into:
  - *concept* — introduces a theorem, definition, method, or idea (e.g. "Parseval's theorem" and a short explanation);
  - *problem* — works through problems, linking to what they use;
  - anything else relevant — comparisons, derivations, common mistakes.

  These are labels, not templates to fill: a note is as short or long as its content needs, and kinds can blur. Notes are named for what they are, link to what they build on, and are never duplicated — Claude searches the vault first and links across classes instead. Obsidian's graph view ends up showing the dependency graph the teaching builds.
- **`Probes.md`** — every graded question and its result. Quiz questions that need real notation are written here before being asked, since the chat can't render LaTeX.

## Conventions

- **`ai-generated` tag** on every markdown file Claude writes, plus a loose `kind` property. Notes being learned also carry `status: learning | shaky | solid`, driven by quiz results.
- **Maths:** the chat is for conversation and uses at most simple Unicode; anything needing real notation goes into a note (LaTeX), and the chat points to it.
- **Quizzes:** graded multiple-choice through the Claude Code question popup (typing `idk` in "Other" marks a genuine gap), plus folded `> [!question]-` callouts inside notes for self-testing.

## How a session runs

1. Open the Claude Code tab in the class folder, beside Obsidian.
2. Claude reads the topic index (or creates the topic from templates).
3. Probe → plan → teach, per the `teach` skill. Notes appear in `Notes/Learning/<Topic>/` as they come up; I ask follow-up questions in chat or in a fresh chat on a specific note.
4. At the end, Claude updates the topic index so the next session can pick up cold.
