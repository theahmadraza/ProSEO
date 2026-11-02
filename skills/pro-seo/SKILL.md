---
name: pro-seo
description: "Comprehensive SEO analysis for any website or business type. Full site audits, single-page analysis, technical SEO (crawlability, indexability, Core Web Vitals with INP), schema markup, content quality (E-E-A-T), image optimization, sitemap analysis, and GEO for AI Overviews/ChatGPT/Perplexity. Industry detection for SaaS, e-commerce, local, publishers, agencies. Triggers on: SEO, audit, schema, Core Web Vitals, sitemap, E-E-A-T, AI Overviews, GEO, technical SEO, content quality, page speed."
user-invocable: true
argument-hint: "[command] [url]"
license: AGPL-3.0-or-later
metadata:
  author: Ahmad Raza
  version: "1.0.1"
  category: seo
---

# SEO: Universal SEO Analysis Skill

**Invocation:** `/pro-seo $1 $2` where `$1` is the command and `$2` is the URL or argument.

**Runtime:** Run bundled Python tools through `pro-seo run <script.py>`. Plugin
installs expose this command automatically. Repository users run
`./bin/pro-seo`; manual installers rewrite the command to the isolated
launcher path. Never invoke bundled scripts with a bare Python interpreter.

Comprehensive SEO analysis across all industries (SaaS, local services,
e-commerce, publishers, agencies). Orchestrates the other 30 sub-skills (27 core + 1 framework
integration + 2 extension mirrors) and 18 sub-agents. A separate optional Firecrawl
extension is also installable (see "Optional Extensions" below).

## Quick Reference

| Command | What it does |
|---------|-------------|
| `/pro-seo audit <url>` | Full website audit with parallel subagent delegation |
| `/pro-seo page <url>` | Deep single-page analysis |
| `/pro-seo sitemap <url or generate>` | Analyze or generate XML sitemaps |
| `/pro-seo schema <url>` | Detect, validate, and generate Schema.org markup |
| `/pro-seo images <url or optimize>` | Image SEO: on-page audit, SERP analysis, file optimization |
| `/pro-seo technical <url>` | Technical SEO audit (9 categories) |
| `/pro-seo content <url>` | E-E-A-T and content quality analysis |
| `/pro-seo content-brief <topic or url>` | Generate detailed SEO content brief with target keywords, outline, internal links |
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
| `/pro-seo sxo <url>` | Search Experience Optimization: page-type analysis, user stories, personas |
| `/pro-seo drift baseline <url>` | Capture SEO baseline for change monitoring |
| `/pro-seo drift compare <url>` | Compare current state to stored baseline |
| `/pro-seo drift history <url>` | Show drift history over time |
| `/pro-seo ecommerce <url>` | E-commerce SEO: product schema, marketplace intelligence |
| `/pro-seo firecrawl [command] <url>` | Full-site crawling and site mapping (extension) |
| `/pro-seo dataforseo [command]` | Live SEO data via DataForSEO (extension) |
| `/pro-seo image-gen [use-case] <description>` | AI image generation for SEO assets (extension) |
| `/pro-seo flow [stage] [url\|topic]` | FLOW framework: evidence-led prompts for Find, Leverage, Optimize, Win, or Local stages |
| `/pro-seo lifecycle [stage] [url]` | SEO Lifecycle orchestrator: Discover, Plan, Build, Optimize, Authority, Measure, Iterate |
| `/pro-seo keywords <topic or url>` | Keyword research, intent mapping, prioritization matrix |
| `/pro-seo internal-links <url>` | Internal linking audit and opportunity map |
| `/pro-seo refresh <url>` | Content decay detection and refresh planning |
| `/pro-seo migration [plan\|validate] <url>` | Site migration SEO: redirect mapping and post-launch validation |
| `/pro-seo report <url>` | Client-ready SEO report from prior analyses and live data |
| `/pro-seo setup` | Explicitly create or refresh the isolated Python runtime and Chromium |
| `/pro-seo doctor` | Check runtime readiness without changing the system |

## Runtime Setup

