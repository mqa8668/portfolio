%{
  title: "Why I Choose Elixir for Real-Time Systems",
  description: "A comparison of Elixir, Go and Node.js for real-time applications, based on building production systems.",
  tags: ["elixir", "phoenix", "architecture"],
  date: ~D[2025-02-20]
}
---

I have built real-time systems in several languages and keep coming back to Elixir and Phoenix. I have used the stack on Routinova (an automated content platform) and Helios (a real-time trading engine), two very different domains. Here is why.

## Lightweight processes

Go has goroutines, Node.js has the event loop and Elixir has BEAM processes. All three are lightweight compared to OS threads, but BEAM processes have preemptive scheduling and per-process garbage collection.

In Node.js, a CPU-intensive callback blocks the entire event loop. In Go, goroutines are cooperatively scheduled at function calls, so a tight computational loop can starve other goroutines. BEAM processes are preempted after a fixed number of reductions, so scheduling stays fair under heavy load.

That matters for real-time systems. When Routinova has thousands of users receiving live updates at once, no single user's request should degrade the experience for others.

## WebSocket handling

Phoenix Channels give each connected client its own process, which means:

- Connection state is isolated, so one client's crash doesn't affect others.
- The number of connections is limited mostly by available memory.
- Message routing uses lightweight process messaging, not shared state.

With Socket.IO on Node.js you manage connection state in shared memory and worry about race conditions. With Go you manage goroutine lifecycles for each connection by hand.

Phoenix's built-in PubSub makes broadcasting simple:

```elixir
# Broadcasting a live update to all subscribers
Phoenix.PubSub.broadcast(MyApp.PubSub, "habits:#{user_id}", {:habit_completed, habit})
```

In Routinova, this one line pushes real-time updates to every device a user has connected. It needs no external message broker, and no Redis for simple cases.

## LiveView

Phoenix LiveView builds reactive, real-time UIs from server-rendered HTML, with no JavaScript framework. For Routinova's live dashboards it removed a lot of work:

- No REST API to design and maintain.
- No client-side state management (Redux, Zustand, etc.).
- No serialization layer.
- Real-time updates go over the existing WebSocket.

The trade-off is latency, since every interaction round-trips to the server. For most applications 20-50ms on a good connection is imperceptible, and the code you don't write is worth it.

## Fault tolerance

In Go, error handling is explicit: every function returns an error that you must check. That is disciplined, but the boilerplate can obscure the business logic.

In Node.js, unhandled promise rejections can crash your process, so you wrap things in try-catch and hope you didn't miss one.

In Elixir, the supervision tree catches failures at the architecture level. Individual processes crash and restart without affecting the rest of the system. This changes how you design: you write the happy path and let the runtime handle recovery.

In Helios, a malformed market data message crashes only the parser for that feed. The supervisor restarts it within milliseconds, with no manual intervention and no cascading failure.

## Hot code reloading

BEAM supports hot code swapping, which means deploying new code without dropping active connections. I don't rely on it for production deployments, since rolling restarts with proper health checks are more predictable, but it is useful in development. You can push code changes to a running system and see the effect without disconnecting any WebSocket clients.

## When I wouldn't choose Elixir

For CPU-intensive computation such as image processing or ML inference, Go or Rust are better choices. For simple CRUD APIs without real-time requirements, the ecosystem maturity of Node.js or Python may be more practical. For systems programming or anything needing deterministic latency, Rust wins.

For real-time communication with high concurrency and fault tolerance, Elixir and Phoenix remain my default. The BEAM VM was built by Ericsson engineers who needed five-nines reliability in telecom switches, and it shows.
