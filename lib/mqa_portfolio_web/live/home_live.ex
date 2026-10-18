defmodule MqaPortfolioWeb.HomeLive do
  use MqaPortfolioWeb, :live_view

  alias MqaPortfolioWeb.Presence

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(MqaPortfolio.PubSub, Presence.topic())
      Presence.track_visitor(self(), socket.id)
    end

    {:ok,
     socket
     |> assign(:page_title, "Senior Engineer, Web Apps, APIs & Automation")
     |> assign(:beam_stats, get_beam_stats())
     |> assign(:visitor_count, Presence.count_visitors())
     |> assign(:terminal_lines, terminal_lines())
     |> schedule_stats_update()}
  end

  @impl true
  def handle_info(:update_stats, socket) do
    {:noreply,
     socket
     |> assign(:beam_stats, get_beam_stats())
     |> assign(:visitor_count, Presence.count_visitors())
     |> assign(:terminal_lines, terminal_lines())
     |> schedule_stats_update()}
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{event: "presence_diff"}, socket) do
    {:noreply, assign(socket, :visitor_count, Presence.count_visitors())}
  end

  defp schedule_stats_update(socket) do
    if connected?(socket), do: Process.send_after(self(), :update_stats, 2000)
    socket
  end

  defp get_beam_stats do
    %{
      processes: :erlang.system_info(:process_count),
      memory_mb: Float.round(:erlang.memory(:total) / 1_048_576, 1),
      uptime_seconds: :erlang.statistics(:wall_clock) |> elem(0) |> div(1000),
      schedulers: :erlang.system_info(:schedulers_online)
    }
  end

  defp terminal_lines do
    stats = get_beam_stats()

    [
      %{
        command: "MQA.Portfolio.stats()",
        response:
          "%{otp: \"#{System.otp_release()}\", elixir: \"#{System.version()}\", processes: #{stats.processes}, memory_mb: #{stats.memory_mb}}"
      },
      %{
        command: "MQA.Portfolio.stack()",
        response:
          ~s(%{primary: "Elixir/Phoenix", devops: "K8s/ArgoCD", trading: "Binance API", ai: "Multi-provider"})
      },
      %{
        command: "MQA.Portfolio.uptime()",
        response:
          "\"#{div(stats.uptime_seconds, 3600)}h #{rem(div(stats.uptime_seconds, 60), 60)}m, BEAM never sleeps\""
      }
    ]
  end
end
