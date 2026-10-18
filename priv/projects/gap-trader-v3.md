%{
  title: "Gap Trader V3: Binance Trading Bot (Work in Progress)",
  description: "Personal Elixir project: a supervised Binance REST and WebSocket client layer, with strategy components designed but not yet built.",
  tags: ["elixir", "trading", "otp"],
  tech: ["Elixir", "Phoenix", "LiveView", "WebSockex", "Decimal"],
  date: ~D[2025-04-01],
  featured: false,
  status: "development",
  metrics: [
    %{label: "Tests", value: "~60"},
    %{label: "Built", value: "REST client, WebSocket streams"},
    %{label: "Designed, not built", value: "Gap detection, risk engine, persistence, LLM reviewer"}
  ],
  hero_image: nil
}
---

Gap Trader V3 is a personal project exploring a Binance trading bot in Elixir. It is early-stage and does not trade. This page describes what exists today and what is only designed.

## What is built

- A Binance REST client with a response cache and an error classifier that separates retryable failures from permanent ones.
- Supervised WebSocket market and user data streams built on WebSockex, restarted by OTP supervisors when a connection drops.
- About 60 tests covering these two layers.

## What is designed but not implemented

- Gap detection on incoming market data.
- A risk engine that checks every proposed order.
- Persistence. There is no database yet.
- An LLM reviewer that can approve, veto or resize a proposed trade. By design it never places orders itself.

## Stack

Elixir, Phoenix, LiveView, WebSockex and Decimal for exact price and quantity arithmetic.
