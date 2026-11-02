# Commands Reference

## Overview

All ProSEO commands start with `/pro-seo` followed by a subcommand.

## Command List

### `/pro-seo setup`

Explicitly create or refresh the isolated Python runtime and Playwright Chromium.
This is required once after a marketplace plugin install. Manual installers run
the same setup automatically. It never installs packages globally.

### `/pro-seo doctor`

Check runtime, dependency, and Chromium readiness without changing the system.
Diagnostic output omits absolute paths and environment values.

### `/pro-seo audit <url>`

Full website SEO audit with parallel analysis.

**Example:**
```
/pro-seo audit https://example.com
```

**What it does:**
1. Crawls up to 500 pages
2. Detects business type
3. Delegates to up to 15 specialist subagents in parallel (8 always-on + 7 conditional)
4. Generates SEO Health Score (0-100)
5. Creates prioritized action plan

**Output:**
- `FULL-AUDIT-REPORT.md`
- `ACTION-PLAN.md`
- `screenshots/` (if Playwright available)

---

### `/pro-seo page <url>`

Deep single-page analysis.

**Example:**
```
/pro-seo page https://example.com/about
```

**What it analyzes:**
- On-page SEO (title, meta, headings, URLs)
- Content quality (word count, readability, E-E-A-T)
- Technical elements (canonical, robots, Open Graph)
- Schema markup
- Images (alt text, sizes, formats)
- Core Web Vitals potential issues

---

### `/pro-seo technical <url>`

Technical SEO audit across 9 categories.

**Example:**
```
/pro-seo technical https://example.com
```

**Categories:**
1. Crawlability
2. Indexability
3. Security
4. URL Structure
5. Mobile Optimization
6. Core Web Vitals (LCP, INP, CLS)
7. Structured Data
8. JavaScript Rendering
9. IndexNow Protocol

---

### `/pro-seo content <url>`

E-E-A-T and content quality analysis.

**Example:**
```
/pro-seo content https://example.com/blog/post
```

**What it evaluates:**
- Experience signals (first-hand knowledge)
- Expertise (author credentials)
- Authoritativeness (external recognition)
- Trustworthiness (transparency, security)
- AI citation readiness
- Content freshness

---

### `/pro-seo content-brief <topic or url>`

Generate a detailed SEO content brief: target keywords, search intent, heading outline, internal link targets, and competitor angle.

**Example:**
```
/pro-seo content-brief "best running shoes for flat feet"
```

**What it produces:**
- Primary and secondary target keywords
- Search intent and audience
- Section-by-section heading outline
- Internal link recommendations
- Competitor content angles to beat

---

### `/pro-seo schema <url>`

Schema markup detection, validation, and generation.

**Example:**
```
/pro-seo schema https://example.com
```

**What it does:**
- Detects existing schema (JSON-LD, Microdata, RDFa)
- Validates against Google's requirements
- Identifies missing opportunities
- Generates ready-to-use JSON-LD

---

### `/pro-seo geo <url>`

AI Overviews / Generative Engine Optimization.

**Example:**
```
/pro-seo geo https://example.com/blog/guide
```

**What it analyzes:**
- Citability score (quotable facts, statistics)
- Structural readability (headings, lists, tables)
- Entity clarity (definitions, context)
- Authority signals (credentials, sources)
- Structured data support

---

### `/pro-seo images <url>`

Image optimization analysis. Subcommands: `serp <keyword>` (image SERP / visual-search analysis), `optimize <path>` (local file optimization + IPTC AI labeling).

**Examples:**
```
/pro-seo images https://example.com
/pro-seo images serp "running shoes"
/pro-seo images optimize ./hero.webp
```

**What it checks:**
- Alt text presence and quality
- File sizes (flag >200KB)
- Formats (WebP/AVIF recommendations)
- Responsive images (srcset, sizes)
- Lazy loading
- CLS prevention (dimensions)

---

### `/pro-seo sitemap <url>`

Analyze existing XML sitemap.

