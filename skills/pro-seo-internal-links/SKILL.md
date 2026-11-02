---
name: pro-seo-internal-links
description: >
  Internal linking audit and opportunity mapping. Crawls key pages, maps the
  internal link graph, finds orphan pages, weak hub pages, and missed anchor
  opportunities, and produces a concrete add-this-link-here plan. Use when
  user says "internal links", "internal linking", "orphan pages", "link
  equity", "site structure links", or "topic cluster linking".
user-invocable: true
argument-hint: "[url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.2"
  category: seo
---

# Internal Linking Audit & Opportunity Map

**Invocation:** `/pro-seo internal-links <url>`

Internal links are the cheapest ranking lever a site controls: they route
authority, define topical hubs, and decide what gets crawled. This skill maps
the current graph and outputs specific link additions with anchor text.

## Process

### 1. Build the page inventory
- Discover URLs: `pro-seo run sitemap_discovery.py <url> --json`
- No sitemap? Crawl navigation from the homepage:
  `pro-seo run fetch_page.py <url> --json` and follow same-host links
  (cap at ~50 pages; state the cap in the report).

### 2. Map the link graph
For each inventory page (prioritize money pages, hubs, and recent content):
- Fetch with `pro-seo run fetch_page.py <url> --json`
- Extract same-host `<a href>` links with anchor text, noting location
  (navigation, body, footer) — body links carry the signal
- For JS-rendered sites use `pro-seo run render_page.py <url> --mode auto --json`

### 3. Diagnose
- **Orphans**: in sitemap but zero incoming body links
- **Under-linked money pages**: high-value pages with < 3 incoming body links
- **Weak hubs**: cluster parents that don't link to all children (and back)
- **Anchor problems**: generic anchors ("click here", "learn more", bare URLs)
  on links to ranking-target pages
- **Depth problems**: important pages more than 3 clicks from the homepage
- **Legacy redirects/broken**: body links hitting 3xx chains or 4xx

### 4. Opportunity mining
For each priority target page, find source pages that mention the target's
topic but do not link to it (search fetched text for the target's primary
keyword and variants). Each opportunity names: source URL, the existing
sentence/section to link from, proposed anchor text, and target URL.

## Output Format

```
# Internal Linking Audit: {site}
Pages analyzed: {n} (of {total} discovered)

## Health Summary
| Metric | Value |
| Orphan pages | {n} |
| Avg body links per page | {n} |
| Money pages under-linked | {n} |
| Broken/redirected internal links | {n} |

## Fix Now (specific link additions)
| # | Source page | Anchor text | Target page | Why |

## Orphan Pages
{list with suggested parent/hub for each}

## Structural Recommendations
{hub-and-spoke changes, nav/footer changes, depth fixes}
```

## Related Skills

- `/pro-seo cluster` -- defines the hub/spoke architecture the links should express
- `/pro-seo technical` -- crawlability context (redirect chains, status codes)
- `/pro-seo content-brief` -- briefs include internal links from this map
