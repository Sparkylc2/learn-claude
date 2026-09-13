---
name: visualize
description: Add a correct, minimal visual to a note in the Year 3 Obsidian vault — a mermaid diagram for structure (dependency graphs, flows, block diagrams, state machines, trees) or a hand-built SVG for anything spatial or quantitative (geometry, vectors, free-body diagrams, cross-sections, function plots, Bode plots). Use when an idea being taught is genuinely clearer as a picture. SVGs are rendered and looked at before they are embedded.
---

# Visualize

A picture earns its place only when it shows something words can't — shape, structure, direction, relationship, geometry. This skill produces ONE such picture, makes sure it is **correct**, and puts it into a note so it renders in Obsidian.

Visuals go into **notes**, never the chat — neither mermaid nor SVG renders in the chat. In chat, say what the picture shows and point to the note.

## When to visualize (and when not to)

The teaching builds a **dependency graph in Lukas's head** — unconditional truths at the root, derived facts hanging off them. A visual is powerful exactly when it makes that structure (or a geometry) visible. Reach for one when:

- The idea is a **structure or relationship**: dependencies, a system with parts and arrows, a flow/pipeline, a block diagram, a sequence of exchanges, a state machine, a tree/hierarchy, a containment (what's inside vs outside).
- The idea is **spatial or quantitative**: coordinate geometry, vectors, a free-body diagram, a cross-section, a function's shape, a frequency response, a physical arrangement.

Do NOT visualize when prose or a single equation already carries it. A decorative diagram that just restates the sentence next to it adds noise and a chance to be wrong. When in doubt, don't — a missing visual is cheaper than a false one.

## Choose the form

- **Mermaid** — *nodes and edges*: dependency graphs, flowcharts, block diagrams, sequence/state diagrams, trees, timelines. Obsidian renders it natively.
- **SVG** — *positions and shapes*: anything where coordinates, angles, proportions, or plotted values matter.

## Distill first: one idea, fewest elements

You are both the creative director and the maker, so write yourself the brief before drawing anything: the **one idea**, the **few elements** that carry it, and **what Lukas should conclude** from looking.

The most common failure is **cramming** — every extra label makes the picture harder to read AND harder to get right. For each element ask: *"if I delete this, is the idea still clear?"* If yes, delete it. More than ~5–7 elements means cut first.

- BAD brief: "a diagram about Fourier series"
- GOOD brief: "graph TD: 'periodic signal' at the top; arrows down to 'orthogonal basis' and 'inner product'; both into 'coefficients by projection'. Shows the coefficients come FROM orthogonality, not alongside it."

## Mermaid

- Write a ` ```mermaid ` block directly in the note, right under the sentence that introduces it.
- Pick the type that fits: `graph TD`/`LR`, `sequenceDiagram`, `stateDiagram-v2`, `timeline`, `mindmap`. Dependency maps are usually `graph TD` with foundations at the top.
- Short labels — a term, not a sentence. Quote labels containing punctuation: `A["f(z) analytic"]`. Use Unicode for math (ω, ∂, ², ≤); don't rely on LaTeX inside mermaid.
- Style it with the Kanagawa palette (see *Palette* below) by starting every diagram with this init line:
  ```
  %%{init: {"theme": "base", "themeVariables": {"background": "#181616", "primaryColor": "#282727", "primaryTextColor": "#c5c9c5", "primaryBorderColor": "#54546D", "lineColor": "#a6a69c", "secondaryColor": "#0d0c0c", "tertiaryColor": "#282727", "clusterBkg": "#0d0c0c", "clusterBorder": "#54546D", "edgeLabelBackground": "#181616", "fontFamily": "sans-serif"}}}%%
  ```
  To highlight the one node that carries the point, use a `classDef` with an accent border, e.g. `classDef key stroke:#8ba4b0,stroke-width:2px;` — one meaning per accent, never decoration.
- **Verify by reading the source edge by edge** against the brief: is every arrow pointing the right way, is every edge actually true, is every label right? There's no local renderer, so if the layout could plausibly go wrong (many crossings, more than ~7 nodes), simplify rather than hope.

## SVG

### Where

Save to `Year 3/Misc/Obsidian Attachements/viz-<short-kebab-topic>.svg`. Obsidian resolves embeds by filename across the whole vault, so check the name isn't already taken. Any helper script that generates the SVG goes in the scratchpad, never the vault.

### Style

Use the Kanagawa palette (see *Palette* below). Obsidian embeds SVGs as images, so they don't inherit theme colours: **always paint the `bg` background** as a `<rect>` filling the viewBox — a transparent SVG vanishes against the note, a painted one stays legible whatever the theme.

- Explicit `viewBox` plus `width`/`height`; leave margins so nothing touches the edge.
- `font-family="sans-serif"`, font size ≥ 14 at a ~600-wide viewBox; italic for variables.
- No LaTeX in SVG. Use Unicode (θ, ω, ∂, ², ∞), and `<tspan>` with a `dy` offset and smaller `font-size` for subscripts. Math that needs real notation goes in the note's caption, in LaTeX.

### Quantitative figures: compute, never eyeball

For plots and anything with real values, generate coordinates with a script — Python's standard library (`math`) is enough to sample a function and write the `<polyline>` points. Map data to pixels explicitly (remember SVG's y axis points down), and label ticks at real values. `matplotlib` isn't installed; if it ever is, `savefig(..., format="svg")` with the palette above is fine too — the same verification applies.

