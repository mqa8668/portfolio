defmodule MqaPortfolioWeb.NavigationTest do
  use MqaPortfolioWeb.ConnCase

  import Phoenix.LiveViewTest

  @nav_ids ~w(nav-brand nav-projects nav-experience nav-blog nav-contact)

  for path <- ["/", "/projects", "/experience", "/blog"] do
    test "navbar is present on #{path}", %{conn: conn} do
      {:ok, view, _html} = live(conn, unquote(path))

      for id <- @nav_ids do
        assert has_element?(view, "##{id}")
      end

      assert has_element?(view, ~s(#nav-contact[href="https://forgiolab.com/contact/"]))
    end
  end

  test "active nav item is marked", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/projects")
    assert has_element?(view, "#nav-projects[aria-current=page]")
    refute has_element?(view, "#nav-blog[aria-current=page]")
  end

  test "project detail page has back link", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/projects/helios")
    assert has_element?(view, "#back-to-projects")
    assert has_element?(view, "#nav-projects")
  end

  test "blog post page has back link", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/blog/why-elixir-for-real-time-systems")
    assert has_element?(view, "#back-to-blog")
    assert has_element?(view, "#nav-blog")
  end

  test "experience page has education section", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/experience")
    assert has_element?(view, "#education")
  end
end
