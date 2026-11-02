# ProSEO — SEO Skills & SEO Lifecycle for Claude Code

**ProSEO** is a comprehensive SEO plugin for [Claude Code](https://claude.com/claude-code).
It ships **31 sub-skills and 18 specialist agents** covering the full **SEO Lifecycle** —
Discover → Plan → Build → Optimize → Authority → Measure → Iterate — across technical SEO,
content quality (E-E-A-T), Schema.org markup, AI search optimization (GEO), local SEO,
e-commerce, and international SEO. Every audit produces a prioritized action plan with
testable recommendations grounded in primary-source guidance from Google.

All commands start with `/pro-seo`.

📖 **Documentation:** [pro-seo.info](https://pro-seo.info) — every skill with usage notes, a getting-started guide and the lifecycle walkthrough. Reference docs also ship in [`docs/`](docs/).

## Installation

### Plugin install (recommended)

```bash
/plugin marketplace add theahmadraza/ProSEO
/plugin install pro-seo@pro-seo
/pro-seo setup
```

The setup step creates an isolated Python environment in Claude's persistent
plugin data and installs Playwright Chromium. Check it at any time with
`/pro-seo doctor`.

### Manual install (macOS / Linux)

```bash
bash install.sh
```

Every install path, the file layout it creates, and how to uninstall are in
[docs/INSTALLATION.md](docs/INSTALLATION.md).

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

## Quick Start

```bash
# The SEO Lifecycle: staged, end-to-end SEO program for any site
/pro-seo lifecycle https://example.com

# Full site audit: parallel sub-agents produce a prioritized action plan
/pro-seo audit https://example.com

# Deep single-page analysis
/pro-seo page https://example.com/about

# Schema markup audit: detect, validate, generate
/pro-seo schema https://example.com

# AI search optimization (GEO)
/pro-seo geo https://example.com

# Keyword research and prioritization
/pro-seo keywords "your topic"
```

## Commands

| Command | What it does |
|---------|-------------|
| `/pro-seo setup` | Create or refresh the isolated Python runtime and Chromium |
| `/pro-seo doctor` | Diagnose the runtime installation |
| `/pro-seo lifecycle [stage] [url]` | **SEO Lifecycle orchestrator**: Discover → Plan → Build → Optimize → Authority → Measure → Iterate |
| `/pro-seo audit <url>` | Full website audit with parallel subagent delegation |
| `/pro-seo page <url>` | Deep single-page analysis |
| `/pro-seo keywords <topic or url>` | Keyword research, intent mapping, prioritization matrix |
| `/pro-seo internal-links <url>` | Internal linking audit and opportunity map |
| `/pro-seo refresh <url>` | Content decay detection and refresh plan |
| `/pro-seo migration [plan\|validate] <url>` | Site migration SEO: redirect mapping and post-launch validation |
| `/pro-seo report <url>` | Client-ready SEO report from prior analyses |
| `/pro-seo sitemap <url or generate>` | Analyze or generate XML sitemaps |
| `/pro-seo schema <url>` | Detect, validate, and generate Schema.org markup |
| `/pro-seo images <url or optimize>` | Image SEO: on-page audit, SERP analysis, file optimization |
| `/pro-seo technical <url>` | Technical SEO audit (9 categories) |
| `/pro-seo content <url>` | E-E-A-T and content quality analysis |
| `/pro-seo content-brief <topic or url>` | SEO content brief with target keywords, outline, internal links |
| `/pro-seo geo <url>` | AI Overviews / Generative Engine Optimization |
| `/pro-seo plan <business-type>` | Strategic SEO planning |
| `/pro-seo programmatic [url\|plan]` | Programmatic SEO analysis and planning |
| `/pro-seo competitor-pages [url\|generate]` | Competitor comparison page generation |
| `/pro-seo local <url>` | Local SEO analysis (GBP, citations, reviews, map pack) |
| `/pro-seo maps [command] [args]` | Maps intelligence (geo-grid, GBP audit, reviews, competitors) |
| `/pro-seo hreflang [url]` | Hreflang/i18n SEO audit and generation |
| `/pro-seo google [command] [url]` | Google SEO APIs (GSC, PageSpeed, CrUX, Indexing, GA4) |
| `/pro-seo backlinks <url>` | Backlink profile analysis (free: Moz, Bing, CC; premium: DataForSEO) |
| `/pro-seo cluster <seed-keyword>` | SERP-based semantic clustering and content architecture |
| `/pro-seo sxo <url>` | Search Experience Optimization |
| `/pro-seo drift baseline <url>` | Capture SEO baseline for change monitoring |
| `/pro-seo flow [stage]` | FLOW framework prompts (Find · Leverage · Optimize · Win) |
| `/pro-seo ecommerce <url>` | E-commerce SEO audit |
| `/pro-seo image-gen [command]` | AI image generation for SEO (Banana extension) |
| `/pro-seo dataforseo [command]` | DataForSEO MCP integration |

Full reference in [docs/COMMANDS.md](docs/COMMANDS.md).

## The SEO Lifecycle

`/pro-seo lifecycle` runs an end-to-end SEO program in seven stages, each delegating
to the right specialist skills:

| Stage | Goal | Key skills |
|-------|------|-----------|
| 1. Discover | Understand market, keywords, competitors | keywords, cluster, competitor-pages |
| 2. Plan | Strategy, architecture, briefs | plan, programmatic, content-brief |
| 3. Build | Create and mark up content | content, schema, images, sitemap |
| 4. Optimize | Technical health and on-page polish | technical, page, sxo, internal-links, hreflang |
| 5. Authority | Links, local presence, AI visibility | backlinks, local, maps, geo |
| 6. Measure | Real data and reporting | google, drift, report |
| 7. Iterate | Refresh, fix decay, re-run | refresh, audit, migration |

## Architecture

- `skills/` — 31 sub-skills orchestrated by `skills/pro-seo`
- `agents/` — 18 specialist agents spawned in parallel during audits
- `scripts/` — bundled Python tools run through `pro-seo run <script.py>` (SSRF-safe fetchers, SPA-aware rendering, GSC/PSI/CrUX clients)
- `hooks/` — schema validation hooks
- `extensions/` — optional MCP extensions: DataForSEO, Firecrawl, Banana, Ahrefs, SE Ranking, Profound, Bing Webmaster, Unlighthouse

## Requirements

- Claude Code 1.0.33+
- Python 3.10+
- Node.js (for hooks)

ProSEO is a command-line plugin. It builds an isolated Python environment and
drives Playwright Chromium for rendering and screenshots, so it runs in Claude
Code on your own machine. It does not install on claude.ai or Cowork.

## Staying up to date

Updates reach you only when the plugin's version number changes, so a new
release is a version bump on this repository.

To pull the latest release:

```
/plugin marketplace update pro-seo
```

To have Claude Code do it for you, open `/plugin`, go to **Marketplaces**,
select **pro-seo** and choose **Enable auto-update**. Auto-update is off by
default and cannot be turned on from this end.

Every release is tagged and listed under
[Releases](https://github.com/theahmadraza/ProSEO/releases) with its changes in
[CHANGELOG.md](CHANGELOG.md).

## Contributing

Bug reports, fixes and new checks are welcome. Read
[CONTRIBUTING.md](CONTRIBUTING.md) for how to run the test suite and the
consistency gate before opening a pull request. Report security issues
privately as described in [SECURITY.md](SECURITY.md).

## License

ProSEO is **copyright © 2026 Ahmad Raza** and licensed under the
[GNU Affero General Public License v3.0 or later](LICENSE).

**What that means.** You may use ProSEO, read it, change it and pass it on,
free of charge. Two obligations come with that: if you distribute a modified
version, or run one as a network service that other people use, you must make
your version's source available to those users under the same licence; and you
must keep the copyright and licence notices intact.

A **commercial licence** that removes the source-disclosure obligation is
available — raise an issue on this repository to ask about it.

The name **ProSEO** and its logo are marks of Ahmad Raza and are not covered by
the AGPL. Forks are welcome; presenting one as ProSEO is not.

Third-party notices are in [NOTICE](NOTICE).
