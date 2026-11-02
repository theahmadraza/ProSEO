---
name: pro-seo-refresh
description: >
  Content decay detection and refresh planning. Finds pages losing clicks,
  impressions, or rankings, diagnoses why (staleness, SERP shift, intent
  drift, cannibalization), and produces a prioritized refresh queue with
  per-page instructions. Use when user says "content refresh", "content
  decay", "traffic dropped", "update old content", "declining pages",
  or "content pruning".
user-invocable: true
argument-hint: "[url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.2"
  category: seo
---

# Content Refresh & Decay Detection

**Invocation:** `/pro-seo refresh <url>`

Most sites lose more traffic to decaying content than they gain from new
content. This skill finds the decay, explains it, and turns it into a
prioritized refresh queue.

## Process

### 1. Detect decay
**With GSC access (preferred):**
- Pull page-level performance: `pro-seo run gsc_query.py --property <property> --json`
- Compare the last 90 days to the prior 90 days per page; flag pages with
  clicks down > 20%, impressions down > 20%, or average position worse by > 3
**Without GSC:**
- Use the drift history when baselines exist: `pro-seo run drift_history.py <url> --json`
- Otherwise inventory from the sitemap (`pro-seo run sitemap_discovery.py <url> --json`)
  and flag by staleness signals: visible dates, dated years in titles,
  outdated facts, dead outbound links

### 2. Diagnose each decayed page
Fetch it (`pro-seo run fetch_page.py <url> --json`) and classify the cause:
- **Staleness** -- dated content, old screenshots, superseded advice, old year in title
- **SERP shift** -- intent of the query changed (informational -> commercial, or AI Overview now answers it)
- **Outcompeted** -- competitors published deeper/fresher coverage
- **Cannibalization** -- another page on the same site targets the same query
- **Technical regression** -- noindex, redirect, slow LCP, lost schema (cross-check `/pro-seo technical`)

### 3. Prescribe
Per page, one primary action: **Update** (refresh facts/sections, keep URL),
**Rewrite** (same target, new content), **Consolidate** (merge + 301 into the
stronger page), **Retarget** (shift to the query's new intent), or **Prune**
(410/redirect, content has no plausible target). Never prescribe Prune for a
page with backlinks without recommending a redirect target.

### 4. Prioritize
Priority = (traffic at peak - traffic now) x business value x ease of fix.
Quick wins first: pages ranking 8-20 with fixable causes.

## Output Format

```
# Content Refresh Plan: {site}
Pages reviewed: {n} | Decaying: {n} | Est. recoverable clicks/mo: {n or "unknown"}

## Refresh Queue
| # | Page | Decay (90d) | Cause | Action | Effort | Priority |

## Per-Page Instructions (top 5)
### {url}
- What changed in the SERP/topic:
- Sections to update/add/remove:
- Title/meta updates:
- Internal links to add (see /pro-seo internal-links):
- Refresh the "last updated" date only alongside real changes

## Consolidations
{page pairs, surviving URL, redirect plan}
```

## Related Skills

- `/pro-seo google` -- GSC data that powers detection
- `/pro-seo drift` -- change baselines and comparisons over time
- `/pro-seo content` -- E-E-A-T quality bar for the refreshed page
- `/pro-seo content-brief` -- full brief when the action is Rewrite
