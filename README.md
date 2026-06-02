# Artificial Unintelligence Skills

Say the acronym out loud. AUS. "Ayos." It's Filipino for *sorted, all good,
nailed it.* That's the whole point. You ask, Claude answers like a person, and
you go "ah, ayos."

> Claude, but it explains things like a normal human instead of a whitepaper.

Here's the problem with most AI: ask it to explain a sandwich and it starts
with the invention of bread. Artificial Unintelligence does the opposite. You
hand it the thing that just broke your brain (a lease clause, a doctor's note,
an error message, a coworker's Slack that's three paragraphs and zero
information) and it says the thing again, the way a friend would.

The "unintelligence" bit is the joke. Claude isn't getting dumber. It's just
not showing off for once.

## What's inside

One skill so far: `plain-speak`.

It re-explains things in plain language, tuned to whoever is actually
listening. A five-year-old and your CFO both deserve to understand the thing.
They just need different versions of it. You don't pick the version. You talk
normally and the skill figures out which one you meant. Say "tl;dr" and you get
the gist. Say "explain it for my mom" and the jargon disappears. Say "wait,
what?" and it backs up and un-confuses the exact sentence that lost you.

One house rule: the audience is people *outside the jargon*, never "dumb"
people. Nobody gets talked down to. The only one playing dumb here is the AI,
and it does it on purpose.

More skills might move in later. The repo is set up to hold a whole collection.

## The modes

You almost never need to name these. Just talk. But here is the full menu.

| Mode | Talks in terms of |
|------|-------------------|
| ELI5 | toys, snacks, animals, very short sentences |
| ELI10 | video games, school, sports |
| ELI-teen | group chats, money, real stakes |
| **ELI-adult (non-tech)** | everyday work and money, zero jargon. this is the default |
| ELI-grandparent | mail, phone calls, TV, and all the patience in the world |
| TL;DR | the whole thing in one to three sentences |
| Wait, What | re-explains the one sentence that lost you, for as long as that takes. not a recap |
| Bullet brief | the key points, scannable, no wall of text |
| Analogy-only | one good comparison, carried all the way home |
| So-what | leads with why you should care, then the details |
| Unjargon | keeps the one term worth knowing, defines it, evicts the rest |

## Shortcuts

The modes all work by just talking. But the ones you reach for most get a short
slash command, so you don't have to phrase anything:

| Command | What it does |
|---------|--------------|
| `/aus [text]` | explain it like a human, plain English, zero jargon (the everyday one) |
| `/tldr [text]` | the gist in one to three sentences |
| `/eli <age> [text]` | explain like I'm that age. `/eli 5`, `/eli 10`, `/eli grandma` |
| `/huh [text]` | "wait, what?" re-explains the bit that lost you |

The text is optional. Leave it off and the command works on whatever Claude just
said, so a bare `/tldr` summarizes the last reply and `/huh` un-confuses it. Pass
text and it works on that instead.

Everything else still works by talking normally, or with `/plain-speak`, which
is the skill itself.

## Install

The quick way:

```bash
git clone https://github.com/walangstudio/aus.git
cd aus
./install.sh
```

That puts the skill in `~/.claude/skills/` and the slash commands in
`~/.claude/commands/`. Other options:

```bash
./install.sh --project   # into this project's .claude folder
./install.sh --dir PATH  # into a .claude folder you choose
```

Rather do it by hand? Copy the `plain-speak/` folder into `~/.claude/skills/`
and the contents of `commands/` into `~/.claude/commands/`. Just keep the
`SKILL.md` frontmatter intact, since the `name` field has to match the folder.

Then start a fresh Claude session. Type `/aus` (or `/tldr`, `/eli`, `/huh`), or
just ask for something in plain English and the skill shows up on its own.

## Try it

- "Explain this insurance clause in plain English."
- "ELI5: what is a blockchain?"
- "'The funds are held in escrow pending closing.' wait, what?"
- "TL;DR this contract."
- "Explain two-factor authentication for my grandma."

## License

MIT, walangstudio. Take it, use it, ayos.