Run setup only when the user explicitly invokes `/pro-seo setup` or explicitly asks
to repair dependencies. Execute `pro-seo setup`, report core and Chromium
status separately, and do not fall back to global or user package installation.
For diagnosis, execute `pro-seo doctor --json`; its output intentionally omits
absolute paths and environment values. If any `pro-seo run` command reports
that setup is required, suggest `/pro-seo setup` and do not improvise a `pip install`.

## Orchestration Logic

When the user invokes `/pro-seo audit`, delegate to subagents in parallel:
1. Detect business type (SaaS, local, ecommerce, publisher, agency, other)
2. Spawn subagents: pro-seo-technical, pro-seo-content, pro-seo-schema, pro-seo-sitemap, pro-seo-performance, pro-seo-visual, pro-seo-geo
3. If Google API credentials detected (`pro-seo run google_auth.py --check`), also spawn pro-seo-google agent
4. If local business detected, also spawn pro-seo-local agent
5. If local business detected AND DataForSEO MCP available, also spawn pro-seo-maps agent
6. If backlink APIs detected (`pro-seo run backlinks_auth.py --check`), also spawn pro-seo-backlinks agent
7. If Firecrawl MCP available, use `firecrawl_map` to discover all site URLs before analysis
8. If content strategy signals detected (blog, pillar pages, topic clusters), also spawn pro-seo-cluster agent
9. If e-commerce detected, also spawn pro-seo-ecommerce agent
10. If drift baseline exists for this URL (`pro-seo run drift_history.py <url>`), also spawn pro-seo-drift agent
11. Always include pro-seo-sxo in full audits (search experience applies to all sites)
12. Collect results and generate unified report with SEO Health Score (0-100)
13. **Synthesize via the 10-principle framework** (see "Synthesis Methodology" below), walk PERCEIVE → ANALYZE → VALIDATE → ACT before bucketing findings into Critical / High / Medium / Low
14. Create prioritized action plan with dependency sequencing + falsifiability per recommendation
15. **Offer PDF report**: "Generate a professional PDF report? Use `/pro-seo google report full`"

For individual commands, load the relevant sub-skill directly.
After any analysis command completes, offer to generate a PDF report via `scripts/google_report.py`.

## Synthesis Methodology

Audits are not just findings, they are findings synthesized into a coherent
strategy. pro-seo uses a 10-principle thinking framework grouped into four
phases: **PERCEIVE** (observe-external · observe-internal · listen),
**ANALYZE** (think · connect-lateral · connect-system), **VALIDATE** (feel ·
accept), **ACT** (create · grow).

Full audits (`/pro-seo audit`, `/pro-seo page`) walk every phase before emitting the
action plan. Narrower commands (`/pro-seo schema`, `/pro-seo images`, etc.) pass at
least THINK + ACCEPT before emitting (sound first principle, surfaced
falsifiability). The Critical / High / Medium / Low priority buckets are the
**output** of validation, not a substitute for it.

Full methodology + per-principle SEO mapping: `references/thinking-framework.md`.

Each emitted recommendation should carry:
- The first-principle observation it rests on (THINK)
- The dependency on / unblock relationship to other recommendations (CONNECT-system)
- An explicit "how would we know this failed?" check (ACCEPT)
- A leading indicator the user can monitor without re-running the audit (GROW)

## Industry Detection

Detect business type from homepage signals:
- **SaaS**: pricing page, /features, /integrations, /docs, "free trial", "sign up"
- **Local Service**: phone number, address, service area, "serving [city]", Google Maps embed --> auto-suggest `/pro-seo local` for deeper analysis
- **E-commerce**: /products, /collections, /cart, "add to cart", product schema
- **Publisher**: /blog, /articles, /topics, article schema, author pages, publication dates
- **Agency**: /case-studies, /portfolio, /industries, "our work", client logos

## Quality Gates

