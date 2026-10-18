defmodule MqaPortfolioWeb.PageController do
  use MqaPortfolioWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def contact(conn, _params) do
    conn
    |> put_status(301)
    |> redirect(external: MqaPortfolio.Content.contact_url())
  end
end
