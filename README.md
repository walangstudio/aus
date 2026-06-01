# Artificial Unintelligence Skills

**AUS** — say it out loud. "Ayos." *Sorted. All good. Nailed it.* That's the
whole pitch: you ask, Claude answers like an actual person, and you go "ah,
ayos."

> Claude, but it explains things like a normal human instead of a whitepaper.

Most AI, asked to explain a sandwich, opens with the history of bread. This
doesn't. **Artificial Unintelligence** is a Claude skill that takes whatever
just fried your brain — a lease clause, a doctor's note, an error message, a
coworker's Slack that's three paragraphs and zero information — and says it
again the way a friend would.

The "unintelligence" is the bit. Claude isn't getting dumber. It's just
refusing to show off. Big difference.

## What's in here

Right now, one skill: **`plain-speak`**.

It re-explains things in plain language, tuned to *who's actually listening*.
A five-year-old and your CFO both deserve to understand the thing — they just
need different versions. You don't pick the version; you talk normally and the
skill figures it out. Say "tl;dr" and you get the gist. Say "explain it for my
mom" and it drops the jargon. Say "wait, what?" and it backs up and un-confuses
the exact sentence that lost you.

(One house rule: the audience is *people outside the jargon*, never "dumb"
people. Nobody gets talked down to. The only one playing dumb here is the AI,
and it's doing it on purpose.)

More skills may move in later. The repo's built to hold a collection.

## The modes

You rarely need to name these — just talk. But here's the menu:

**Explain it for a human of a certain age**

| Mode | Speaks in terms of |
|------|--------------------|
| ELI5 | toys, snacks, animals, very short sentences |
| ELI10 | video games, school, sports |
| ELI-teen | group chats, money, real stakes |
| **ELI-adult (non-tech)** | everyday work and money, zero jargon — *the default* |
| ELI-grandparent | mail, phone calls, TV, and all the patience in the world |

**Make it shorter, or make it click**

- **TL;DR** — the whole thing in one to three sentences.
- **Wait, What** — you read a sentence and your brain slid right off it. This
  re-explains *that* sentence until it sticks. Not a recap, not necessarily
  shorter — just clear.
- **Bullet brief** — the key points, scannable, no wall of text.

**Show off (a little)**

- **Analogy-only** — one good comparison, carried all the way home.
- **So-what** — leads with why you should care, then the details.
- **Unjargon** — keeps the *one* term worth knowing, defines it, evicts the rest.

## Install

Clone it and run the installer:

```bash
git clone https://github.com/walangstudio/aus.git
cd aus
./install.sh
```

That drops the skill into `~/.claude/skills/`. Options:

```bash
./install.sh              # just for you (~/.claude/skills)
./install.sh --project    # into the current project (./.claude/skills)
./install.sh --dir PATH   # wherever you want it
```

Prefer to do it by hand? Copy the `plain-speak/` folder into your skills
directory (`~/.claude/skills/plain-speak/`). Keep the `SKILL.md` frontmatter
intact — the `name` has to match the folder.

Either way: start a fresh Claude session and just ask for something in plain
English. The skill wakes up on its own.

## Try it

- "Explain this insurance clause in plain English."
- "ELI5: what's a blockchain?"
- "'The funds are held in escrow pending closing.' wait, what?"
- "TL;DR this contract."
- "Explain two-factor authentication for my grandma."

## License

[MIT](LICENSE) © walangstudio. Take it, use it, ayos.
