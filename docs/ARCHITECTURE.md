# Architecture

## Overview

ProSEO follows Anthropic's official Claude Code skill specification with a modular, multi-skill architecture.

## Directory Structure

The plugin ships 31 sub-skills (27 core + 1 orchestrator + 1 framework integration + 2 extension mirrors) and 18 sub-agents (15 core + 1 framework integration + 2 extension mirrors).

```
~/.claude/plugins/.../pro-seo/
├── skills/
│   ├── seo/                    # Main orchestrator
│   │   ├── SKILL.md
│   │   └── references/         # On-demand reference files (13 files)
│   │
│   ├── pro-seo-audit/              # Full site audit (parallel subagents)
│   ├── pro-seo-page/               # Single page analysis
│   ├── pro-seo-technical/          # Technical SEO (9 categories)
│   ├── pro-seo-content/            # E-E-A-T and content quality
│   ├── pro-seo-content-brief/      # Competitive content brief generation
│   ├── pro-seo-schema/             # Schema markup detection and generation
│   ├── pro-seo-sitemap/            # XML sitemap analysis and generation
│   ├── pro-seo-images/             # Image optimization analysis
│   ├── pro-seo-geo/                # AI search optimization (GEO)
│   ├── pro-seo-local/              # Local SEO (GBP, citations, reviews)
│   ├── pro-seo-maps/               # Maps intelligence (geo-grid, GBP audit)
│   ├── pro-seo-backlinks/          # Backlink profile analysis
│   ├── pro-seo-cluster/            # Semantic topic clustering (SERP-based)
│   ├── pro-seo-sxo/                # Search Experience Optimization
│   ├── pro-seo-drift/              # SEO drift monitoring (baselines)
│   ├── pro-seo-ecommerce/          # E-commerce SEO (product schema, marketplaces)
│   ├── pro-seo-hreflang/           # International SEO and hreflang
│   ├── pro-seo-plan/               # Strategic SEO planning (industry templates)
│   ├── pro-seo-programmatic/       # Programmatic SEO at scale
│   ├── pro-seo-competitor-pages/   # Competitor comparison page generation
│   ├── pro-seo-google/             # Google SEO APIs (GSC, PSI, CrUX, GA4)
│   ├── pro-seo-flow/               # FLOW framework integration (CC BY 4.0)
│   ├── pro-seo-dataforseo/         # DataForSEO MCP mirror (extension surface)
│   └── pro-seo-image-gen/          # Banana MCP mirror (extension surface)
│
└── agents/
    ├── pro-seo-technical.md        # Crawlability, indexability, security
    ├── pro-seo-content.md          # E-E-A-T, readability, thin content
    ├── pro-seo-schema.md           # Structured data validation
    ├── pro-seo-sitemap.md          # Sitemap quality gates
    ├── pro-seo-performance.md      # Core Web Vitals
    ├── pro-seo-visual.md           # Screenshots, mobile rendering
    ├── pro-seo-geo.md              # AI crawler access, citability
    ├── pro-seo-local.md            # GBP signals, NAP, reviews
    ├── pro-seo-maps.md             # Geo-grid, competitor radius mapping
    ├── pro-seo-backlinks.md        # Moz, Bing Webmaster, Common Crawl
    ├── pro-seo-cluster.md          # Semantic clustering analysis
    ├── pro-seo-sxo.md              # Page-type, user stories, personas
    ├── pro-seo-drift.md            # Baseline comparison, regression detection
    ├── pro-seo-ecommerce.md        # Product schema, marketplace intelligence
    ├── pro-seo-google.md           # GSC, PSI, CrUX, GA4 analyst
    ├── pro-seo-flow.md             # FLOW framework prompt selection
    ├── pro-seo-dataforseo.md       # DataForSEO MCP mirror
    └── pro-seo-image-gen.md        # Banana MCP mirror
```

## Component Types

### Skills

Skills are markdown files with YAML frontmatter that define capabilities and instructions.

**SKILL.md Format:**
```yaml
---
name: skill-name
description: >
  When to use this skill. Include activation keywords
  and concrete use cases.
---

# Skill Title

Instructions and documentation...
```

### Subagents

Subagents are specialized workers that can be delegated tasks. They have their own context and tools.

**Agent Format:**
```yaml
---
name: agent-name
description: What this agent does.
tools: Read, Bash, Write, Glob, Grep
---

Instructions for the agent...
```

