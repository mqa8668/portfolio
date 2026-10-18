%{
  title: "VNG Corporation: Infrastructure at Scale",
  description: "Eight years managing core server infrastructure at Vietnam's largest internet company, serving millions of concurrent users.",
  tags: ["infrastructure", "devops", "scale"],
  tech: ["Linux", "Nginx", "MySQL Clustering", "DNS", "Load Balancing", "SMTP"],
  date: ~D[2006-01-01],
  featured: false,
  status: "archived",
  metrics: [
    %{label: "Concurrent Users", value: "Millions"},
    %{label: "Tenure", value: "8 years"}
  ],
  hero_image: nil
}
---

I spent eight years as Web Framework Lead in the Game Division at VNG Corporation, running core server infrastructure at Vietnam's largest internet company and one of Southeast Asia's major tech firms. I was responsible for the foundational systems behind VNG's gaming, messaging and media platforms, which served millions of simultaneous users.

With millions of concurrent connections across multiple products, every infrastructure component had to scale horizontally, tolerate faults and recover quickly. There was no room for single points of failure, because downtime meant millions of users losing access.

My work covered DNS infrastructure for fast, reliable name resolution across Vietnam's varied network topology, load balancing layers that distributed traffic across server farms, and Nginx configurations tuned for high-concurrency workloads. I managed MySQL clustering that kept data consistent and available at scale, and tuned replication and sharding as data volumes grew with the user base.

I also operated the email SMTP gateway for transactional and marketing mail across VNG's products, and built payment infrastructure for the gaming portfolio's virtual currency and in-game purchases. All of these systems required deep Linux knowledge and an understanding of network protocols.

Those eight years still inform my architecture decisions. Knowing what happens at the bare-metal level, such as how connections are managed, how packets flow and how disks fail, shapes everything from my Kubernetes configurations to my Elixir application designs.
