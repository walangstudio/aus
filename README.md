# Artificial Unintelligence

> Claude, but it explains things like a normal human.

A collection of [Anthropic Agent Skills](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview).
The joke in the name: the AI deliberately *dials its own intelligence down* so
it can explain things plainly. The audience is people outside the jargon —
never "stupid" people. The AI is the one playing dumb on purpose.

## What it is

The first skill, **plain-speak**, re-explains any text, concept, message,
error, or document so a non-expert can understand it — tuned to who's
listening. Ask for "plain English," an "ELI5," a "tl;dr," or just say "wait,
what?" and the skill picks the right mode and rewrites the explanation for that
audience.

More skills may be added to this collection over time.

## Modes

`plain-speak` chooses a mode from how you phrase the request. If you don't name
one, it defaults to **ELI-adult (non-tech)**.

**Age-relatable** — explained inside the listener's everyday world:

- **ELI5** — toys, animals, snacks; very short sentences
- **ELI10** — video games, school, sports
- **ELI-teen** — social media, money, real-world stakes
- **ELI-adult (non-tech)** — everyday work/money analogies, zero jargon *(default)*
- **ELI-grandparent** — mail, phone calls, TV; patient pacing, no acronyms

**Summarize / clarify:**

- **TL;DR** — the gist in 1–3 sentences
- **Wait, What** — re-explains a confusing passage you just read, in plain
  language, taking as long as it needs (not the same as a conversation recap)
- **Bullet brief** — scannable key points

**Flavor:**

- **Analogy-only** — one strong comparison, carried all the way through
- **So-what** — leads with why it matters to you
- **Unjargon** — keeps one essential term, defines it, strips the rest

## Install / use

Agent Skills load from a skills directory. To use `plain-speak`:

1. Copy the `plain-speak/` folder into your skills directory (for example
   `~/.claude/skills/plain-speak/` for personal use, or your project's
   `.claude/skills/plain-speak/`).
2. Make sure `plain-speak/SKILL.md` keeps its frontmatter (`name` must match
   the folder name).
3. Start a session — the skill triggers automatically when you ask for a
   simpler explanation. No need to name a mode.

## Example prompts

- "Explain this insurance clause in plain English." *(→ ELI-adult, the default)*
- "ELI5: what is a blockchain?" *(→ ELI5)*
- "'The endpoint returns a paginated JSON payload.' wait, what?" *(→ Wait, What)*
- "TL;DR this contract for me." *(→ TL;DR)*
- "Explain the cloud for my grandma." *(→ ELI-grandparent)*

## License

[MIT](LICENSE) © walangstudio