Read `references/quality-gates.md` for thin content thresholds per page type.
Hard rules:
- WARNING at 30+ location pages (enforce 60%+ unique content)
- HARD STOP at 50+ location pages (require user justification)
- Never recommend HowTo schema (deprecated Sept 2023)
- FAQ schema: Google retired FAQ rich results for ALL sites on May 7, 2026 (no SERP feature anymore; supersedes the Aug 2023 gov/health restriction). Flag existing FAQPage at Info (not Critical); do not claim confirmed AI/LLM citation benefit; do not recommend removal; do not recommend new FAQPage for Google SERP benefit; use QAPage for genuine user Q&A
- All Core Web Vitals references use INP, never FID


## Reference Files

Load these on-demand as needed (do NOT load all at startup):
- `references/cwv-thresholds.md`: Current Core Web Vitals thresholds and measurement details
- `references/schema-types.md`: All supported schema types with deprecation status
- `references/eeat-framework.md`: E-E-A-T evaluation criteria (Sept 2025 QRG update)
- `references/quality-gates.md`: Content length minimums, uniqueness thresholds
- `references/local-seo-signals.md`: Local ranking factors, review benchmarks, citation tiers, GBP status
- `references/local-schema-types.md`: LocalBusiness subtypes, industry-specific schema and citation sources

Maps-specific references (loaded by pro-seo-maps skill, not at startup):
- `references/maps-geo-grid.md`, `references/maps-gbp-checklist.md`, `references/maps-api-endpoints.md`, `references/maps-free-apis.md`

## Scoring Methodology

### SEO Health Score (0-100)
Weighted aggregate of all categories:

| Category | Weight |
|----------|--------|
| Technical SEO | 22% |
| Content Quality | 23% |
| On-Page SEO | 20% |
| Schema / Structured Data | 10% |
| Performance (CWV) | 10% |
| AI Search Readiness | 10% |
| Images | 5% |

### Priority Levels
- **Critical**: Blocks indexing or causes penalties (immediate fix required)
- **High**: Significantly impacts rankings (fix within 1 week)
- **Medium**: Optimization opportunity (fix within 1 month)
- **Low**: Nice to have (backlog)

## Sub-Skills

This skill orchestrates 31 sub-skills (28 core + 1 framework integration + 2 extension
mirrors). The orchestrator itself (`pro-seo`) is the 32nd in `skills/`, but does not
orchestrate itself, so it is not enumerated below.

1. **pro-seo-audit** -- Full website audit with parallel delegation
2. **pro-seo-page** -- Deep single-page analysis
3. **pro-seo-technical** -- Technical SEO (9 categories)
4. **pro-seo-content** -- E-E-A-T and content quality
5. **pro-seo-content-brief** -- Detailed SEO content brief generation
6. **pro-seo-schema** -- Schema markup detection and generation
7. **pro-seo-images** -- Image optimization, SERP analysis, file optimization
8. **pro-seo-sitemap** -- Sitemap analysis and generation
9. **pro-seo-geo** -- AI Overviews / GEO optimization
10. **pro-seo-plan** -- Strategic planning with templates
11. **pro-seo-programmatic** -- Programmatic SEO analysis and planning
12. **pro-seo-competitor-pages** -- Competitor comparison page generation
13. **pro-seo-hreflang** -- Hreflang/i18n SEO audit, cultural profiles, content parity
14. **pro-seo-local** -- Local SEO (GBP, NAP, citations, reviews, local schema, multi-location)
15. **pro-seo-maps** -- Maps intelligence (geo-grid, GBP audit, reviews, competitor radius)
16. **pro-seo-google** -- Google SEO APIs (GSC, PageSpeed, CrUX, Indexing API, GA4)
17. **pro-seo-backlinks** -- Backlink profile analysis (free: Moz, Bing, CC; premium: DataForSEO)
18. **pro-seo-cluster** -- SERP-based semantic clustering
19. **pro-seo-sxo** -- Search Experience Optimization
20. **pro-seo-drift** -- SEO drift monitoring
21. **pro-seo-ecommerce** -- E-commerce SEO intelligence
22. **pro-seo-dataforseo** -- Live SEO data via DataForSEO MCP (extension mirror)
23. **pro-seo-image-gen** -- AI image generation for SEO assets via Gemini (extension mirror)
24. **pro-seo-flow** -- FLOW framework integration (Find -> Leverage -> Optimize -> Win, 41 AI prompts, CC BY 4.0)
25. **pro-seo-lifecycle** -- SEO Lifecycle orchestrator (Discover -> Plan -> Build -> Optimize -> Authority -> Measure -> Iterate)
26. **pro-seo-keywords** -- Keyword research, intent mapping, prioritization matrix
27. **pro-seo-internal-links** -- Internal linking audit and opportunity map
28. **pro-seo-refresh** -- Content decay detection and refresh planning
29. **pro-seo-migration** -- Site migration SEO (redirect mapping, post-launch validation)
30. **pro-seo-report** -- Client-ready SEO reporting from prior analyses and live data

