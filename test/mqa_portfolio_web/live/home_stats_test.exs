defmodule MqaPortfolioWeb.HomeStatsTest do
  use MqaPortfolioWeb.ConnCase

  import Phoenix.LiveViewTest

  @expected [
    {"stat-years", "20"},
    {"stat-elixir", "6+"},
    {"stat-projects", "10+"},
    {"stat-tests", "540+"}
  ]

  test "stat cards render non-zero values on disconnected and connected render", %{conn: conn} do
    conn = get(conn, "/")
    html = html_response(conn, 200)

    for {id, text} <- @expected do
      assert html |> LazyHTML.from_document() |> LazyHTML.query("##{id}-value") |> LazyHTML.text() ==
               text
    end

    {:ok, view, _html} = live(conn)

    for {id, text} <- @expected do
      assert has_element?(view, "##{id}-value", text)
    end
  end
end