### Verify by looking — the rule that matters most

Rendering without errors only proves the SVG parsed. You are done only when you have **looked at the rendered picture and confirmed it is true to the brief**:

1. Render a preview into the scratchpad (not the vault):
   ```bash
   rsvg-convert -w 1200 "<vault>/Misc/Obsidian Attachements/viz-<slug>.svg" -o "<scratchpad>/viz-check.png"
   ```
2. **Read the PNG** and look critically:
   - Is every coordinate, angle, direction, sign, and proportion actually correct? Re-derive the geometry if unsure.
   - Are labels clear and not overlapping lines or each other?
   - Is anything clipped, cramped, or too small to read?
   - Would Lukas instantly read the intended idea from the picture alone?
3. Fix the SVG and re-render until correct and clean.

`rsvg-convert` is close to, not identical with, Obsidian's renderer — fonts can differ slightly, so leave slack around text. If you can't make a correct picture of the brief, don't embed a wrong one: drop the visual or rethink it, and say so.

## Palette — Kanagawa (dragon)

Every visual — mermaid and SVG — uses only these colours, matching Lukas's editor and vault theme.

| Name | Hex | Use |
| --- | --- | --- |
| `bg` | `#181616` | Background — painted behind every SVG; mermaid `background` |
| `bg_dark` | `#0d0c0c` | Recessed areas: clusters, insets |
| `bg_light` | `#282727` | Raised surfaces: node/box fills, shaded regions |
| `fg` | `#c5c9c5` | Main strokes, axes, primary text |
| `fg_dim` | `#a6a69c` | Secondary text, annotations, edges |
| `gray` | `#625e5a` | Grid lines, guides, construction lines |
| `border` | `#54546D` | Box and node borders |
| `white` | `#C8C093` | Titles or a warm contrast to `fg`, sparingly |
| `blue` | `#8ba4b0` | Accent — default primary series / highlighted element |
| `red` | `#c4746e` | Accent |
| `green` | `#8a9a7b` | Accent |
| `yellow` | `#c4b28a` | Accent |
| `magenta` | `#a292a3` | Accent |
| `cyan` | `#8ea4a2` | Accent |
| `orange` | `#b6927b` | Accent |
| `error` | `#e46876` | Brightened — the one thing that must jump out (a wrong path, a violated condition) |
| `warn` | `#dca561` | Brightened — caution, a boundary or limit |
| `info` | `#7fb4ca` | Brightened — key result or the point of the figure |
| `hint` / `ok` | `#9fc6a0` | Brightened — correct path, satisfied condition |

- Accents carry meaning, one meaning per colour within a figure (e.g. blue = input, orange = output). Use the muted accents by default; reserve the brightened ones for the single element the eye should land on.
- Multiple plotted series: `blue`, `orange`, `green`, `magenta`, `cyan` in that order.

## Embed

Introduce the visual in a sentence, then embed it with a width:

```
![[viz-<slug>.svg|500]]
```

`|500` is a good default; go larger for dense figures. Let the picture carry the idea — don't narrate every element back in prose. Mermaid needs no embed; it's already inline.