### Reference Files

Reference files contain static data loaded on-demand to avoid bloating the main skill.

## Orchestration Flow

### Full Audit (`/pro-seo audit`)

```
User request
    │
    ▼
┌──────────────────┐
│   seo            │  Main orchestrator (skills/pro-seo/SKILL.md)
└────────┬─────────┘
         │  Detects business type and signals
         │  Spawns subagents in parallel
         │
    ┌────┴────┬────────┬────────┬────────┬────────┬────────┐
    ▼         ▼        ▼        ▼        ▼        ▼        ▼
┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐
│tech   │ │content│ │schema │ │sitemap│ │perf   │ │visual │ │geo    │
└───┬───┘ └───┬───┘ └───┬───┘ └───┬───┘ └───┬───┘ └───┬───┘ └───┬───┘
    │         │         │         │         │         │         │
    └─────────┴─────────┴────┬────┴─────────┴─────────┴─────────┘
                             │
                             │  Conditional spawns:
                             │  - pro-seo-google     (Google API creds detected)
                             │  - pro-seo-local      (local business detected)
                             │  - pro-seo-maps       (local + DataForSEO MCP)
                             │  - pro-seo-backlinks  (Moz/Bing/CC available)
                             │  - pro-seo-cluster    (content strategy signals)
                             │  - pro-seo-sxo        (always in full audits)
                             │  - pro-seo-drift      (baseline exists for URL)
                             │  - pro-seo-ecommerce  (e-commerce detected)
                             ▼
                    ┌────────────────┐
                    │  Aggregate     │
                    │  Results       │
                    └────────┬───────┘
                             │
                             ▼
                    ┌────────────────┐
                    │  Generate      │
                    │  Health Score  │
                    │  + Action Plan │
                    └────────────────┘
```

### Individual Command

```
User Request (e.g., /pro-seo page)
    │
    ▼
┌─────────────────┐
│   seo       │  ← Routes to sub-skill
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   pro-seo-page      │  ← Sub-skill handles directly
│   (SKILL.md)    │
└─────────────────┘
```

## Design Principles

### 1. Progressive Disclosure

- Main SKILL.md stays under 500 lines (per the development rules)
- Reference files loaded on-demand
- Detailed instructions in sub-skills

### 2. Parallel Processing

- Subagents run concurrently during audits
- Independent analyses don't block each other
- Results aggregated after all complete

### 3. Quality Gates

- Built-in thresholds prevent bad recommendations
- Location page limits (30 warning, 50 hard stop)
- Schema deprecation awareness
- FID → INP replacement enforced

### 4. Industry Awareness

- Templates for different business types
- Automatic detection from homepage signals
- Tailored recommendations per industry

## File Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Skill | `seo-{name}/SKILL.md` | `pro-seo-audit/SKILL.md` |
| Agent | `seo-{name}.md` | `pro-seo-technical.md` |
| Reference | `{topic}.md` | `cwv-thresholds.md` |
| Script | `{action}_{target}.py` | `fetch_page.py` |
| Template | `{industry}.md` | `saas.md` |

## Extension Points

### Adding a New Sub-Skill

1. Create `skills/pro-seo-newskill/SKILL.md`
2. Add YAML frontmatter with name and description
3. Write skill instructions
4. Update main `skills/pro-seo/SKILL.md` to route to new skill

### Adding a New Subagent

1. Create `agents/pro-seo-newagent.md`
2. Add YAML frontmatter with name, description, tools
3. Write agent instructions
4. Reference from relevant skills

### Adding a New Reference File

1. Create file in appropriate `references/` directory
2. Reference in skill with load-on-demand instruction

## Extensions

### Managed Python runtime

Bundled tools are dispatched through `bin/pro-seo` and
`scripts/runtime.py`, never through a working-directory-relative Python command.
The launcher resolves Python 3.10 or newer, while the standard-library runtime
provides three operations: `run`, `setup`, and read-only `doctor`.

Plugin environments live under persistent `CLAUDE_PLUGIN_DATA`. Manual installs
keep the compatible `~/.claude/skills/pro-seo/.venv` location. A state marker records
the runtime schema, requirements SHA-256, Python major and minor version, public
plugin version, and browser state. Requirements, runtime-schema, or Python ABI
changes require explicit setup; a version-only difference remains compatible and
is refreshed on the next setup. Environment replacement is staged and rolled
back if validation or marker publication fails.

