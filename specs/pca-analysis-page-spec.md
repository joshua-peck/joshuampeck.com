```markdown
# Page Spec: /lab/market-factors/
# Style: match /lab/regime-detection/ exactly

---

## SECTION 1 — Header
Background: navy, gold bottom border (same as regime-detection header)

- Eyebrow: "MacroContext · Lab · Factor Analysis"
- H1: "What is moving markets right now"
- Subtitle: "A rolling analysis of the dominant macro factors driving S&P 500
  variance. The factors that move markets change over time — sometimes
  gradually, sometimes abruptly. This page tracks those shifts."
- Meta row (mono, dimmed): 
  "Training windows: [meta.n_folds] · History: [meta.train_start]–[meta.train_end]
  · Variance target: [meta.variance_target] · Updated: [meta.run_date]"
  All values from data/pca/meta.json

---

## SECTION 2 — Current Factor Structure
Background: cream

- Eyebrow: "Current Factor Structure · [meta.train_end]"
- H2: "What drives equity markets today"
- Body: "The [n] principal components of the current training window,
  ordered by variance explained. Together they capture [pct]% of variance
  in the 16-indicator dataset."

- CHART: pca_scree.png (static matplotlib image)
  Caption: none — chart is self-labeling

- TABLE: Component interpretation table
  Source: data/pca/current_components.json
  Columns: Component | Variance % | Cumulative % | Economic label | Top features
  10 rows (PC1–PC10)
  PC1 row lightly highlighted

---

## SECTION 3 — Structural Transition
Background: white + dot grid

- Eyebrow: "Structural Transition · 2018–2019"
- H2: "The dominant risk signal changed character around 2018–2019"
- Body: "Before 2019, interest rate levels and credit spreads explained
  the most market variance. After 2019, equity momentum and trend took
  over. The crossover marks a shift in what markets fear most."

- TWO CARDS side by side:
  Card 1 — "Era 1 · Folds 1–22 · 1996–2017"
    Subhead: "PC1: The Rates & Credit Axis"
    Feature rows from data/pca/era1_pc1_features.json
    (feature name, direction, loading value per row)
    Italic note: "Credit spreads and Treasury yields dominate."

  Card 2 — "Era 2 · Folds 23–29 · 2019–2025"
    Subhead: "PC1: The Equity Stress Axis"
    Feature rows from data/pca/era2_pc1_features.json
    Italic note: "SPX trend and momentum dominate."

- CHART: pca_pc1_crossover.png (static matplotlib image)
  Caption (mono, small): "PC1 dominant loading across all 29 training windows,
  1996–2025. Gold = BAA10Y (credit spreads).
  Navy = SPX_200d_ma_spread (equity trend)."

- Body copy (3 paragraphs):
  1. Zero lower bound explanation — why rates lost variance
  2. 2018 Q4 selloff tipped the covariance structure
  3. Pull quote: "An investor using credit spread levels as the primary
     risk signal was correct in 2022. The same signal was uninformative
     in 2024's bull market. The dominant fear had changed."

---

## SECTION 4 — Historical Transition Timeline
Background: cream

- Eyebrow: "Factor Era Timeline · [meta.train_start]–[meta.train_end]"
- H2: "Stable within eras. Abrupt at transitions."
- Body: "Named periods where PC1 changed character materially,
  with economic context for each transition."

- CHART: pca_era_timeline.png (static matplotlib image)
  Caption: none

- TRANSITION CARDS (one per entry in data/pca/transitions.json):
  Each card:
    - Period label (gold eyebrow): e.g. "2018–2019"
    - Fold range badge (top right): "Folds 22–23"
    - Title: e.g. "Rates & credit axis → equity stress axis"
    - Description paragraph

---

## SECTION 5 — Sensitivity Analysis
Background: white + dot grid

- Eyebrow: "Factor Stability · Configuration Sensitivity"
- H2: "High disagreement between configurations signals genuine
  market ambiguity"
- Body: "Comparing PCA variance thresholds of 85% vs 90% across 5,119
  trading days. When two reasonable configurations disagree about what
  is driving markets, that disagreement is itself informative."

- THREE STAT BOXES (same pattern as regime-detection stat cards):
  Box 1: "Steady-state agreement" / 79.4% / ">5 days from any transition"
  Box 2: "Near-transition agreement" / 51.2% / "Within ±5 days of a transition"
  Box 3: "Most stable year" / 2022 / "100% agreement — unambiguous Danger"
  All values hardcoded — not from data file

- CHART: pca_sensitivity_by_year.png (static matplotlib image)
  Caption (mono, small): "Green = factor structure unambiguous (<15%).
  Yellow = moderate. Red = genuinely uncertain (>40%).
  PCA=0.85 vs PCA=0.90, 5,119 trading days."

- Body copy (2 paragraphs):
  1. 2022: 100% agreement — rate-hiking bear market, unambiguous structure
  2. 2020: 21% agreement — COVID disrupted covariance, disagreement was correct

---

## SECTION 6 — Research CTA
Background: navy (same as regime-detection CTA strip)

- Left column:
  Title: "What Markets Fear"
  Body: "The academic paper develops the full argument: how the principal
  dimensions of macro stress have shifted since 1996, why they shift, and
  what that means for systematic risk detection."

- Right column, two buttons:
  Primary (gold): "Follow the research →" → /newsletter/
  Secondary (outline): "View regime detection →" → /lab/regime-detection/

---

## SECTION 7 — Disclosures
Background: cream, top border

- Eyebrow: "Important disclosures"
- Three short mono paragraphs:
  1. Informational purposes only, not investment advice
  2. Factor analysis based on historical data, past structure
     does not indicate future structure
  3. AppliedComplexity makes no representations, for informational
     use only

---

## DATA FILES

All in data/pca/. Hugo template reads via .Site.Data.pca.*

data/pca/meta.json
  Fields: n_folds, train_start, train_end, variance_target,
          run_date, n_components_current, variance_explained_current

data/pca/current_components.json
  Array of 10 objects
  Fields per object: pc_label, variance_pct, cumulative_pct,
                     economic_label, top_features_display

data/pca/era1_pc1_features.json
  Array of 5 objects (Era 1 representative fold)
  Fields: feature, direction, loading

data/pca/era2_pc1_features.json
  Array of 5 objects (most recent fold)
  Fields: feature, direction, loading

data/pca/transitions.json
  Array of transition event objects
  Fields: period, fold_range, title, description

data/pca/sensitivity_by_year.json
  Array of year objects
  Fields: year, disagreement_pct
  Pre-populated from drift diagnostic (2006–2026, values in spec above)

data/pca/pc1_loading_history.json
  Array of fold objects (for crossover chart generation)
  Fields: fold, train_end_year, baa10y_loading, spx_200d_loading
  To be generated by notebook

---

## CHART FILES

Place at assets/figures/. Hugo processes via .Resize "1200x q90 webp".
Show placeholder div with filename hint when file absent.

pca_scree.png              Already generated — copy from uploads
pca_pc1_crossover.png      New — generated from pc1_loading_history.json
pca_era_timeline.png       New — generated from pc1_loading_history.json
pca_sensitivity_by_year.png  New — generated from sensitivity_by_year.json

---

## MATPLOTLIB CHART SPECS

### pca_scree.png
Already generated. Use as-is.

### pca_pc1_crossover.png
Two-line chart. 1200×320px. White background.
X-axis: training end year 1996–2025 (one point per fold)
Y-axis: absolute loading magnitude 0.0–0.6
Line 1: BAA10Y loading — gold (#C8A951), linewidth 2.5
Line 2: SPX_200d_ma_spread loading — navy (#1B2A4A), linewidth 2.5
Markers: filled circles at each fold, same color as line
Vertical dashed gray line at 2019 labeled "Structural shift"
Legend upper right. DM Mono labels throughout.
Title: "PC1 Dominant Loading — Rates Axis to Equity Stress Axis"

### pca_era_timeline.png
Horizontal band chart. 1200×160px. White background.
Two rows of colored horizontal bands, full chart width:
  Row 1 "PC1 character":
    1996–2018: silk/gray band, centered label "Rates & Credit Axis"
    2019–2025: navy band, centered label "Equity Stress Axis" in white
  Row 2 "PC1 variance %":
    Color gradient per fold: low=light (#CBD5E1), high=navy (#1B2A4A)
    Shows PC1 variance increasing from ~18% to ~22% over time
Vertical dashed line at 2019, labeled "2018–2019" above
X-axis: years 1996–2025, tick every 5 years. DM Mono labels.

### pca_sensitivity_by_year.png
Vertical bar chart. 1200×320px. White background.
X-axis: year 2006–2026, annual bars
Y-axis: disagreement % 0–100
Bar colors: <15% green (#27AE60), 15–40% yellow (#EAB308), >40% red (#E74C3C)
Horizontal dashed reference line at 27.2% (overall mean), gray
Annotate 2022 (0%), 2020 (78.9%), 2023 (70.5%) with year and value labels
Source label bottom right: "AppliedComplexity · joshuampeck.com" mono 8pt gray
Title: "Classification Agreement: PCA=0.85 vs PCA=0.90 · By Year"
```