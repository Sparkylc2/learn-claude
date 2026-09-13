# learn — Claude Code + Obsidian

[![video](assets/thumbnail.png)](https://www.youtube.com/watch?v=kzcI5F4tGiU)

My AI learning system, based on [How I Use AI to Learn Things](https://www.youtube.com/watch?v=kzcI5F4tGiU). Forked from [amosblomqvist/learn](https://github.com/amosblomqvist/learn), which was built for pi, and rebuilt for how I actually work: Claude Code (the desktop app's Code tab beside Obsidian, or `claude` in a terminal) teaching me inside my Year 3 Obsidian vault.

The teaching philosophy is upstream's. The workflow around it is mine.

## What's in it

- `skills/teach/` — the philosophy and the process: probe → plan → teach, with notes written into the vault as the conversation goes
- `skills/visualize/` — adds a correct, minimal mermaid diagram or SVG to a note
- `docs/vault-structure.md` — how the vault is laid out and why
- `vault/` — mirror of the vault's `CLAUDE.md` files and templates
- `scripts/sync-from-vault.sh` — refreshes `vault/` from the real vault

## How it works

- A session is opened in a class folder. Claude Code loads the vault-wide `CLAUDE.md` plus that class's overrides.
- Each larger subtopic has a folder under `<Class>/Notes/Learning/`, with a topic index that carries memory between sessions (goal, plan, current level, where we got to).
- Teaching happens in chat. Notes — concept-ish, problem-ish, or whatever fits — are written when the conversation needs them, linked to what they build on, and tagged `ai-generated`.
- Quizzes are graded multiple-choice through the Claude Code question popup, logged to `Probes.md`. Notation-heavy questions are written into `Probes.md` first, because the chat doesn't render LaTeX; notes do.

See [docs/vault-structure.md](docs/vault-structure.md) for the full picture.

## Install

From the repo root:

```bash
mkdir -p ~/.claude/skills
ln -sfn "$PWD/skills/teach" ~/.claude/skills/teach
ln -sfn "$PWD/skills/visualize" ~/.claude/skills/visualize
```

Skills are then available in every new Claude Code session. For a fresh vault, copy the contents of `vault/` into it to get the `CLAUDE.md` files and templates.

## Requirements

- [Claude Code](https://claude.com/claude-code) — desktop app or CLI
- [Obsidian](https://obsidian.md) with the Dataview plugin (topic indexes list their notes with it)
- `rsvg-convert` for checking SVG visuals (`brew install librsvg`)

## Keeping it in sync

- **Skills** are edited here. Through the symlinks, changes apply to new sessions immediately.
- **`CLAUDE.md` files and templates** are edited in the vault. Run `scripts/sync-from-vault.sh`, then commit.
- **Structure changes** (new folders, conventions) go into `docs/vault-structure.md`.