**Example:**
```
/pro-seo sitemap https://example.com/sitemap.xml
```

**What it validates:**
- XML format
- URL count (<50k per file)
- URL status codes
- lastmod accuracy
- Deprecated tags (priority, changefreq)
- Coverage vs crawled pages

---

### `/pro-seo sitemap generate`

Generate new sitemap with industry templates.

**Example:**
```
/pro-seo sitemap generate
```

**Process:**
1. Select or auto-detect business type
2. Interactive structure planning
3. Apply quality gates (30/50 location page limits)
4. Generate valid XML
5. Create documentation

---

### `/pro-seo plan <type>`

Strategic SEO planning.

**Types:** `saas`, `local`, `ecommerce`, `publisher`, `agency`

**Example:**
```
/pro-seo plan saas
```

**What it creates:**
- Complete SEO strategy
- Competitive analysis
- Content calendar
- Implementation roadmap (4 phases)
- Site architecture design

---

### `/pro-seo competitor-pages [url|generate]`

Competitor comparison page generation.

**Examples:**
```
/pro-seo competitor-pages https://example.com/vs/competitor
/pro-seo competitor-pages generate
```

**Capabilities:**
- Generate "X vs Y" comparison page layouts
- Create "Alternatives to X" page structures
- Build feature comparison matrices with scoring
- Generate Product + AggregateRating schema markup
- Apply conversion-optimized CTA placement
- Enforce fairness guidelines (accurate data, source citations)

---

### `/pro-seo hreflang [url]`

Hreflang and international SEO audit and generation. Subcommand: `audit <directory-or-url>` (audit hreflang across a local build directory or a live URL set).

**Examples:**
```
/pro-seo hreflang https://example.com
/pro-seo hreflang audit ./dist
```

**Capabilities:**
- Validate self-referencing hreflang tags
- Check return tag reciprocity (A→B requires B→A)
- Verify x-default tag presence
- Validate ISO 639-1 language and ISO 3166-1 region codes
- Check canonical URL alignment with hreflang
- Detect protocol mismatches (HTTP vs HTTPS)
- Generate correct hreflang link tags and sitemap XML

---

### `/pro-seo programmatic [url|plan]`

Programmatic SEO analysis and planning for pages generated at scale.

**Examples:**
```
/pro-seo programmatic https://example.com/tools/
/pro-seo programmatic plan
```

**Capabilities:**
- Assess data source quality (CSV, JSON, API, database)
- Plan template engines with unique content per page
- Design URL pattern strategies (`/tools/[tool-name]`, `/[city]/[service]`)
- Automate internal linking (hub/spoke, related items, breadcrumbs)
- Enforce thin content safeguards (quality gates, word count thresholds)
- Prevent index bloat (noindex low-value, pagination, faceted nav)

---

### `/pro-seo local <url>`

Local SEO analysis covering Google Business Profile, citations, reviews, and the map pack.

**Example:**
```
/pro-seo local https://example.com
```

**What it analyzes:**
- Google Business Profile signals (categories, hours, photos, posts)
- NAP (Name, Address, Phone) consistency across the page and external citations
- Review velocity, response rate, and sentiment
- Local schema markup (LocalBusiness, Restaurant, Service-specific types)
- Industry-specific local factors (brick-and-mortar, SAB, hybrid)
- Map pack visibility signals

---

### `/pro-seo maps [command] [args]`

Maps intelligence: geo-grid rank tracking, GBP profile audits, review intelligence, cross-platform NAP verification, competitor radius mapping.

**Examples:**
```
/pro-seo maps "Joe's Coffee" "austin tx"
/pro-seo maps grid "coffee shop" "austin tx"
/pro-seo maps gbp "Joe's Coffee" "austin tx"
/pro-seo maps reviews "Joe's Coffee" "austin tx"
/pro-seo maps competitors "auto repair" "denver"
/pro-seo maps nap "Joe's Coffee" "austin tx"
/pro-seo maps schema "Joe's Coffee" "austin tx"
```