`run` accepts only allowlisted script basenames or a contained extension script.
It forwards arguments without a shell, preserves child exit codes, forces UTF-8
child streams, and uses the same persistent Playwright browser directory created
by setup.

Extensions are opt-in add-ons that integrate external data sources via MCP servers. They live in `extensions/<name>/` and ship their own install / uninstall scripts.

```
extensions/
├── dataforseo/               # DataForSEO MCP integration
│   ├── README.md
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── uninstall.ps1
│   ├── field-config.json
│   ├── skills/pro-seo-dataforseo/SKILL.md
│   ├── agents/pro-seo-dataforseo.md
│   └── docs/DATAFORSEO-SETUP.md
│
├── banana/                   # AI image generation via Gemini
│   ├── README.md
│   ├── install.sh
│   ├── uninstall.sh
│   ├── skills/pro-seo-image-gen/SKILL.md
│   ├── agents/pro-seo-image-gen.md
│   ├── scripts/              # Python fallback scripts (stdlib only)
│   ├── references/           # 7 reference files (prompt engineering, models, presets)
│   └── docs/BANANA-SETUP.md
│
├── firecrawl/                # Firecrawl MCP for full-site crawling
│   ├── README.md
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── uninstall.ps1
│   └── skills/pro-seo-firecrawl/SKILL.md
│
├── ahrefs/                   # Ahrefs MCP for backlinks + organic data
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── skills/pro-seo-ahrefs/SKILL.md
│   └── docs/AHREFS-SETUP.md
│
├── seranking/                # SE Ranking AI Share-of-Voice tracking
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── skills/pro-seo-seranking/SKILL.md
│   └── docs/SERANKING-SETUP.md
│
├── profound/                 # Profound LLM citation tracking
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── skills/pro-seo-profound/SKILL.md
│   └── docs/PROFOUND-SETUP.md
│
├── bing-webmaster/           # Bing Webmaster Tools + IndexNow
│   ├── install.sh
│   ├── install.ps1
│   ├── uninstall.sh
│   ├── skills/pro-seo-bing/SKILL.md
│   └── docs/BING-WEBMASTER-SETUP.md
│
└── unlighthouse/             # Multi-page Lighthouse runner (local)
    ├── install.sh
    ├── install.ps1
    ├── uninstall.sh
    ├── skills/pro-seo-unlighthouse/SKILL.md
    └── docs/UNLIGHTHOUSE-SETUP.md
```

### Available Extensions

| Extension | Package (pinned) | What it adds |
|-----------|------------------|--------------|
| **DataForSEO** | `dataforseo-mcp-server@2.8.10` | Live SERP data, keyword research, backlinks, on-page analysis, business listings, AI visibility, LLM mention tracking |
| **Banana Image Gen** | `@ycse/nanobanana-mcp@1.1.1` | AI image generation for SEO assets via Gemini (OG images, hero images, product photos, infographics, batch) |
| **Firecrawl** | `firecrawl-mcp@3.11.0` | Full-site crawling and URL discovery for audits |
| **Ahrefs** | `@ahrefs/mcp@0.0.11` | Backlinks and organic keyword data via the official `@ahrefs/mcp` server |
| **SE Ranking** | SE Ranking API | AI Share-of-Voice across ChatGPT, Gemini, Perplexity, AI Overviews, and AI Mode |
| **Profound** | Profound API | LLM citation tracking with time-series data |
| **Bing Webmaster** | Bing Webmaster Tools API | Bing Webmaster Tools + IndexNow URL submission |
| **Unlighthouse** | `unlighthouse@0.13.5` | Multi-page Lighthouse runner, runs locally |

### Extension Convention

1. Self-contained in `extensions/<name>/`
2. Own `install.sh` (and `install.ps1` where Windows is supported) that copies files and configures MCP (where applicable)
3. Own `uninstall.sh` (and `uninstall.ps1` where present) that reverses installation
4. Installs the sub-skill mirror to the plugin's skill directory
5. Installs the sub-agent mirror to the plugin's agent directory (extensions that ship one; lighter extensions are skill-only)
6. Merges MCP config into `~/.claude/settings.json` non-destructively
7. MCP server versions are pinned (`@<version>`) for supply-chain stability
