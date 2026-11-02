---
name: pro-seo-migration
description: >
  Site migration SEO: redirect mapping, pre-launch checklist, and post-launch
  validation for domain changes, replatforms, HTTPS moves, URL restructures,
  and site merges. Use when user says "site migration", "domain change",
  "replatform", "redirect map", "301 plan", "we're moving the site",
  "URL structure change", or "post-migration check".
user-invocable: true
argument-hint: "[plan|validate] [url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.2"
  category: seo
---

# Site Migration SEO

**Invocation:** `/pro-seo migration [plan|validate] <url>`

Migrations are where sites lose years of equity in a week. This skill has two
modes: **plan** (before the switch) and **validate** (after it).

## `/pro-seo migration plan <url>`

### 1. Inventory the current site
- Full URL list: `pro-seo run sitemap_discovery.py <url> --json`
- Capture a pre-migration baseline: `pro-seo run drift_baseline.py <url>`
- With GSC: export top pages by clicks (`pro-seo run gsc_query.py --property <property> --json`)
  and mark the top traffic/backlink pages as **protected URLs**
- Identify pages with external backlinks (see `/pro-seo backlinks`) — these
  must never 404 after launch

### 2. Build the redirect map
- One-to-one 301s for every indexed URL; produce a table `old URL -> new URL`
- Rules for patterns (e.g. `/blog/{slug}` -> `/insights/{slug}`), explicit
  rows for exceptions
- No redirect chains: map every old URL directly to its final destination
- Retired content: redirect to the closest topical parent, not the homepage;
  410 only when nothing relevant exists
- Preserve: title/meta, canonical, hreflang, schema, and internal links on
  the destination pages

### 3. Pre-launch checklist
- [ ] Redirect map covers 100% of indexed URLs (diff against inventory)
- [ ] New site blocks crawling on staging, unblocks at launch (robots, noindex)
- [ ] XML sitemap for the new structure ready; old sitemap kept temporarily
- [ ] Analytics/GSC properties for the new host verified in advance
- [ ] Internal links updated to final URLs (no internal 301 hops)
- [ ] hreflang and canonicals point at the new URLs
- [ ] Launch window chosen in a low-traffic period; rollback plan written

## `/pro-seo migration validate <url>`

Run within 48 hours of launch, then weekly for a month:

1. **Redirect verification**: sample the redirect map (all protected URLs plus
   a random sample) with `pro-seo run fetch_page.py <old-url> --json`; verify
   single-hop 301 to the mapped destination
2. **Coverage**: crawl the new sitemap; every URL returns 200, is indexable,
   and canonicalizes to itself
3. **Parity**: `pro-seo run drift_compare.py <url>` against the pre-migration
   baseline — titles, metas, schema, and content must not silently regress
4. **Indexation**: with GSC, `pro-seo run gsc_inspect.py <new-url> --json` on
   protected URLs; watch coverage report for spikes in 404/redirect errors
5. **Performance**: `pro-seo run pagespeed_check.py <url> --json` — the new
   platform must not be slower than the old one

## Output Format

```
# Migration {Plan|Validation}: {old} -> {new}
Risk level: {low|medium|high} — {why}

## Protected URLs ({n})
| URL | Clicks/mo | Backlinks | Mapped to |

## Redirect Map {summary + rules + exceptions}
## Checklist {with pass/fail on validate}
## Issues Found
| # | Severity | Issue | Fix |
```

## Related Skills

- `/pro-seo drift` -- the baseline/compare engine used for parity checks
- `/pro-seo technical` -- full technical audit of the new site
- `/pro-seo backlinks` -- which URLs carry external equity that must be preserved
