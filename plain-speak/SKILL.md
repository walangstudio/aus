---
name: plain-speak
description: >-
  Re-explain any text, concept, message, error, or document in plain language
  tuned to the listener. Trigger this WHENEVER the user wants something made
  easier to understand, even if they don't name a mode. Fires on: "explain this
  simply", "in plain English", "in layman's terms", "no jargon", "non-technical",
  "eli5", "explain like I'm 5/10", "explain it for my mom", "for my grandma",
  "tl;dr", "summarize this", "give me the gist", "recap this", "dumb it down",
  "what does this mean", "break it down", "wait, what?", "huh?", "I don't get it",
  "I'm lost", "come again", "can you simplify", "make it simple", "bullet points",
  "key points", "give me an analogy", "why should I care", "what's the point".
  Use it for jargon-heavy passages, legalese, medical or financial text, code,
  errors, and dense paragraphs the reader just bounced off of. Default to
  ELI-adult (non-tech) when no mode is stated.
---

# Plain Speak

Re-explain anything so a non-expert can actually get it — tuned to who's
listening. The audience is **people outside the jargon**, never "stupid" or
"unintelligent" people. The bit is that *you* (the AI) are dialing your own
intelligence down to communicate like a normal human. You are playing dumb on
purpose; the reader is not dumb.

## How to pick a mode

Read the user's phrasing and pick the closest mode below. **If no mode is
stated, default to ELI-adult (non-tech).** When the user names an audience
("for my grandma", "for a 10-year-old"), match that audience even if they
didn't use the exact mode name. When they signal confusion mid-read ("wait
what", "I don't get it"), use **Wait, What**.

Each mode lists a tone rule, why that tone fits its audience, and a short
input→output example. The examples show the *shape* of a good answer — adapt
them, don't copy them.

---

## Age-relatable modes

Phrase the explanation inside the listener's everyday world.

### ELI5
- **Tone:** Very short sentences. Compare to toys, animals, snacks, bedtime.
  No numbers unless tiny. Warm and playful.
- **Why it fits:** A five-year-old reasons through concrete, familiar things
  they can touch and see, so anchor every idea to one of those.
- **Example**
  - In: "Explain a server for my 5-year-old."
  - Out: "A server is like a big helper in another room. You ask it for a
    cartoon, it goes and gets it, and brings it right to your screen. It can
    help lots of kids at the same time."

### ELI10
- **Tone:** Short, energetic. Compare to video games, school, sports, group
  chats. A little detail is okay.
- **Why it fits:** A ten-year-old already handles rules, levels, and teams, so
  borrow those systems to carry the idea.
- **Example**
  - In: "ELI10: what's a password manager?"
  - Out: "It's like a notebook that remembers every secret code for all your
    games and accounts, and it locks itself with one master code only you
    know. So you only memorize one, not fifty."

### ELI-teen
- **Tone:** Direct, a bit dry. Use social media, money/allowance, and
  real-world stakes (time, reputation, getting locked out).
- **Why it fits:** Teens respond to consequences and independence, so frame it
  around what they gain or lose, not abstract theory.
- **Example**
  - In: "Explain interest on a loan to a teenager."
  - Out: "Borrow $100 and the lender charges you for the privilege — say $10 a
    year. Wait a year to pay back and you owe $110. Wait longer and it keeps
    growing. Borrowing isn't free; the clock is charging you."

### ELI-adult (non-tech) — DEFAULT
- **Tone:** Plain, respectful, zero jargon. Use everyday work, money, and
  household analogies. This is the fallback when no mode is named.
- **Why it fits:** A capable adult outside the field doesn't need
  simplification of their intelligence — just the jargon removed and one
  familiar comparison to hang the idea on.
- **Example**
  - In: "What's an API, in plain English?"
  - Out: "An API is like a restaurant menu. You don't go into the kitchen —
    you pick from a set list of things you can order, and the kitchen handles
    the rest. Software uses APIs to ask other software for specific things
    without needing to know how they're made."

### ELI-grandparent
- **Tone:** Patient pacing, one idea per sentence. Use mail, phone calls, TV,
  the bank teller. Spell out every acronym; never assume a tech term.
- **Why it fits:** The barrier is rarely ability — it's unfamiliar vocabulary
  and speed, so slow down and translate every term into something long
  trusted.
- **Example**
  - In: "Explain the cloud for my grandma."
  - Out: "'The cloud' just means your photos are kept safe in a company's
    building far away, not only on your phone. It's like keeping copies of
    your letters in a bank's safe deposit box. If you lose your phone, the
    copies are still there, and you can ask for them anytime."

---

## Summarize / clarify modes

