%{
  title: "Helios: Binance Algorithmic Trading System",
  description: "Custom algorithmic trading system for Binance USDT-M Futures, built on OTP with real-time risk management.",
  tags: ["elixir", "trading", "otp"],
  tech: ["Elixir", "OTP", "GenServer", "WebSocket", "PostgreSQL", "ETS"],
  date: ~D[2025-02-01],
  featured: true,
  status: "live",
  metrics: [
    %{label: "Pipeline Phases", value: "8"},
    %{label: "Risk Management", value: "Real-time"},
    %{label: "Safety Systems", value: "KillSwitch + LiquidationMonitor"}
  ],
  hero_image: nil
}
---

I designed and built Helios as a custom algorithmic trading system for Binance. It started with Spot Margin trading and later moved to USDT-M Futures for better capital efficiency and risk control. It uses OTP throughout, which fits the fault-tolerance and concurrency demands of live trading.

A trading system has to handle several concerns at once: real-time market data ingestion, signal generation, order execution, position monitoring and risk management. A failure in one component must not cascade into large losses.

The architecture is an 8-phase pipeline: signal detection, pre-entry validation, borrow/order placement, fill monitoring, position tracking, exit signal detection, order closure and repayment. Dedicated GenServers manage each phase, keep their own state and communicate through well-defined messages. Market data arrives over WebSocket connections to Binance's fstream endpoints, and ETS gives microsecond-latency access to the latest order book and candlestick data.

The risk layer has three independent safety systems. A KillSwitch flattens all positions when it detects anomalous conditions. A LiquidationMonitor tracks margin ratios and triggers exits before liquidation. An ExposureTracker enforces position sizing limits across the whole portfolio. They run independently of the trading logic, so a bug in a strategy cannot disable them.

A paper trading mode validates strategies against live market data without risking capital. The system persists all trades, signals and risk events to PostgreSQL for analysis after each session.
