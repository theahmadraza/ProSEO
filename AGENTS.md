# ProSEO: Multi-Platform Agent Instructions

> For **Cursor**, **Cursor Cloud Agents**, **Google Antigravity**, **Gemini CLI**,
> **Grok Build**,
> **OpenAI Codex CLI**, **Cline**, **Aider**, and any other agent harness that
> reads project-root agent instructions.
>
> Claude Code users: see `CLAUDE.md` instead.

## Cross-platform portability

Every skill in `skills/*/SKILL.md` is authored to a portable subset of the
Claude Code skill spec. Validate compatibility with your harness via:

```bash
./bin/pro-seo run portability_check.py
```

The check confirms each `SKILL.md` has the minimum frontmatter every harness
expects (`name`, `description`, optional `model`, optional `tools`) and warns
on Claude-Code-specific features (`maxTurns`, multi-line tool list with
descriptive comments) that other harnesses may ignore but do not reject.

### Per-harness notes

| Harness | How to load pro-seo |
|---|---|
| **Cursor** | Symlink or copy `skills/` and `agents/` into `.cursor/rules/`. Commands are invoked as text prompts; the harness reads `SKILL.md` body as system context. |
| **Cursor Cloud Agents** | Push the repo; Cloud Agents read `AGENTS.md` automatically at session start. |
| **Google Antigravity** | Point the workspace at this repo root; Antigravity reads `AGENTS.md` first, falls back to `skills/`. |
| **Gemini CLI** | `gemini init` in this repo loads `AGENTS.md`. Skills are activated via `activate_skill <name>` in conversation. |
| **Grok Build** | Open this repository in Grok Build. It reads `AGENTS.md` and Claude Code compatible plugins and skills without a separate layout. Use `grok inspect` to verify discovery. See the [official compatibility guide](https://docs.x.ai/build/features/skills-plugins-marketplaces). |
| **OpenAI Codex CLI** | Reads `AGENTS.md` from project root. Bash tools work as documented; some Claude-specific tool names (Read/Write/Edit) are aliased to Codex equivalents transparently. |
| **Cline** | Loads `AGENTS.md` from project root. Skills appear as system messages; subagent delegation falls back to in-context expansion. |
| **Aider** | Reads `AGENTS.md` if present; otherwise falls back to README. Aider does not support sub-agent dispatch; the seo-* skills run inline. |

### Tool-name compatibility

Where pro-seo skills mention Claude Code tools (`Read`, `Write`, `Edit`,
`Bash`, `Glob`, `Grep`, `WebFetch`), each harness typically has an equivalent:

| Claude Code | Codex | Cline | Aider | Cursor / Antigravity |
|---|---|---|---|---|
| Read       | read_file        | read_file       | (inline)        | read |
| Write      | write_file       | write_file      | /add then edit  | write |
| Edit       | apply_diff       | replace_in_file | /edit           | edit |
| Bash       | bash             | execute_command | /run            | shell |
| Glob       | glob             | search_files    | (inline)        | find |
| Grep       | grep             | search_files    | /grep           | grep |
| WebFetch   | fetch / browse   | (browser tool)  | (n/a)           | fetch |

These mappings are automatic in most harnesses; we list them for transparency
in case a recipe needs a specific call.

## Overview

ProSEO is a Tier 4 SEO analysis skill with 31 sub-skills (27 core + 1 orchestrator +
1 framework integration + 2 extension mirrors), 18 sub-agents (15 core + 1 framework
integration + 2 extension mirrors), and 53 Python execution scripts.

## Quick Reference

| Command | What it does |
|---------|-------------|
| `/pro-seo setup` | Create or refresh the isolated Python runtime and Chromium |
| `/pro-seo doctor` | Diagnose the runtime installation |
| `/pro-seo lifecycle [stage] [url]` | Staged SEO programme: Discover → Plan → Build → Optimize → Authority → Measure → Iterate |
| `/pro-seo keywords <topic or url>` | Keyword research, intent mapping, prioritization matrix |
| `/pro-seo internal-links <url>` | Internal linking audit and opportunity map |
| `/pro-seo refresh <url>` | Content decay detection and refresh plan |
| `/pro-seo migration [plan\|validate] <url>` | Site migration redirect mapping and post-launch validation |
| `/pro-seo report <url>` | Client-ready SEO report from prior analyses |
| `/pro-seo audit <url>` | Full website audit with parallel subagent delegation |
| `/pro-seo page <url>` | Deep single-page analysis |
| `/pro-seo technical <url>` | Technical SEO audit (9 categories) |
| `/pro-seo content <url>` | E-E-A-T and content quality analysis |
| `/pro-seo content-brief <topic>` | Generate a content brief for a topic |
| `/pro-seo schema <url>` | Schema.org detection, validation, generation |
| `/pro-seo sitemap <url>` | XML sitemap analysis or generation |
| `/pro-seo images <url>` | Image SEO: on-page audit, SERP analysis, file optimization |
| `/pro-seo geo <url>` | AI Overviews / Generative Engine Optimization |
| `/pro-seo plan <type>` | Strategic SEO planning |
| `/pro-seo cluster <keyword>` | SERP-based semantic clustering and content architecture |
| `/pro-seo sxo <url>` | Search Experience Optimization: page-type analysis, personas |
| `/pro-seo drift baseline <url>` | Capture SEO baseline for change monitoring |
| `/pro-seo drift compare <url>` | Compare current state to stored baseline |
| `/pro-seo drift history <url>` | Show drift history over time |
| `/pro-seo ecommerce <url>` | E-commerce SEO: product schema, marketplace intelligence |
| `/pro-seo programmatic [url]` | Programmatic SEO at scale |
| `/pro-seo competitor-pages [url]` | Competitor comparison pages |
| `/pro-seo flow [stage]` | FLOW framework prompts (Find, Leverage, Optimize, Win, Local; prompts/sync utilities.) |
| `/pro-seo local <url>` | Local SEO analysis (GBP, citations, reviews) |
| `/pro-seo maps [cmd] [args]` | Maps intelligence (geo-grid, GBP audit, competitors) |
| `/pro-seo hreflang <url>` | Hreflang/i18n SEO audit, cultural profiles, content parity |
| `/pro-seo google [cmd] [url]` | Google SEO APIs (GSC, PageSpeed, CrUX, Indexing, GA4) |
| `/pro-seo backlinks <url>` | Backlink profile analysis |
| `/pro-seo backlinks setup` | Setup free backlink APIs |
| `/pro-seo backlinks verify <url>` | Verify known backlinks still exist |
| `/pro-seo dataforseo [cmd]` | Live SEO data via DataForSEO (extension) |
| `/pro-seo image-gen [use-case]` | AI image generation for SEO assets (extension) |
| `/pro-seo firecrawl [cmd] <url>` | Full-site crawling and site mapping (extension) |
| `/pro-seo ahrefs [cmd] <target>` | Ahrefs backlink and keyword data (extension) |
| `/pro-seo bing [cmd] <url>` | Bing Webmaster data and IndexNow (extension) |
| `/pro-seo profound [cmd]` | LLM brand-citation tracking (extension) |
| `/pro-seo seranking [cmd]` | AI share-of-voice tracking (extension) |
| `/pro-seo unlighthouse <url>` | Multi-page Lighthouse audits (extension) |

## Using with Cursor / Cursor Cloud

Cursor reads this file automatically. All SKILL.md files contain the full
analysis logic as natural language instructions. Python scripts in `scripts/`
provide execution capabilities.

**Running scripts directly** (Cursor doesn't have MCP):
```bash
# Page fetching with SSRF protection
./bin/pro-seo run fetch_page.py https://example.com

# HTML parsing for SEO elements
./bin/pro-seo run parse_html.py https://example.com

# PageSpeed Insights
./bin/pro-seo run pagespeed_check.py https://example.com --json

# Drift baseline
./bin/pro-seo run drift_baseline.py https://example.com

# DataForSEO (requires credentials)
DATAFORSEO_USERNAME=user DATAFORSEO_PASSWORD=pass ./bin/pro-seo run dataforseo_merchant.py search "keyword"
```

**Cursor Cloud gotchas:**
- SSL certificates may not resolve for some domains. Investigate the certificate issue rather than disabling verification.
- Run bundled tools through `pro-seo`; never call the venv interpreter directly.
- Screenshots save to `/tmp/` not CWD. Check absolute paths.

## Using with Google Antigravity

Antigravity discovers this project via `.claude-plugin/plugin.json`.
Place the repo in `~/.gemini/antigravity/plugins/pro-seo/` or install via:

```bash
bash install.sh
```

## Architecture

```
skills/                    # 31 sub-skills (auto-discovered)
  pro-seo/SKILL.md            # Main orchestrator + routing
  pro-seo-lifecycle/          # SEO Lifecycle orchestrator (Discover → Iterate)
  pro-seo-keywords/           # Keyword research
  pro-seo-internal-links/     # Internal linking
  pro-seo-refresh/            # Content refresh
  pro-seo-migration/          # Site migrations
  pro-seo-report/             # Client-ready reports
  pro-seo-cluster/            # Semantic clustering
  pro-seo-sxo/                # Search Experience Optimization
  pro-seo-drift/              # SEO drift monitoring
  pro-seo-ecommerce/          # E-commerce SEO
  pro-seo-audit/              # Full site audit
  pro-seo-page/               # Single-page analysis
  pro-seo-technical/          # Technical SEO
  pro-seo-content/            # E-E-A-T quality
  pro-seo-content-brief/      # Content brief generation
  pro-seo-schema/             # Schema.org markup
  pro-seo-sitemap/            # XML sitemaps
  pro-seo-images/             # Image optimization
  pro-seo-geo/                # AI search / GEO
  pro-seo-local/              # Local SEO
  pro-seo-maps/               # Maps intelligence
  pro-seo-plan/               # Strategic planning
  pro-seo-hreflang/           # International SEO
  pro-seo-google/             # Google APIs
  pro-seo-backlinks/          # Backlink analysis
  pro-seo-programmatic/       # Programmatic SEO
  pro-seo-competitor-pages/   # Competitor pages
  pro-seo-flow/               # FLOW framework integration
  pro-seo-dataforseo/         # DataForSEO (extension)
  pro-seo-image-gen/          # AI images (extension)
agents/                    # 18 subagents
scripts/                   # 53 Python scripts, including the managed runtime
schema/                    # JSON-LD templates
extensions/                # 8 MCP extensions: DataForSEO, Firecrawl, Banana, Ahrefs, SE Ranking, Profound, Bing Webmaster, Unlighthouse
```

## Key Principles

1. **Progressive Disclosure**: Read SKILL.md for routing, load references on demand
2. **Industry Detection**: Auto-detect SaaS, e-commerce, local, publisher, agency
3. **Security**: Scripts that fetch user-supplied URLs go through `scripts/url_safety.py` (`validate_url_strict()` plus pinned safe fetchers) for SSRF protection
4. **Config location**: `~/.config/pro-seo/` for API credentials

## Maintainer

Maintained by Ahmad Raza. Third-party notices are in [NOTICE](NOTICE).