### TL;DR
- **Tone:** The gist in 1–3 sentences. Lead with the single most important
  point. No preamble.
- **Why it fits:** The reader wants the conclusion now and will ask if they
  want more, so give them the takeaway, not the runway.
- **Example**
  - In: "TL;DR this 4-paragraph release note about a breaking change."
  - Out: "Version 3 removes the old login method, so apps still using it will
    break. Update to the new token-based login before you upgrade."

### Wait, What
- **Tone:** The reader just read a specific passage and didn't follow it.
  Re-explain *that same thing* in plain language. Do **not** assume they want
  it shorter — clarity wins, take as many words as it takes. This is distinct
  from a conversation recap: you're un-confusing one passage, not summarizing a
  chat.
- **Why it fits:** Confusion comes from a gap, not from length, so fill the
  gap — define the word, unpack the sentence, or walk the step they tripped on.
- **Triggers:** "wait what", "I don't get it", "huh?", "come again", "what did
  that mean".
- **Example**
  - In: "'We amortize the cost over the asset's useful life.' wait what?"
  - Out: "It means: instead of recording the whole cost in the year you buy
    something, you spread it across the years you'll actually use it. Pay
    $5,000 for a five-year software license, and you count $1,000 as a cost
    each year instead of $5,000 up front. 'Amortize' is just the word for
    spreading a cost out over time."

### Bullet brief
- **Tone:** Scannable key points. Each bullet is one self-contained idea, front-
  loaded with the keyword. No long sentences.
- **Why it fits:** A reader skimming for structure needs to find any point
  without reading the whole thing, so make each line stand on its own.
- **Example**
  - In: "Bullet brief: what changed in this policy update?"
  - Out:
    - "Returns: window shortened from 60 to 30 days."
    - "Refunds: now issued to store credit, not the original card."
    - "Exceptions: defective items still get a full cash refund."

---

## Flavor modes

### Analogy-only
- **Tone:** Explain purely through one strong, sustained comparison. Pick a
  single analogy and carry it all the way through — don't switch metaphors.
- **Why it fits:** One comparison the reader already understands does the
  teaching; mixing several just adds new things to learn.
- **Example**
  - In: "Explain a firewall using only an analogy."
  - Out: "A firewall is a bouncer at a club door. It has a guest list of who
    and what is allowed in. Anything not on the list gets turned away at the
    door, before it ever reaches the party inside."

### So-what
- **Tone:** Lead with why it matters *to this reader* — the consequence,
  benefit, or risk — then explain just enough mechanism to back it up.
- **Why it fits:** People act on impact, not mechanism, so answer "why should I
  care" first and the details land better.
- **Example**
  - In: "So-what: they're deprecating the v1 API next quarter."
  - Out: "What it means for you: anything you've built on the old API stops
    working next quarter, so you'll need to budget engineering time now to move
    to v2 — or your integration goes dark."

### Unjargon
- **Tone:** Keep the one essential technical term the reader genuinely needs,
  define it cleanly, and strip every other piece of jargon out.
- **Why it fits:** Sometimes one real term is worth learning; burying it under
  ten others is what loses people, so keep the keystone and clear the rest.
- **Example**
  - In: "Unjargon: 'The endpoint returns a paginated JSON payload over HTTPS.'"
  - Out: "The web address sends back its answer in pages — a chunk at a time
    instead of all at once — so you request the next page when you need more.
    ('Paginated' is the one term to keep: it just means the results are split
    into pages.)"

---

## Cross-cutting rules

Apply these in every mode:

- **Default to what was just said.** If the skill is invoked with no text to
  work on, the target is the most recent assistant reply (or the passage the
  user just pasted). They are asking you to redo that, not waiting to hand you
  more. Do not ask "what would you like me to explain"; explain the last thing.
- **Never insult or condescend to the reader.** The reader is smart and busy or
  simply new to the topic. The humor is the AI playing dumb on purpose — never
  at the reader's expense.
- **Preserve accuracy.** Simpler must not mean wrong. Don't drop critical
  caveats, warnings, numbers, or conditions just to smooth the explanation. If
  a simplification would mislead, keep the caveat.
- **Match length to the mode.** ELI5 stays short; Bullet brief stays scannable;
  TL;DR stays to 1–3 sentences; Wait, What runs as long as it needs to actually
  clear up the confusion.
- **Translate, don't omit.** Replace jargon with plain words or analogies
  rather than skipping the hard part — the hard part is usually the point.
- **Stay in the listener's world.** Choose analogies from the audience's daily
  life (a grandparent's mailbox, a teen's group chat, an adult's monthly
  bills).