### Optional Extensions

The following ship in `extensions/` rather than `skills/` and require a separate
installer to activate (see each extension's `install.sh`/`install.ps1`):

All optional extensions are reachable through `/pro-seo` subcommands once
installed: firecrawl, dataforseo, and image-gen, plus `/pro-seo ahrefs`,
`/pro-seo bing`, `/pro-seo profound`, `/pro-seo seranking`, and `/pro-seo unlighthouse`.
Each installs as its own sub-skill, so the model also auto-routes to their
descriptions without the `/pro-seo` prefix.

- **pro-seo-firecrawl** -- Full-site crawling and site mapping via Firecrawl MCP. Install
  via `extensions/firecrawl/install.sh` (Unix) or `extensions/firecrawl/install.ps1`
  (Windows). Once installed, invoke via `/pro-seo firecrawl <command>`.

## Subagents

For parallel analysis during audits:
- `pro-seo-technical` -- Crawlability, indexability, security, CWV
- `pro-seo-content` -- E-E-A-T, readability, thin content
- `pro-seo-schema` -- Detection, validation, generation
- `pro-seo-sitemap` -- Structure, coverage, quality gates
- `pro-seo-performance` -- Core Web Vitals measurement
- `pro-seo-visual` -- Screenshots, mobile testing, above-fold
- `pro-seo-geo` -- AI crawler access, llms.txt, citability, brand mention signals
- `pro-seo-local` -- GBP signals, NAP consistency, reviews, local schema, industry-specific local factors (conditional: spawned when Local Service detected)
- `pro-seo-maps` -- Geo-grid rank tracking, GBP audit, review intelligence, competitor radius mapping (conditional: spawned when Local Service detected AND DataForSEO MCP available)
- `pro-seo-google` -- CWV field data, URL indexation status, organic traffic trends (conditional: spawned when Google API credentials detected)
- `pro-seo-backlinks` -- Backlink profile data: DA/PA, referring domains, anchor text, toxic links (conditional: spawned when Moz/Bing API keys detected or always for CC domain-level metrics)
- `pro-seo-cluster` -- Semantic clustering analysis (conditional: content strategy detected)
- `pro-seo-sxo` -- Page-type mismatch, user stories, persona scoring (always in full audits)
- `pro-seo-drift` -- Baseline comparison (conditional: drift baseline exists for URL)
- `pro-seo-ecommerce` -- Product schema, marketplace intel (conditional: e-commerce detected)
- `pro-seo-flow` -- FLOW framework prompts (conditional: spawned for content strategy workflows)
- `pro-seo-dataforseo` -- Live SERP, keyword, backlink, local SEO data (extension, optional)
- `pro-seo-image-gen` -- SEO image audit and generation plan (extension, optional)

## Error Handling

| Scenario | Action |
|----------|--------|
| Unrecognized command | List available commands from the Quick Reference table. Suggest the closest matching command. |
| URL unreachable | Report the error and suggest the user verify the URL. Do not attempt to guess site content. |
| Sub-skill fails during audit | Report partial results from successful sub-skills. Clearly note which sub-skill failed and why. Suggest re-running the failed sub-skill individually. |
| Ambiguous business type detection | Present the top two detected types with supporting signals. Ask the user to confirm before proceeding with industry-specific recommendations. |
