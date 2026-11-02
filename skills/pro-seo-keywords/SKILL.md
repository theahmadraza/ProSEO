---
name: pro-seo-keywords
description: >
  Standalone keyword research and prioritization. Seed expansion, search
  intent mapping, difficulty/opportunity scoring, and a prioritized keyword
  matrix ready for content planning. Use when user says "keyword research",
  "find keywords", "keyword ideas", "search volume", "keyword difficulty",
  "keyword opportunities", or "which keywords should I target".
user-invocable: true
argument-hint: "[topic or url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.2"
  category: seo
---

# Keyword Research & Prioritization

**Invocation:** `/pro-seo keywords <topic or url>`

Produces a prioritized keyword matrix: expanded keyword set, intent per
keyword, competitiveness estimate, and a recommended target page type. Works
from a seed topic, or reverse-engineers a URL's current and adjacent keywords.

## Process

### 1. Seed expansion
- If given a **topic**: expand into head, mid-tail, and long-tail variants,
  question keywords (who/what/how/why/vs/best/cost), and modifier sets
  (buyer, comparison, location, year).
- If given a **URL**: fetch it with `pro-seo run fetch_page.py <url> --json`,
  extract the primary entity and existing headings, then expand around them.
- With Google credentials configured, ground volumes in real data:
  `pro-seo run keyword_planner.py ideas "<seed>" --json` and
  `pro-seo run keyword_planner.py volume "<kw1>,<kw2>,..." --json`.
- If the site is verified in GSC, mine queries the site already ranks for:
  `pro-seo run gsc_query.py --property <property> --json` — position 8-20
  queries are the fastest wins.
- Without APIs, estimate volume tiers (high/medium/low/minimal) from SERP
  signals and say clearly that they are estimates.

### 2. Intent mapping
Classify every keyword: **informational**, **commercial investigation**,
**transactional**, or **navigational**. Map each intent to a page type
(guide, comparison, product/service page, landing page).

### 3. Scoring
Score each keyword 1-5 on:
- **Relevance** to the business and its offer
- **Opportunity** (volume tier x current ranking gap)
- **Winnability** (competition strength for a site of this authority)

Priority = Relevance x Opportunity x Winnability. Rank descending.

### 4. Output

```
# Keyword Matrix: {topic or url}

## Priority Targets (top 10)
| # | Keyword | Intent | Volume | Winnability | Target page | Priority |

## Question Keywords (AI-search / featured snippet candidates)
| Keyword | Intent | Existing page or NEW |

## Full Expansion ({n} keywords, grouped by sub-topic)

## Next Steps
- Cluster the winners: /pro-seo cluster <top seed>
- Brief the first pages: /pro-seo content-brief <keyword>
```

## Related Skills

- `/pro-seo cluster` -- SERP-overlap clustering of the keyword set into a content architecture
- `/pro-seo content-brief` -- turn a chosen keyword into a full content brief
- `/pro-seo google` -- GSC query mining and Keyword Planner integration
- `/pro-seo dataforseo` -- premium volume/difficulty data when the extension is installed
