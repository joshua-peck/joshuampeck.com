# TODO

## INDEX REWRITE - AUTHORITY SITE
03  PRINCIPLES   — update principles to be more all-encompassing personal statement of principles
05  CREDIBILITY  — media bar needs logos
07  RESEARCH     — update after research is published
09  FOOTER       — unchanged

## CODING
- [ ] lab/ page
- [ ] research/ page
- [ ] newsletter/ page
- [ ] media/ page
- [ ] lab/regime-detection
- [ ] open-source/
- [ ] book/
- [ ] contact/

## WRITING
- [ ] Write essays for each item on the creed

## DESIGN
- [ ] what is the UX to best represent the info being displayed by the regime tool?

## SETUP
- [ ] Set up the applied complexity newsletter to contain updates from the tool
- [ ] 



- [ ] **Track record page** (`/track-record/`)
      Dated log of every public regime call starting April 2026.
      Timestamp, regime called, key signals cited, outcome.
      This page loses permanent value for every week it doesn't exist.

- [ ] **Populate research archive**
      Minimum 10 posts before the archive reads as an archive.
      Currently 2 placeholder posts. Write 8 more.
      Prioritize: methodology explainers, the 2024 misclassification,
      the rate-of-change vs level decision, the PCA preprocessing rationale.

- [ ] **Write the intellectual biography** (`/about/`)
      Not a CV. The narrative: what questions in 2015 led to the book,
      what the book revealed that led to MacroContext, what's still open.
      Add professional headshot (only appears here).


## High Priority (before any press or launch announcement)

- [ ] **Homepage re-architecture**
      Shift from product-optimized to person-first.
      Implement agreed section order:
      Hero → Creed/Principles → The Work → Credibility Bar →
      Regime Signal (stripped of product framing) → Research Archive →
      About (condensed) → Footer

- [ ] **Hero copy** — implement chosen option from copy review session

- [ ] **Principles section** — replace creed with broader personal principles
      (copy TBD — finish principles discussion before building)

- [ ] **"The Work" section** — three cards, implement per spec
      MacroContext / Newsletter / Book
      Section title: "Research, tools, and writing — all the same question."

- [ ] **Regime signal — reframe for authority site**
      Strip product CTAs. Keep: current regime, date, one plain-English sentence,
      link to methodology. No signal tags as feature bullets.
      No "Understand the model →" CTA.

- [ ] **Canonical methodology document** (`/lab/regime-detection/methodology/`)
      Permanent URL. Versioned. Treated as a living document.
      Source content exists in the MacroContext brief — needs formatting and publishing.


## Medium Priority (before first roundtable / seeder conversations)

- [ ] **Media page with actual clips** (`/media/`)
      Replace logo grid with real clips — embedded or linked segments,
      pull quotes, outlet, date. CBS, WSJ, Reuters, MarketWatch, Bloomberg.

- [ ] **Post-mortem posts** (research archive)
      2025 tariff stress miss: what the model called, what happened,
      what it revealed about the fast-shock gap, what changed.
      2026 Iran war: same treatment.
      These are the strongest authority signals available.

- [ ] **Section numbering** — add 01/02/03 etc. to all homepage sections
      Per the concept review — gives the page deliberate editorial architecture.

- [ ] **Book page** (`/book/`)
      Full treatment: cover image, Amazon link, publisher, audience,
      one paragraph connecting it to the current intellectual project.

- [ ] **Newsletter landing page** (`/newsletter/`)
      Full SCR copy per copywriting skill.
      Beehiiv embed. Three items (what you'll receive). Recent issues. Author bio.




## Lower Priority (before fund launch / public intellectual phase)

- [ ] **Reading list / influences page** (`/reading/` or section on `/about/`)
      Hamilton (1989) and the HMM literature.
      Complexity science canon.
      Books and thinkers that shaped the framework.

- [ ] **Open source page** (`/open-source/`)
      Any public repos, datasets, or tools.
      Signals intellectual generosity and technical credibility.

- [ ] **Lab index page** (`/lab/`)
      Grid of research projects with status badges.
      MacroContext is the first card. Future projects get added here.

- [ ] **MacroContext product page copy** (`/lab/regime-detection/`)
      Full methodology treatment. The three regimes. Feature set table.
      Validated performance. Known limitations (publish these honestly).
      "Who It's For" panel. Waitlist CTA.


## Content / Copy (ongoing)

- [ ] Finalize principles section copy (in progress)
- [ ] Write real research posts — target 2 per month minimum
- [ ] Publish weekly regime call every Monday — feeds track record page
      and research archive simultaneously
- [ ] Write post-mortem immediately after any model miss or regime revision
- [ ] Update `data/regime.yaml` every Monday with current call

---

## Technical (Hugo / Tailwind)

- [ ] Wire newsletter form to Beehiiv embed URL
- [ ] Implement creed/principles section in `layouts/index.html`
- [ ] Implement "The Work" section per spec
- [ ] Add section numbering to homepage eyebrows
- [ ] Set up Google Analytics or Plausible
- [ ] Add `data/track-record.yaml` schema and template for track record page
