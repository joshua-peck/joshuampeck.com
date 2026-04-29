# TODO

## P0 — Blocking 30-day revenue (this week)

- [ ] Rewrite dashboard validation disclosure
  - Replace "failed formal validation criteria" language
  - New criterion: 20% drawdown OR 2+ months sustained
  - Re-run validation against new criterion
- [ ] Strip all SHAP claims from dashboard, methodology page, stage gates doc
  - Replace with "PCA-based feature decomposition + emission distribution analysis"
- [ ] Set up paid newsletter (Substack or beehiiv)
  - $10/mo or $100/yr, founding member $200/yr first 100
  - Write launch post explaining scope and what MacroContext is/isn't
  - Send to Shrewd Investor list

## P1 — Methodology integrity (next 2 weeks)

- [ ] Write dossier methodology section
  - HMM specification
  - PCA feature engineering and loadings
  - Validation criterion + rationale
  - Explainability stack (4 methods, what each does/doesn't tell you)
- [ ] Build emission distribution panels (primary explainability surface)
- [ ] Build basic posterior decomposition for daily commentary

## P2 — Pro launch prep (weeks 3-6)

- [ ] Define final tier structure
  - Individual $99: regime probs, emission panels, top posterior contributors, transition alerts, monthly deep-dive, asset-class performance
  - Institutional $999: + Viterbi analysis, sensitivity tooling, component time series, PCA loadings, API (when built), quarterly call
  - Skip Professional middle tier at launch
- [ ] Build Viterbi transition analysis
- [ ] Build sensitivity/what-if tool
- [ ] Decide API timeline (gates whether Institutional ships with promise debt)

## P3 — Paper (parallel track, target 6-8 weeks)

- [ ] Reframe paper around scope-corrected validation finding
- [ ] Section 3: rewrite as "Why HMM, Why PCA-based Structural Attribution"
- [ ] Generate exhibits from notebook (matplotlib → PDF)
- [ ] Ship as paid one-off at $99-249 when complete

## Discipline rules going forward

- [ ] Every public claim traces to a documented decision in the dossier
- [ ] No "SHAP-like" or hedged explainability language — use real method names
- [ ] Dossier updates first, derivative content (dashboard, paper, newsletter, LinkedIn) updates from it


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

## High Priority (before any press or launch announcement)

- [ ] **Principles section** — replace creed with broader personal principles
      (copy TBD — finish principles discussion before building)

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