**Capabilities:**
- Rank tracking on a geographic grid (typically 49 points)
- GBP profile audit with completeness scoring
- Review aggregation across Google, Yelp, Facebook, Bing
- Competitor discovery within a configurable radius

---

### `/pro-seo backlinks <url>`

Backlink profile analysis with a 3-tier data cascade: free (Common Crawl + verification), free with signup (Moz, Bing Webmaster Tools), paid (DataForSEO).

**Examples:**
```
/pro-seo backlinks https://example.com
/pro-seo backlinks gap https://example.com https://competitor.com
/pro-seo backlinks toxic https://example.com
/pro-seo backlinks new https://example.com
/pro-seo backlinks verify https://example.com --links known-links.txt
/pro-seo backlinks setup
```

**What it analyzes:**
- Domain Authority and Page Authority (Moz)
- Referring domain count and growth
- Anchor text distribution (branded, exact, partial, naked URL)
- Toxic / spammy backlink detection
- Lost backlinks
- Competitor link gap

---

### `/pro-seo cluster [command] <seed-keyword>`

SERP-based semantic topic clustering for content architecture planning. Subcommands: `plan <seed>` (full planning workflow; also `plan --from strategy` to import a `/pro-seo plan` output), `execute` (create content via claude-blog or output briefs), `map` (regenerate the interactive visualization). Bare `/pro-seo cluster <seed>` is shorthand for `plan`.

**Examples:**
```
/pro-seo cluster plan "claude code skills"
/pro-seo cluster plan --from strategy
/pro-seo cluster execute
/pro-seo cluster map
```

**What it produces:**
- Keyword expansion from the seed (50-200 candidates)
- Pairwise SERP overlap comparison to detect semantic clusters
- Intent classification per cluster (informational, commercial, transactional, navigational)
- Hub-and-spoke content architecture proposal
- Internal link matrix between cluster pages
- Interactive `cluster-map.html` visualization

---

### `/pro-seo sxo <url>`

Search Experience Optimization: SERP backwards analysis, page-type mismatch detection, persona scoring. Subcommands: `<url> <keyword>` (analyze for a specific keyword), `wireframe <url>` (IST/SOLL wireframe), `personas <url>` (persona-only scoring, skips SERP).

**Examples:**
```
/pro-seo sxo https://example.com/blog/how-to-x
/pro-seo sxo https://example.com/page "target keyword"
/pro-seo sxo wireframe https://example.com/page
/pro-seo sxo personas https://example.com/page
```

**What it produces:**
- Page-type taxonomy classification (article, landing, product, tool, listing)
- SERP intent vs page-type alignment check
- User stories derived from SERP signals
- Multi-persona scoring (researcher, buyer, expert, casual visitor)
- Wireframe-level recommendations for fixing mismatches

---

### `/pro-seo drift baseline|compare|history <url>`

SEO drift monitoring. Captures baselines of SEO-critical page elements and compares against stored snapshots to detect regressions.

**Examples:**
```
/pro-seo drift baseline https://example.com
/pro-seo drift compare https://example.com
/pro-seo drift history https://example.com
```

**What it tracks:** title, meta description, canonical, hreflang, Open Graph, schema, headings, internal links, robots, sitemap entry, indexability, Core Web Vitals, response status, redirect chain.

**17 comparison rules** classify changes by severity (CRITICAL, HIGH, MEDIUM). SQLite-backed baselines.

---

### `/pro-seo ecommerce <url>`

E-commerce SEO covering product schema, marketplace intelligence, and pricing gap analysis. Subcommands: `products <keyword>` (Google Shopping competitive analysis), `gaps <domain>` (organic-vs-Shopping visibility gap), `schema <url>` (product schema validation + enhancement).

**Examples:**
```
/pro-seo ecommerce https://shop.example.com/product/x
/pro-seo ecommerce products "running shoes"
/pro-seo ecommerce gaps shop.example.com
/pro-seo ecommerce schema https://shop.example.com/product/x
```

