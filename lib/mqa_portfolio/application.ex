defmodule MqaPortfolio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MqaPortfolioWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:mqa_portfolio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MqaPortfolio.PubSub},
      # Start a worker by calling: MqaPortfolio.Worker.start_link(arg)
      # {MqaPortfolio.Worker, arg},
      MqaPortfolioWeb.Presence,
      # Start to serve requests, typically the last entry
      MqaPortfolioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MqaPortfolio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MqaPortfolioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
