%{
  title: "Routinova.com: AI Content Automation Platform",
  description: "Automated AI content platform that handles topic discovery, creation, validation and distribution.",
  tags: ["elixir", "ai", "automation"],
  tech: ["Elixir", "Phoenix", "LiveView", "Oban", "PostgreSQL", "Cloudflare Workers", "Redis"],
  date: ~D[2025-01-15],
  featured: true,
  status: "live",
  metrics: [
    %{label: "DB Tables", value: "63"},
    %{label: "Oban Workers", value: "34"},
    %{label: "LiveView Pages", value: "35"},
    %{label: "AI Cost Reduction", value: "40-60%"}
  ],
  hero_image: nil
}
---

I built Routinova from scratch as an automated content platform that covers the whole content lifecycle: AI-powered topic discovery, crawling, rewriting, validation, publishing and distribution. It runs around the clock without manual steps.

The core challenge was orchestrating many moving parts into a reliable pipeline that scales without human intervention. Beyond AI text generation, that means crawling, deduplication, SEO optimization, quality validation and multi-channel distribution, all coordinated.

It is built on Elixir and Phoenix, with 63 database tables modeling the content domain. Oban runs 34 background workers, from AI content generation to social media posting. I implemented multi-provider AI orchestration across Gemini, DeepSeek and OpenRouter, with circuit breakers and automatic failover. Provider routing and prompt optimization cut AI costs by 40-60%.

Deployment is edge-first, using Cloudflare Workers. The SEO pipeline generates meta tags and manages sitemaps automatically, and social seeding covers Reddit, Pinterest and Twitter. The 35 LiveView pages form a real-time admin dashboard for monitoring each stage of the pipeline. Redis handles caching and rate limiting.

The platform runs on $20-50/month of infrastructure while producing and distributing content at scale, and one developer operates it.
