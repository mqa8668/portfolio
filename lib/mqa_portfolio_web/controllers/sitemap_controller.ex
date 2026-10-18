defmodule MqaPortfolioWeb.SitemapController do
  use MqaPortfolioWeb, :controller

  alias MqaPortfolio.Content

  def index(conn, _params) do
    projects = Content.list_projects()
    blog_posts = Content.list_blog_posts()

    conn
    |> put_resp_content_type("application/xml")
    |> text(render_sitemap(projects, blog_posts))
  end

  defp render_sitemap(projects, blog_posts) do
    base_url = "https://loc.forgiolab.com"

    static_pages = [
      %{loc: base_url, priority: "1.0", changefreq: "weekly"},
      %{loc: "#{base_url}/projects", priority: "0.9", changefreq: "weekly"},
      %{loc: "#{base_url}/experience", priority: "0.8", changefreq: "monthly"},
      %{loc: "#{base_url}/blog", priority: "0.9", changefreq: "weekly"}
    ]

    project_pages =
      Enum.map(projects, fn p ->
        %{loc: "#{base_url}/projects/#{p.slug}", priority: "0.8", changefreq: "monthly"}
      end)

    blog_pages =
      Enum.map(blog_posts, fn p ->
        %{loc: "#{base_url}/blog/#{p.slug}", priority: "0.7", changefreq: "monthly"}
      end)

    all_pages = static_pages ++ project_pages ++ blog_pages

    urls =
      Enum.map(all_pages, fn page ->
        """
          <url>
            <loc>#{page.loc}</loc>
            <changefreq>#{page.changefreq}</changefreq>
            <priority>#{page.priority}</priority>
          </url>
        """
      end)
      |> Enum.join()

    """
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    #{urls}</urlset>
    """
    |> String.trim()
  end
end
