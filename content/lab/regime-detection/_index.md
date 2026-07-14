---
title:       "Regime Detection"
description: "MacroContext regime detection — identifying which behavioral state the S&P 500 is currently in, updated weekly."
eyebrow:     "Lab · Regime Detection"
layout:      "regime-detection"
image:       "/images/regime_detection.png"
---

MacroContext is a quantitative framework that classifies every trading day into one of three macro regimes — Extremes, Neutral, or Danger — using 16 macro and market stress indicators. By systematically reducing equity exposure during confirmed stress periods, the framework has historically produced nearly double the Sharpe ratio with 38% less volatility than buy-and-hold.

## The three regimes

**Extremes** — Strong directional momentum with compressing volatility. SPX near recent highs, VIX low and falling, credit spreads tight. Historically ~23% of trading days. 1.34 Sharpe on forward 21-day returns.

**Neutral** — Normal market conditions. The baseline state that describes the unremarkable majority of market history. Historically ~47% of trading days. 0.50 Sharpe.

**Danger** — Active drawdown conditions. Multiple stress signals aligned simultaneously. Historically ~30% of trading days in the current model (a known overestimate under active calibration). 0.30 Sharpe.

## How it works

The model runs in four steps. First, 16 correlated features are compressed into 4–5 uncorrelated principal components via PCA — this reduces the parameter count from ~375 to ~60 and removes noise while preserving signal. Second, a 3-state Gaussian Hidden Markov Model is fit on those components using the Baum-Welch expectation-maximization algorithm. Third, the resulting states are ordered by a composite risk score derived from the emission means. Fourth, the model is validated using an expanding-window walk-forward framework across seven folds covering 2019–2026.

## Validated performance

| Metric | Buy & Hold | MacroContext |
|---|---|---|
| CAGR | 8.4% | 11.1% |
| Volatility | 19.4% | 12.1% |
| Sharpe Ratio | 0.51 | 0.92 |
| Max Drawdown | -56.8% | -33.8% |

Walk-forward out-of-sample results, 2006–2026. Position sizing: Extremes 80%, Neutral 100%, Danger 25%.

## Known limitations

The model currently assigns ~30% of trading days to Danger versus a historical base rate of ~10–12% for confirmed drawdown periods. Fast geopolitical shocks (2025 tariff stress, 2026 Iran war) were initially missed due to rapid onset and resolution. Both are active areas of development.

## What's next

Migration to a full Bayesian HMM via PyMC for continuous probability outputs. SHAP attribution for per-day feature contribution. Extended training history back to 1991. Live validation began April 2026.
