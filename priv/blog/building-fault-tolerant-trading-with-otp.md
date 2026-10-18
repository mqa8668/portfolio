%{
  title: "Building Fault-Tolerant Trading Systems with OTP",
  description: "How OTP supervision trees, GenServers and process isolation help a trading system recover from failures, based on building Helios in Elixir.",
  tags: ["elixir", "otp", "trading"],
  date: ~D[2025-03-15]
}
---

Trading systems cannot afford uncontrolled downtime. A crashed order manager or a frozen price feed can turn directly into financial loss. After building Helios, a real-time trading engine in Elixir, I think OTP is the best foundation for this kind of problem.

## Why "let it crash" works for finance

"Let it crash" sounds alarming for a financial system, but it does not mean being careless about errors. It means being deliberate about recovery. Instead of writing defensive code that tries to anticipate every error, you build a system that recovers automatically from failures.

In a traditional trading system written in Java or C++, a null pointer exception in the order routing module can bring down the entire process. In Elixir, a crash in one GenServer is isolated to that process. The supervisor detects the failure and restarts the component with a known good state, often in under a millisecond.

## Supervision trees for trading components

The Helios architecture is built around a supervision tree. Each major subsystem runs under its own supervisor:

```elixir
defmodule Helios.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Helios.MarketData.Supervisor, []},
      {Helios.OrderManager.Supervisor, []},
      {Helios.RiskEngine, []},
      {Helios.PositionTracker, []},
      {Helios.Portfolio.Supervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Helios.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

With `:one_for_one` at the top level, a crash in the order manager leaves the market data feed and risk engine running. A bug in order submission should not leave you blind to current market prices.

## GenServers as trading components

Each trading component is a GenServer with well-defined state. Here is a simplified position tracker:

```elixir
defmodule Helios.PositionTracker do
  use GenServer

  defstruct positions: %{}, realized_pnl: Decimal.new(0)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    state = recover_positions_from_store()
    {:ok, state}
  end

  @impl true
  def handle_cast({:fill, fill}, state) do
    updated_positions = apply_fill(state.positions, fill)
    persist_positions(updated_positions)
    {:noreply, %{state | positions: updated_positions}}
  end

  @impl true
  def handle_call(:get_positions, _from, state) do
    {:reply, state.positions, state}
  end

  defp recover_positions_from_store do
    case Helios.Store.load_positions() do
      {:ok, positions} -> %__MODULE__{positions: positions}
      {:error, _} -> %__MODULE__{}
    end
  end
end
```

The `recover_positions_from_store/0` call in `init/1` matters here. When this GenServer restarts after a crash, it rebuilds its state from persistent storage. Crash recovery is part of the design from the start, not something added later.

## Process isolation for risk management

BEAM processes do not share memory. In Helios, the risk engine runs in its own process, so a misbehaving strategy module cannot corrupt it:

```elixir
defmodule Helios.RiskEngine do
  use GenServer

  def check_order(order) do
    GenServer.call(__MODULE__, {:check, order}, 5_000)
  end

  @impl true
  def handle_call({:check, order}, _from, state) do
    case evaluate_risk(order, state) do
      :approved -> {:reply, :ok, state}
      {:rejected, reason} -> {:reply, {:error, reason}, state}
    end
  end
end
```

If a strategy process starts sending malformed orders, the risk engine rejects them. If the risk engine itself crashes on an unexpected edge case, its supervisor restarts it while the rest of the system keeps running. The timeout on `GenServer.call/3` keeps callers from hanging if the risk engine is briefly unavailable.

## Position recovery after restart

After a restart, the first thing a trading system needs is its current positions. Helios uses a write-ahead log: every fill is persisted to disk before the position state is updated in memory. On restart, the position tracker replays the log to rebuild the exact state:

```elixir
defmodule Helios.Store do
  def load_positions do
    with {:ok, log_entries} <- read_fill_log(),
         positions <- Enum.reduce(log_entries, %{}, &apply_log_entry/2) do
      {:ok, positions}
    end
  end

  def append_fill(fill) do
    encoded = :erlang.term_to_binary(fill)
    File.write!(@fill_log_path, encoded <> "\n", [:append])
  end
end
```

Even after a full node restart, the system knows which positions are open and can resume trading without manual intervention.

## Distributed considerations

In production, Helios runs on multiple BEAM nodes. Erlang's built-in distribution makes redundant instances straightforward: if one node goes down, the cluster detects it and another node can take over the trading strategies. Process-level fault tolerance plus node-level redundancy makes the system resilient.

## Lessons learned

Running Helios in production taught me a few things:

1. Design state for recovery. Every GenServer should be able to rebuild its state from persistent storage. Ephemeral state is fine for caches, but anything financially significant must be recoverable.
2. Choose supervision strategies deliberately. `:one_for_one`, `:one_for_all` and `:rest_for_one` behave differently, so think about which components depend on each other.
3. Set timeouts everywhere. In financial systems a slow response is often worse than no response. Use `GenServer.call/3` timeouts and circuit breakers.
4. Monitor restart counts, message queue lengths and processing latencies. BEAM's `:telemetry` and process monitoring make this easy.

OTP was not designed for trading systems, but isolated processes, supervision trees and message passing map onto the domain well.
