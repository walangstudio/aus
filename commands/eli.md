---
description: "Explain like I'm a given age or audience. /eli 5, /eli 10, /eli grandma."
argument-hint: "[age or audience] [text]"
---

Use the `plain-speak` skill's ELI modes.

Read the first token of the input as the audience, and explain everything after
it for that audience:

- a number picks the closest age mode: `5` to ELI5, `10` to ELI10, teens to
  ELI-teen, anything adult to ELI-adult (non-tech)
- a word like `grandma`, `grandpa`, `mom`, or `nan` picks ELI-grandparent

Phrase the explanation inside that audience's everyday world, keep it accurate,
and never talk down to anyone.

$ARGUMENTS
