---
name: pro-seo-report
description: >
  Client-ready SEO report generator. Assembles prior ProSEO analyses and live
  data into a stakeholder report: executive summary, score trends, wins,
  issues, and a prioritized roadmap, as Markdown or a styled HTML artifact.
  Use when user says "SEO report", "client report", "monthly report",
  "stakeholder summary", "SEO deck", or "present the SEO results".
user-invocable: true
argument-hint: "[url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.1"
  category: seo
---

# SEO Report Generator

**Invocation:** `/pro-seo report <url>`

Turns analysis into a deliverable a non-SEO stakeholder can act on. The report
answers three questions in order: what happened, why, and what we do next.

## Process

### 1. Gather inputs (use what exists, fetch what doesn't)
- Prior audit outputs in the working directory (audit reports, lifecycle state
  file `pro-seo-lifecycle.json`, drift baselines)
- Live data when credentials are configured:
  - `pro-seo run google_report.py <url> --json` (GSC clicks/impressions, PSI, CrUX)
  - `pro-seo run drift_compare.py <url>` for what changed since last period
- If nothing exists yet, say so and offer to run `/pro-seo audit <url>` first
  rather than fabricating history

### 2. Analyze
- Period-over-period: clicks, impressions, CTR, average position, CWV pass rate
- Attribute movements to causes (shipped fixes, content published, algorithm
  updates, seasonality) — mark attribution confidence high/medium/low, never
  claim certainty the data doesn't support
- Wins worth showing; regressions worth owning
- Roadmap: top 5 next actions with expected impact and effort

### 3. Render
Default: Markdown. When the user wants something presentable, produce a styled
HTML report and publish it as an artifact (executive-friendly: one summary
screen, charts for trends, tables for detail). Audience calibration:
executives get outcomes and money pages; practitioners get URLs and fixes.

## Output Format

```
# SEO Report: {site} — {period}

## Executive Summary
{3-5 sentences: trajectory, biggest win, biggest risk, next focus}

## Performance
| Metric | This period | Last period | Δ |
| Clicks / Impressions / CTR / Avg position / CWV pass |

## What Drove It
{cause -> effect bullets, with confidence levels}

## Completed This Period
{shipped fixes and content, each tied to its effect where measurable}

## Issues & Risks
| # | Severity | Issue | Owner | Status |

## Roadmap (next period)
| # | Action | Expected impact | Effort | Skill to run |
```

## Related Skills

- `/pro-seo google` -- the data layer (GSC, PSI, CrUX, GA4)
- `/pro-seo audit` -- source of the issues list and scores
- `/pro-seo lifecycle` -- the report is the Measure-stage deliverable
- `/pro-seo drift` -- period-over-period change detection
