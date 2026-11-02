---
name: pro-seo-bing
description: Bing Webmaster Tools + IndexNow extension. Microsoft Copilot citations are fed by the Bing index; this skill makes Bing visibility, link data, and IndexNow URL submission first-class.
metadata:
  version: "1.0.1"
compatibility: "Requires BING_WEBMASTER_API_KEY and (optionally) INDEXNOW_KEY in ~/.claude/settings.json env. Run extensions/bing-webmaster/install.sh to configure."
---

# pro-seo-bing

The non-Google indexing surface. Google still rejects IndexNow (per
Gary Illyes, multiple SOTR episodes 2024-2025), so this skill is
specifically for **Amazon/Bing/Naver/Seznam.cz/Yandex/Yep indexing** and
**Microsoft Copilot AI citation** (which pulls from the Bing index).

## Prerequisites

- Run `extensions/bing-webmaster/install.sh` or `install.ps1`.
- A Bing Webmaster Tools API key.
- Optional: an IndexNow host key (32+ chars) published at the URL
  declared as `INDEXNOW_KEY_LOCATION`.

## Routing

| Command | Underlying script |
|---|---|
| `/pro-seo bing links <url>` | `pro-seo run bing_webmaster.py links <url>` |
| `/pro-seo bing compare <urlA> <urlB>` | `pro-seo run bing_webmaster.py compare <urlA> <urlB>`; both properties must be registered to the API account |
| `/pro-seo bing submit <url>` (single URL) | `pro-seo run indexnow_submit.py --host ... --urls <url>` |
| `/pro-seo bing submit-batch <file>` | `pro-seo run indexnow_submit.py --host ... --urls-file <file>` |
| `/pro-seo bing verify-indexnow` | `pro-seo run indexnow_submit.py --host ... --verify-only` |

## When this skill applies

- The user is publishing new pages and wants Microsoft Copilot
  citation eligibility (Bing index ingestion).
- The user wants to nudge Amazon/Bing/Naver/Seznam.cz/Yandex/Yep indexing for fresh
  URLs.
- The user manages both properties and wants to compare their Bing link data.
  For an arbitrary competitor, route to DataForSEO, Moz, or Common Crawl.

## Cross-skill delegation

- For Google indexing (very different model, sitemap-driven, no
  IndexNow), use `pro-seo-google indexing`.
- For multi-source backlink confidence weighting, fall back to
  `pro-seo-backlinks` which already integrates Bing + Moz + CC.