**What it analyzes:**
- Product schema (Product, Offer, AggregateRating, Review)
- Google Shopping visibility
- Amazon marketplace presence
- Pricing gap vs competitors
- Out-of-stock and availability signals
- Faceted navigation crawl traps

---

### `/pro-seo lifecycle [stage] [url]`

SEO Lifecycle orchestrator: a staged, end-to-end SEO program. Runs Discover → Plan → Build → Optimize → Authority → Measure → Iterate, delegating each stage to the right sub-skills and persisting progress in `pro-seo-lifecycle.json`. Takes the site from the `[url]` argument, or from `site` in an existing `pro-seo-lifecycle.json`; asks when neither is present.

**Examples:**
```
/pro-seo lifecycle
/pro-seo lifecycle discover
/pro-seo lifecycle optimize https://example.com
/pro-seo lifecycle status
```

---

### `/pro-seo keywords <topic or url>`

Keyword research and prioritization: seed expansion, intent mapping, difficulty/opportunity scoring, and a prioritized keyword matrix. Uses Keyword Planner and GSC data when credentials are configured.

**Examples:**
```
/pro-seo keywords "project management software"
/pro-seo keywords https://example.com/services
```

---

### `/pro-seo internal-links <url>`

Internal linking audit: maps the internal link graph, finds orphan pages, under-linked money pages, weak hubs, and generic anchors, and outputs specific link additions with anchor text.

**Examples:**
```
/pro-seo internal-links https://example.com
```

---

### `/pro-seo refresh <url>`

Content decay detection and refresh planning: finds pages losing clicks or rankings, diagnoses the cause (staleness, SERP shift, cannibalization, technical regression), and produces a prioritized refresh queue.

**Examples:**
```
/pro-seo refresh https://example.com
```

---

### `/pro-seo migration [plan|validate] <url>`

Site migration SEO. `plan` builds the URL inventory, redirect map, and pre-launch checklist before a domain change or replatform; `validate` verifies redirects, coverage, parity, and indexation after launch.

**Examples:**
```
/pro-seo migration plan https://example.com
/pro-seo migration validate https://new.example.com
```

---

### `/pro-seo report <url>`

Client-ready SEO report: executive summary, period-over-period performance, cause attribution, issues, and a prioritized roadmap, as Markdown or a styled HTML artifact.

**Examples:**
```
/pro-seo report https://example.com
```

---

### `/pro-seo flow [stage] [url|topic]`

FLOW framework integration: evidence-led prompts for the Find, Leverage, Optimize, Win, and Local stages of a content campaign.

**Examples:**
```
/pro-seo flow find "topic"
/pro-seo flow leverage https://example.com
/pro-seo flow optimize https://example.com/page
/pro-seo flow win https://example.com/page
/pro-seo flow local https://example.com
/pro-seo flow prompts
/pro-seo flow sync
```

**41 prompts** sourced from FLOW (CC BY 4.0). Each prompt is grounded in a specific evidence source (SERP data, GSC, GA4, customer interviews) with attribution preserved.

---

### `/pro-seo google [command] [url]`

Google SEO APIs. 4-tier credential system covering PageSpeed Insights, CrUX, CrUX History, Search Console, URL Inspection, Indexing API, GA4, and Keyword Planner.

**Setup & reporting:**
```
/pro-seo google setup                      # Configure/check credentials
/pro-seo google quotas                     # Show per-API quota usage
/pro-seo google report full                # Generate full PDF/HTML report
/pro-seo google report cwv-audit           # CWV-focused report
/pro-seo google report gsc-performance     # Search performance report
/pro-seo google report indexation          # Indexation status report
```

**PageSpeed / CrUX (Tier 0):**
```
/pro-seo google pagespeed <url>            # PageSpeed Insights (lab) + CWV
/pro-seo google crux <url>                 # CrUX field data
/pro-seo google crux-history <url>         # 25-week CrUX history
```

