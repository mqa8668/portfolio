%{
  title: "ERP & Analytics: Yeah1 Group",
  description: "Internal ERP system with real-time analytics dashboards that pull from the Facebook and YouTube APIs, built for a Vietnamese media group.",
  tags: ["elixir", "enterprise"],
  tech: ["Elixir", "Phoenix", "GenServer", "WebSocket", "PostgreSQL"],
  date: ~D[2017-06-01],
  featured: false,
  status: "archived",
  metrics: [
    %{label: "API Integrations", value: "Facebook + YouTube"},
    %{label: "Dashboards", value: "Real-time"}
  ],
  hero_image: nil
}
---

As a Full-Stack Developer at Yeah1 Group, I built the internal ERP system, including real-time analytics dashboards and financial management tools for one of Vietnam's largest multi-channel media networks. The dashboards showed leadership how content was performing across the group's YouTube channels and Facebook pages.

The main problem was aggregating data from two external APIs, the Facebook Graph API and the YouTube Data API, into one analytics view that updated in real time. Content decisions had to rest on current performance data, not yesterday's reports, and request-response dashboards were too slow for the team's workflow.

 When data arrived from the external APIs, every connected browser updated. GenServers handled concurrent API polling and aggregation. Each integration ran as its own supervised process, so an API failure did not affect the other data streams.

The ERP modules covered revenue tracking, cost allocation and creator payment processing. Because the finance data sat next to the analytics data, the finance team could correlate content performance with revenue when deciding on content investment and creator partnerships.

This was an early use of Elixir and Phoenix in the Vietnamese tech ecosystem. The BEAM's real-time capabilities and fault tolerance suited a media analytics platform, and the system ran reliably throughout its operational period.
