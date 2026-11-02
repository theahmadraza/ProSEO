---
name: pro-seo-lifecycle
description: >
  ProSEO SEO Lifecycle orchestrator: a staged, end-to-end SEO program for any
  website. Runs Discover -> Plan -> Build -> Optimize -> Authority -> Measure
  -> Iterate, delegating each stage to the right ProSEO sub-skills and
  tracking progress between sessions. Use when user says "SEO lifecycle",
  "SEO program", "SEO roadmap end to end", "where do I start with SEO",
  "run the full SEO process", or "next SEO stage".
user-invocable: true
argument-hint: "[stage] [url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.2"
  category: seo
---

# ProSEO SEO Lifecycle: Discover · Plan · Build · Optimize · Authority · Measure · Iterate

**Invocation:** `/pro-seo lifecycle [stage] [url]`

**Target site:** pass the site as the `[url]` argument. When no URL is given,
read `site` from `pro-seo-lifecycle.json` in the working directory if a lifecycle
is already in progress; otherwise ask for the URL before doing anything else.
There is no built-in default site.

The SEO Lifecycle is ProSEO's top-level operating model. Where `/pro-seo audit`
answers "what is wrong right now?", the lifecycle answers "what should we do
next, in what order, and how do we know it worked?" It sequences the full
ProSEO skill set into seven stages and carries state forward between runs.

## Commands

| Command | What it does |
|---------|-------------|
| `/pro-seo lifecycle <url>` | Assess the site, decide the current stage, and propose the stage plan |
| `/pro-seo lifecycle discover <url or topic>` | Stage 1: market, keyword, and competitor discovery |
| `/pro-seo lifecycle plan <url>` | Stage 2: strategy, architecture, and content briefs |
| `/pro-seo lifecycle build <url>` | Stage 3: content production support, schema, images, sitemap |
| `/pro-seo lifecycle optimize <url>` | Stage 4: technical health and on-page polish |
| `/pro-seo lifecycle authority <url>` | Stage 5: backlinks, local presence, AI visibility |
| `/pro-seo lifecycle measure <url>` | Stage 6: real data, drift, reporting |
| `/pro-seo lifecycle iterate <url>` | Stage 7: refresh decayed content, re-audit, loop |
| `/pro-seo lifecycle status <url>` | Show the saved lifecycle state and recommended next action |

## Lifecycle State

Persist progress in `pro-seo-lifecycle.json` in the working directory:

```json
{
  "site": "https://example.com",
  "started": "YYYY-MM-DD",
  "current_stage": "optimize",
  "stages": {
    "discover": {"status": "done", "date": "YYYY-MM-DD", "outputs": ["keyword map", "cluster plan"]},
    "plan": {"status": "done", "date": "YYYY-MM-DD", "outputs": ["strategy doc"]},
    "optimize": {"status": "in-progress", "open_items": ["fix INP on /pricing", "add hreflang"]}
  }
}
```

On every invocation: read the state file if present, report what changed since
the last run, and update it before finishing. Never overwrite a state file for
a different site; create one per site.

## Stage Playbooks

### Stage 1 — Discover
Goal: know the market before touching the site.
1. Keyword research and prioritization: delegate to `/pro-seo keywords <topic>`
2. Semantic clustering and content architecture: `/pro-seo cluster <seed-keyword>`
3. Competitor landscape: `/pro-seo competitor-pages <url>` (analysis mode)
4. If the domain already exists, capture a baseline: `/pro-seo drift baseline <url>`

Exit criteria: prioritized keyword map, cluster architecture, competitor gap list.

### Stage 2 — Plan
Goal: an executable strategy, not a wish list.
1. Strategic plan by business type: `/pro-seo plan <business-type>`
2. Programmatic opportunities at scale: `/pro-seo programmatic plan`
3. Briefs for the first content wave: `/pro-seo content-brief <topic>` per cluster

Exit criteria: roadmap with owners and dates, first 5-10 content briefs.

### Stage 3 — Build
Goal: pages exist, are marked up, and are discoverable.
1. Content quality bar for every new page: `/pro-seo content <url>`
2. Structured data: `/pro-seo schema <url>`
3. Image SEO: `/pro-seo images <url>`
4. Sitemap generation or update: `/pro-seo sitemap generate`

Exit criteria: content wave published, valid schema, sitemap submitted.

### Stage 4 — Optimize
Goal: nothing technical is holding rankings back.
1. Technical audit: `/pro-seo technical <url>`
2. Page-level deep dives on priority URLs: `/pro-seo page <url>`
3. Internal linking pass: `/pro-seo internal-links <url>`
4. Search experience: `/pro-seo sxo <url>`
5. International sites: `/pro-seo hreflang <url>`

Exit criteria: technical audit score improved, internal link opportunities applied.

### Stage 5 — Authority
Goal: earn the signals that content alone cannot.
1. Backlink profile and gaps: `/pro-seo backlinks <url>`
2. Local presence when applicable: `/pro-seo local <url>` and `/pro-seo maps audit`
3. AI-search visibility: `/pro-seo geo <url>`

Exit criteria: link gap plan in motion, GBP optimized, citability score improved.

### Stage 6 — Measure
Goal: decisions from field data, not guesses.
1. Real performance data: `/pro-seo google report <url>` (GSC, PSI, CrUX, GA4)
2. Change monitoring: `/pro-seo drift compare <url>`
3. Stakeholder deliverable: `/pro-seo report <url>`

Exit criteria: report delivered, wins and losses identified with causes.

### Stage 7 — Iterate
Goal: compound growth instead of one-off projects.
1. Find decayed content: `/pro-seo refresh <url>`
2. Re-run the full audit: `/pro-seo audit <url>`
3. Feed findings back into Stage 1 for the next cycle. During replatforms or
   domain changes, run `/pro-seo migration plan <url>` before anything else.

Exit criteria: refresh queue prioritized, next cycle scheduled.

## Stage Selection Heuristics

When invoked without a stage, pick the entry stage from evidence, not habit:

- No site yet, or topic given instead of URL -> **discover**
- Site exists but no keyword map or strategy on file -> **discover**, then **plan**
- Strategy exists, thin or missing content -> **build**
- Content exists, technical audit never run or score < 70 -> **optimize**
- Technically sound, weak backlinks / no GBP / no AI citations -> **authority**
- Everything shipped but no GSC/analytics review in 30+ days -> **measure**
- Measured, and traffic flat or declining -> **iterate**

State the chosen stage and the evidence for it before delegating.

## Output Format

```
# SEO Lifecycle: {site}
Current stage: {stage} ({n} of 7)
Previous stages: {summary or "none on file"}

## This Stage's Plan
{numbered actions with the sub-skill each delegates to}

## Exit Criteria
{checklist}

## Next Stage Preview
{one line}
```

## Related Skills

- `/pro-seo flow` -- FLOW prompt library (Find · Leverage · Optimize · Win); use its
  stage prompts inside lifecycle stages when evidence-led prompts are wanted
- `/pro-seo audit` -- point-in-time diagnosis; the lifecycle schedules it, stage 7 consumes it
