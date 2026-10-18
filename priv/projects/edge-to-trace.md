%{
  title: "edge-to-trace: From the Edge to the Slow Span",
  description: "A runnable observability lab: SLO burn-rate alerts, exemplars, traces and logs wired together, with eBPF and SDK instrumentation side by side.",
  tags: ["devops", "observability", "sre"],
  tech: ["OpenTelemetry", "Prometheus", "Tempo", "Loki", "Grafana", "Beyla (eBPF)", "Docker Compose", "Elixir", "Go", "Python"],
  date: ~D[2026-10-01],
  featured: true,
  status: "live",
  metrics: [
    %{label: "Runs on", value: "Docker Compose"},
    %{label: "Docker memory", value: "about 4 GiB"},
    %{label: "Version", value: "0.1 (lite profile)"}
  ],
  hero_image: nil
}
---

Source: [github.com/mqa8668/edge-to-trace](https://github.com/mqa8668/edge-to-trace)

## Problem

Alerting on raw thresholds tells you something is wrong but not where. Going from a latency graph to the one slow span and its logs usually means jumping between tools and guessing at timestamps. I wanted a small lab where that path is a few clicks and every alert has a runbook.

## Features

- Alerts based on SLOs, not raw thresholds: multi-window burn-rate rules generated from a spec and unit-tested.
- One click from a latency graph to the trace to the logs of that request, using exemplars and `trace_id`.
- eBPF (Beyla) and the OpenTelemetry SDK side by side, so you can see where each one works. The `catalog` service has no tracing code; Beyla produces its spans from the kernel.
- A collector that computes RED metrics before sampling, so the SLO does not change when sampling does.
- Every alert has a runbook and a tested path to a notification (Alertmanager, with optional Telegram).

## The demo scenario

1. Baseline traffic from k6 at 5 requests per second. The SLO dashboard is green.
2. `make chaos-latency` adds 800 ms to 60% of calls to the `recs` service.
3. The `StorefrontLatencyBurn` page alert fires.
4. Click an exemplar dot on the latency panel. The trace opens in Tempo, and the `recs.rank_candidates` span shows the 800 ms and `chaos.injected=true`.
5. Click through to the logs of the same trace in Loki.
6. `make chaos-reset` resolves the alert.

## Stack

Demo services: storefront (Elixir/Phoenix), recs (Python/FastAPI), catalog (Go), Postgres. Telemetry: OpenTelemetry Collector, Prometheus, Tempo, Loki, Alloy, Alertmanager, Grafana, Beyla. Container hardening: ports bound to localhost, no default credentials, third-party images pinned by digest.

## Run it

You need Docker with Compose v2, `make`, `openssl`, and about 4 GiB of memory for Docker.

```
git clone https://github.com/mqa8668/edge-to-trace.git
cd edge-to-trace
make demo
```

`make demo` starts the stack and walks through the scenario above. `make demo-reset` undoes it.

## Status

Version 0.1 covers the `lite` profile. An edge profile (HAProxy, WAF, Suricata), a SIEM profile and a Kubernetes profile are planned and not built yet.