**Search Console / Indexing (Tier 1):**
```
/pro-seo google gsc <property>             # Search Analytics (clicks/impressions/CTR/position)
/pro-seo google inspect <url>              # URL Inspection (indexation status)
/pro-seo google inspect-batch <file>       # Batch URL inspection
/pro-seo google sitemaps <property>        # List submitted sitemaps + status
/pro-seo google index <url>                # Indexing API notify
/pro-seo google index-batch <file>         # Batch indexing notify
```
Use Indexing API commands only for pages with JobPosting or BroadcastEvent embedded in VideoObject. Route ordinary URLs to URL Inspection or sitemaps; `URL_UPDATED` does not guarantee indexing.

**GA4 (Tier 2):**
```
/pro-seo google ga4 [property-id]          # Organic traffic report
/pro-seo google ga4-pages [property-id]    # Top organic landing pages
```

**NLP / Keywords / YouTube:**
```
/pro-seo google nlp <url-or-text>          # NLP content analysis
/pro-seo google entities <url-or-text>     # Entity extraction
/pro-seo google entity <query>             # Entity lookup
/pro-seo google keywords <seed>            # Keyword Planner ideas (Tier 3)
/pro-seo google volume <keywords>          # Keyword search volume (Tier 3)
/pro-seo google youtube <query>            # YouTube search
/pro-seo google youtube-video <video_id>   # YouTube video analysis
/pro-seo google safety <url>               # Safe Browsing check
```

**Tiers:**
- Tier 0 (API key only): PSI, CrUX, CrUX History
- Tier 1 (+ OAuth or Service Account): GSC, URL Inspection, Indexing API
- Tier 2 (+ GA4 property config): GA4 organic traffic
- Tier 3 (+ Google Ads developer token): Keyword Planner

PDF and HTML reports generated via WeasyPrint and matplotlib.

---

### `/pro-seo image-gen [use-case] <description>`

AI image generation for SEO assets (extension). Powered by Gemini via nanobanana-mcp.

**Prerequisites:** Banana extension installed (`./extensions/banana/install.sh`)

**Use Cases:**
```
/pro-seo image-gen og <description>          # OG/social preview image (16:9, 1K)
/pro-seo image-gen hero <description>        # Blog hero image (16:9, 2K)
/pro-seo image-gen product <description>     # Product photography (4:3, 2K)
/pro-seo image-gen infographic <description> # Infographic visual (2:3, 4K)
/pro-seo image-gen custom <description>      # Custom with full Creative Director pipeline
/pro-seo image-gen batch <description> [N]   # Generate N variations (default: 3)
```

**What it does:**
1. Maps SEO use case to optimized domain mode, aspect ratio, and resolution
2. Constructs 6-component Reasoning Brief (Creative Director pipeline)
3. Generates image via Gemini API
4. Provides SEO checklist (alt text, file naming, WebP, schema markup)

---

### `/pro-seo firecrawl [command] <url>`

Full-site crawling and URL discovery via Firecrawl MCP (extension).

**Prerequisites:** Firecrawl extension installed (`./extensions/firecrawl/install.sh`)

**Examples:**
```
/pro-seo firecrawl crawl https://example.com
/pro-seo firecrawl map https://example.com
/pro-seo firecrawl scrape https://example.com/page
/pro-seo firecrawl search "query" https://example.com
```

**What it does:**
- `crawl` walks the site discovering URLs and capturing content
- `map` returns the full URL inventory for a domain
- `scrape` extracts a single page in a model-friendly format
- `search` searches within a crawled site for a query

---

### `/pro-seo dataforseo [command]`

Live SEO data via DataForSEO MCP server (extension). 23 data commands across 9 API modules, plus cost-tracking commands.

**Prerequisites:** DataForSEO extension installed (`./extensions/dataforseo/install.sh`)

**SERP Analysis:**
```
/pro-seo dataforseo serp <keyword>              # Google organic results (also Bing/Yahoo)
/pro-seo dataforseo serp-images <keyword>       # Google Images SERP results
/pro-seo dataforseo serp-youtube <keyword>      # YouTube search results
/pro-seo dataforseo youtube <video_id>          # YouTube video deep analysis
```

