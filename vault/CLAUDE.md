---
id: CLAUDE
aliases: []
tags:
  - ai-generated
  - claude-config
---

# Year 3 vault — instructions for Claude

This is Lukas's Year 3 (Imperial College London) Obsidian vault, synced through OneDrive. Sessions are usually opened inside one class folder, whose own `CLAUDE.md` adds overrides on top of this file. Lukas reads notes in Obsidian with the chat open beside it. How to teach lives in the `teach` skill; this file says where things go.

## Layout

```
Year 3/
  CLAUDE.md                     ← this file (vault-wide rules)
  Misc/Templates/               ← Topic Index, Note, Probes
  Misc/Obsidian Attachements/   ← images/SVGs you create (spelling matches the real folder)
  Past Exams/
  <Class>/
    CLAUDE.md                   ← class overrides only
    Index.md                    ← Lukas's own class index — don't restructure it
    Files/                      ← lectures, tutorials, coursework, code: source material
    Notes/                      ← Lukas's own notes
      Learning/
        <Topic>/                ← one folder per larger subtopic, e.g. "Fourier Analysis"
          <Topic>.md            ← topic index
          Parseval's theorem.md ← notes, named for what they are
          Parseval — energy of a square wave.md
          Probes.md             ← quiz/probe log
```

Classes: Aerodynamics 3, Aerospace Vehicle Design, Control Systems, Group Design Project, High Performance Computing, Mathematics 3, Structures 3, Advanced Creative Writing.

## What you may write

- Create and edit freely inside `Notes/Learning/` and `Misc/Obsidian Attachements/`.
- The rest of `Notes/` is Lukas's: read it for context, edit only when asked.
- Never modify `Files/`, `Past Exams/`, or `.obsidian/`.

## Notes

Teaching happens in chat. Notes are written **when they're needed during the conversation** — not planned upfront, not one per session. Shape each note to its content; there is no required structure.

Notes loosely fall into a few kinds. These are labels to help organise, not schemas to fill in:

- **concept** — introduces a thing: a theorem, definition, method, or idea. Often short — *Parseval's theorem* might be just the statement and a paragraph on why it holds.
- **problem** — works through a problem (or a few) and links to what it uses.
- **anything else** worth keeping — a comparison, a derivation, a common mistake, an overview. Label it `note`, or with a word that fits better.

The line between kinds is blurry and that's fine: a concept note can contain a worked example; a problem note can end up introducing an idea.

Pieces that often help — use one only when it earns its place, never to fill a slot: a plain one-line summary at the top; the statement in LaTeX; why it's true or how you'd discover it; links to what it builds on and what uses it; a folded check-yourself question; a `## Questions` section once Lukas asks follow-ups. A two-line note is fine. So is a note that later gets split into several.

Rules that do apply to every note:

- Name notes for what they are. No numbering.
- Search the whole vault before creating a note. If it already exists — in any class — link to it or extend it; never duplicate. There is no shared concepts folder: a note lives in the topic where it first came up.
- Link it to whatever it builds on or relates to, when such notes exist.
- Small follow-ups go into an existing note rather than a new one.
- Notes must stand alone — Lukas may open a fresh chat on one later. No "as discussed above".

## Frontmatter

Every markdown file you create gets frontmatter. `tags` and `kind` are always present; the rest only when they apply.

```yaml
---
id: <filename without .md>
aliases: []
tags:
  - ai-generated
kind: concept | problem | note | …   # loose label; topic-index and probe-log are reserved
class: <class folder name>
topic: <topic folder name>
status: learning | shaky | solid     # only on notes Lukas is learning and being quizzed on
created: YYYY-MM-DD
---
```

`status` follows quiz evidence, not how recently something was covered. The topic index lists notes through a Dataview query on these fields.

## Maths: chat vs notes

The chat doesn't render LaTeX reliably; Obsidian does.

- **In chat:** prose, with at most simple Unicode (x², ∂f/∂t, ω, ∫, ≤). Never `$…$`.
- Anything needing real notation goes into a note, and the chat points to it: "the derivation is in [[Parseval's theorem]] under *Why energy is conserved*".
- **In notes:** always LaTeX — `$…$` inline, `$$` on their own lines for display.

## Quizzes

- Graded questions use the AskUserQuestion popup; the `teach` skill covers how to write and grade them.
- If a question or its options need real notation, write it with options A–D into `Probes.md` first (no answer), and make the popup options just A–D.
- The popup's "Other" box is Lukas's escape hatch: `idk` means a genuine gap, not a wrong guess; any other text is a note to act on.
- Every graded result is logged in `Probes.md`.
- Self-test questions inside notes go in folded callouts:

  ```
  > [!question]- Question text
  > Answer, and why.
  ```

## Sessions

- **Start:** read the topic index (`<Topic>.md`) first. New topic → create its folder, index, and `Probes.md` from the templates.
- **End** (or whenever Lukas says they're stopping): update the index's *Current level* and *Last session*; if the plan moved, update *Plan* and add a line to *Plan changes*. Update `status` values.

## Formatting (Obsidian)

- Link notes with wikilinks (`[[Parseval's theorem]]`, `[[Parseval's theorem#Statement]]`); embed images with `![[file.svg|500]]`.
- Structural diagrams: ` ```mermaid ` blocks (render natively). Spatial/geometric figures: SVG in `Misc/Obsidian Attachements/` — see the `visualize` skill.
- Callouts (`> [!abstract]`, `> [!warning]`, `> [!question]-`) for structure, not decoration.

## Sources and accuracy

- `Files/` is the primary source: match its notation, sign conventions, and scope, and name the file when a note leans on it.
- Unsure of any fact, formula, or definition? Check it (`Files/` first, then web search) before teaching it. If a check contradicts something already taught, say so plainly and fix the note.
- `Past Exams/` shows what is actually assessed — use it to prioritise. It sits outside class folders, so it may need adding as an extra directory in a class session.
