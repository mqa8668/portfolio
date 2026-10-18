defmodule MqaPortfolioWeb.PageControllerTest do
  use MqaPortfolioWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Senior Engineer"
  end

  test "GET /projects", %{conn: conn} do
    conn = get(conn, ~p"/projects")
    assert html_response(conn, 200) =~ "Projects"
  end

  test "GET /experience", %{conn: conn} do
    conn = get(conn, ~p"/experience")
    assert html_response(conn, 200) =~ "Experience"
  end

  test "GET /blog", %{conn: conn} do
    conn = get(conn, ~p"/blog")
    assert html_response(conn, 200) =~ "Blog"
  end

  test "GET /contact", %{conn: conn} do
    conn = get(conn, "/contact")
    assert redirected_to(conn, 301) == "https://forgiolab.com/contact/"
  end

  test "GET /projects/:slug", %{conn: conn} do
    conn = get(conn, ~p"/projects/helios")
    assert html_response(conn, 200) =~ "Helios"
  end

  test "GET /blog/:slug", %{conn: conn} do
    conn = get(conn, ~p"/blog/why-elixir-for-real-time-systems")
    assert html_response(conn, 200) =~ "Elixir"
  end
end