**Keyword Research:**
```
/pro-seo dataforseo keywords <seed>             # Keyword ideas and suggestions
/pro-seo dataforseo volume <keywords>           # Search volume metrics
/pro-seo dataforseo difficulty <keywords>       # Keyword difficulty scores
/pro-seo dataforseo intent <keywords>           # Search intent classification
/pro-seo dataforseo trends <keyword>            # Google Trends data
```

**Domain & Competitors:**
```
/pro-seo dataforseo backlinks <domain>          # Full backlink profile
/pro-seo dataforseo competitors <domain>        # Competitor analysis
/pro-seo dataforseo ranked <domain>             # Ranked keywords
/pro-seo dataforseo intersection <domains>      # Keyword/backlink overlap
/pro-seo dataforseo traffic <domains>           # Traffic estimation
/pro-seo dataforseo subdomains <domain>         # Subdomains with ranking data
/pro-seo dataforseo top-searches <domain>       # Top queries mentioning domain
```

**Technical / On-Page:**
```
/pro-seo dataforseo onpage <url>                # On-page analysis (Lighthouse)
/pro-seo dataforseo tech <domain>               # Technology detection
/pro-seo dataforseo whois <domain>              # WHOIS data
```

**Content & Business Data:**
```
/pro-seo dataforseo content <keyword/url>       # Content analysis and trends
/pro-seo dataforseo listings <keyword>          # Business listings search
```

**AI Visibility / GEO:**
```
/pro-seo dataforseo ai-scrape <query>           # ChatGPT web scraper for GEO
/pro-seo dataforseo ai-mentions <keyword>       # LLM mention tracking
```

**Cost Tracking:**
```
/pro-seo dataforseo costs today                            # Today's DataForSEO spend
/pro-seo dataforseo costs summary                          # Spend summary across periods
/pro-seo dataforseo costs config --mode threshold --threshold 0.50   # Set cost-control mode/threshold
```

---

### `/pro-seo ahrefs [command] <url|topic>`

Ahrefs API metrics (extension). **Prerequisites:** Ahrefs extension installed (`./extensions/ahrefs/install.sh`).
```
/pro-seo ahrefs metrics <url>       # DR/UR, referring-domain count, organic traffic estimate
/pro-seo ahrefs backlinks <url>     # Top referring domains, anchor distribution, follow/nofollow ratio
/pro-seo ahrefs organic <url>       # Organic keywords, ranking distribution, traffic by country
/pro-seo ahrefs content <topic>     # Content Explorer top results, social shares, referring domains
```

---

### `/pro-seo bing [command]`

Bing Webmaster Tools + IndexNow (extension). **Prerequisites:** Bing extension installed (`./extensions/bing-webmaster/install.sh`).
```
/pro-seo bing links <url>                 # Inbound links from Bing Webmaster
/pro-seo bing compare <urlA> <urlB>       # Compare two URLs' Bing link profiles
/pro-seo bing submit <url> --host <host>                # IndexNow single-URL submit (requires key)
/pro-seo bing submit-batch <file> --host <host>         # IndexNow batch submit (requires key)
/pro-seo bing verify-indexnow --host <host>             # Verify the IndexNow key is published
```

---

### `/pro-seo profound [command] <brand>`

LLM brand-citation tracking via Profound (extension). **Prerequisites:** Profound extension installed.
```
/pro-seo profound citations <brand>     # Citation rate per LLM + 30-day trend
/pro-seo profound prompts <brand>       # Top prompts that surface (or miss) the brand
/pro-seo profound competitors <brand>   # Brands cited alongside yours for the same prompts
/pro-seo profound alerts <brand>        # Spike/drop alerts vs 7-day baseline
```

---

### `/pro-seo seranking [command] <brand|keyword|url>`

