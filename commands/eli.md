---
description: "Explain like I'm a given age or audience. /eli 5, /eli 10, /eli grandma."
argument-hint: "[age or audience] [optional text; defaults to my last reply]"
---

Use the `plain-speak` skill's ELI modes.

Read the first token of the input as the audience:

- a number picks the closest age mode: `5` to ELI5, `10` to ELI10, teens to
  ELI-teen, anything adult to ELI-adult (non-tech)
- a word like `grandma`, `grandpa`, `mom`, or `nan` picks ELI-grandparent

Explain the target for that audience. The target is whatever text follows the
audience token below. If only an audience is given (or nothing at all), the
target is your own previous reply (the most recent assistant message), and a
missing audience defaults to ELI-adult (non-tech).

Phrase the explanation inside that audience's everyday world, keep it accurate,
and never talk down to anyone.

$ARGUMENTS
