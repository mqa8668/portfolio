defmodule MqaPortfolioWeb.HealthController do
  use MqaPortfolioWeb, :controller

  def index(conn, _params) do
    json(conn, %{
      status: "ok",
      version: Application.spec(:mqa_portfolio, :vsn) |> to_string(),
      elixir: System.version(),
      otp: System.otp_release()
    })
  end
end