AI-visibility + SERP via SE Ranking (extension). **Prerequisites:** SE Ranking extension installed.
```
/pro-seo seranking ai-visibility <brand>   # Share-of-voice across ChatGPT/Gemini/Perplexity/AI Overviews/AI Mode
/pro-seo seranking serp <keyword>          # Top 100 organic positions + SERP features
/pro-seo seranking backlinks <url>         # Backlink profile (free-tier alternative to Ahrefs/DataForSEO)
/pro-seo seranking competitors <url>       # Top 10 organic competitors + shared-keyword gaps
```

---

### `/pro-seo unlighthouse <url>`

Multi-page Lighthouse audit via Unlighthouse (extension, MIT, no API quota). **Prerequisites:** Node 18+ and the unlighthouse npm package (`./extensions/unlighthouse/install.sh`).
```
/pro-seo unlighthouse https://example.com
/pro-seo unlighthouse https://example.com --device desktop
/pro-seo unlighthouse https://example.com --max-routes 50 --output-dir ./reports
```

---

## Quick Reference

| Command | Use Case |
|---------|----------|
| `/pro-seo audit <url>` | Full website audit with parallel subagents |
| `/pro-seo page <url>` | Single page analysis |
| `/pro-seo technical <url>` | Technical SEO across 9 categories |
| `/pro-seo content <url>` | E-E-A-T and content quality |
| `/pro-seo content-brief <topic>` | Detailed content brief: keywords, outline, internal links |
| `/pro-seo schema <url>` | Schema markup detection, validation, generation |
| `/pro-seo sitemap <url>` | Sitemap validation |
| `/pro-seo sitemap generate` | Create new sitemap with industry templates |
| `/pro-seo images <url>` | Image optimization |
| `/pro-seo geo <url>` | AI search optimization (GEO) |
| `/pro-seo local <url>` | Local SEO (GBP, citations, reviews) |
| `/pro-seo maps [command]` | Maps intelligence (geo-grid, GBP audit, competitors) |
| `/pro-seo backlinks <url>` | Backlink profile analysis |
| `/pro-seo cluster <seed>` | SERP-based semantic clustering |
| `/pro-seo sxo <url>` | Search Experience Optimization |
| `/pro-seo drift baseline\|compare\|history <url>` | SEO drift monitoring |
| `/pro-seo ecommerce <url>` | E-commerce SEO |
| `/pro-seo hreflang [url]` | Hreflang and international SEO |
| `/pro-seo plan <type>` | Strategic planning by industry |
| `/pro-seo programmatic [url\|plan]` | Programmatic SEO analysis |
| `/pro-seo competitor-pages [url\|generate]` | Competitor comparison pages |
| `/pro-seo flow [stage] [url\|topic]` | FLOW framework prompts |
| `/pro-seo lifecycle [stage] [url]` | SEO Lifecycle orchestrator (7 stages) |
| `/pro-seo keywords <topic or url>` | Keyword research and prioritization |
| `/pro-seo internal-links <url>` | Internal linking audit and opportunity map |
| `/pro-seo refresh <url>` | Content decay detection and refresh planning |
| `/pro-seo migration [plan\|validate] <url>` | Site migration SEO |
| `/pro-seo report <url>` | Client-ready SEO report |
| `/pro-seo google [command] [url]` | Google SEO APIs (GSC, PSI, CrUX, GA4) |
| `/pro-seo dataforseo [command]` | Live SEO data (extension) |
| `/pro-seo image-gen [use-case] <desc>` | AI image generation (extension) |
| `/pro-seo firecrawl [command] <url>` | Full-site crawling (extension) |
| `/pro-seo ahrefs [command] <url>` | Backlinks, organic keywords, and content data via the official Ahrefs MCP (extension) |
| `/pro-seo seranking [command]` | AI Share-of-Voice across ChatGPT, Gemini, Perplexity, AI Overviews, AI Mode (extension) |
| `/pro-seo profound [command]` | LLM citation tracking with time-series data (extension) |
| `/pro-seo bing [command] <url>` | Bing Webmaster Tools + IndexNow URL submission (extension) |
| `/pro-seo unlighthouse <url>` | Multi-page Lighthouse runner, runs locally (extension) |
