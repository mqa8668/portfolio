defmodule MqaPortfolioWeb.Presence do
  @moduledoc "Tracks visitors on the portfolio site."

  use Phoenix.Presence,
    otp_app: :mqa_portfolio,
    pubsub_server: MqaPortfolio.PubSub

  @topic "visitors"

  def topic, do: @topic

  def track_visitor(pid, id) do
    track(pid, @topic, id, %{
      joined_at: System.system_time(:second)
    })
  end

  def count_visitors do
    list(@topic) |> map_size()
  end
end
