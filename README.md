# Artificial Unintelligence Skills

aus! (read as "ayos", Filipino for *all good, sorted*). AI dials its own
intelligence down to explain things like a normal person instead of a whitepaper.

Most models, asked to explain a sandwich, start with the invention of bread. This
does the opposite. Hand it the thing that just broke your brain (a lease clause, a
doctor's note, an error message) and it says the thing back the way a friend
would. AI isn't getting dumber; it's just not showing off.

## What's inside

One skill: `plain-speak`. It re-explains text in plain language, tuned to who's
actually listening. You don't pick a mode. Talk normally and it figures out which
one you meant: "tl;dr" gets the gist, "explain it for my mom" drops the jargon,
"wait, what?" backs up and un-confuses the sentence that lost you.

The audience is always people *outside the jargon*, never "dumb" people. Nobody
gets talked down to. The repo is laid out to hold more skills later.

## The modes

You rarely need to name these. The full menu:

| Mode | Talks in terms of |
|------|-------------------|
| ELI5 | toys, snacks, animals, very short sentences |
| ELI10 | video games, school, sports |
| ELI-teen | group chats, money, real stakes |
| **ELI-adult (non-tech)** | everyday work and money, zero jargon. the default |
| ELI-grandparent | mail, phone calls, TV, and a lot of patience |
| TL;DR | the whole thing in one to three sentences |
| Wait, What | re-explains the one sentence that lost you. not a recap |
| Bullet brief | the key points, scannable, no wall of text |
| Analogy-only | one good comparison, carried all the way home |
| So-what | leads with why you should care, then the details |
| Unjargon | keeps the one term worth knowing, defines it, drops the rest |

## Shortcuts

The modes you reach for most get a slash command, so you don't have to phrase
anything:

| Command | What it does |
|---------|--------------|
| `/aus [text]` | plain English, zero jargon (the everyday one) |
| `/tldr [text]` | the gist in one to three sentences |
| `/eli <age> [text]` | explain like I'm that age. `/eli 5`, `/eli 10`, `/eli grandma` |
| `/huh [text]` | "wait, what?" re-explains the bit that lost you |

The text is optional. Leave it off and the command works on whatever AI just
said: bare `/tldr` summarizes the last reply, `/huh` un-confuses it. Pass text and
it works on that instead. Everything else still works by talking, or with
`/plain-speak`, the skill itself.

## Install

### Claude Code (CLI)

macOS / Linux / Git Bash:

```bash
git clone https://github.com/walangstudio/aus.git
cd aus
./install.sh
```

Windows (PowerShell):

```powershell
git clone https://github.com/walangstudio/aus.git
cd aus
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

`-ExecutionPolicy Bypass` is per-process; it lets this one run without changing
your machine's policy. Plain `.\install.ps1` works too if your policy already
allows local scripts (`RemoteSigned` or looser). On PowerShell 7+, swap
`powershell` for `pwsh`. Prefix any of the commands below the same way if they're
blocked.

That puts the skill in `~/.claude/skills/` and the slash commands in
`~/.claude/commands/`. Other targets:

```bash
./install.sh --project    # into this project's .claude folder
./install.sh --dir PATH   # into a .claude folder you choose
```

```powershell
.\install.ps1 -Project    # into this project's .claude folder
.\install.ps1 -Dir PATH   # into a .claude folder you choose
```

Then start a fresh Claude session and try `/aus`, `/tldr`, `/eli`, `/huh`, or just
ask for something in plain English.

### Claude Desktop app / claude.ai

The desktop and web apps have no drop-in folder. You upload a skill as a zip. Build
it:

```bash
./install.sh --desktop      # macOS / Linux
```

```powershell
.\install.ps1 -Desktop      # Windows
```

That writes `plain-speak.zip`. In the app, open **Settings > Customize > Skills**,
click **+ Create skill**, upload the zip, and toggle it on. The slash commands are
Claude Code only and won't appear in the desktop or web app; the skill itself works
in all three.

### By hand

Copy the `plain-speak/` folder into `~/.claude/skills/` and the contents of
`commands/` into `~/.claude/commands/`. Keep the `SKILL.md` frontmatter intact: the
`name` field has to match the folder.

## Update and uninstall

The installer records the version it wrote. Pull the latest and re-run it to
update; it tells you what it's doing and skips work that's already current.

```bash
git pull
./install.sh              # or .\install.ps1   — updates in place
./install.sh --status     # installed vs. latest on GitHub
./install.sh --uninstall  # remove the skill and commands
```

```powershell
.\install.ps1 -Status     # installed vs. latest on GitHub
.\install.ps1 -Uninstall  # remove the skill and commands
```

`--status` does a best-effort check against the published version, so you know
when an update is out without cloning. Desktop installs are managed in the app's
Skills list (toggle off or delete there); re-run `--desktop` to rebuild the zip.

## Try it

- "Explain this insurance clause in plain English."
- "ELI5: what is a blockchain?"
- "'The funds are held in escrow pending closing.' wait, what?"
- "TL;DR this contract."
- "Explain two-factor authentication for my grandma."

## License

MIT, walangstudio.
