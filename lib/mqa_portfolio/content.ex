defmodule MqaPortfolio.Content.Projects do
  @moduledoc false

  alias MqaPortfolio.Content.Project

  use NimblePublisher,
    build: Project,
    from: Application.app_dir(:mqa_portfolio, "priv/projects/**/*.md"),
    as: :projects,
    highlighters: [:makeup_elixir]

  def all, do: @projects
end

defmodule MqaPortfolio.Content.Blog do
  @moduledoc false

  alias MqaPortfolio.Content.BlogPost

  use NimblePublisher,
    build: BlogPost,
    from: Application.app_dir(:mqa_portfolio, "priv/blog/**/*.md"),
    as: :blog_posts,
    highlighters: [:makeup_elixir]

  def all, do: @blog_posts
end

defmodule MqaPortfolio.Content do
  @moduledoc "Content module for projects and blog posts using NimblePublisher."

  alias MqaPortfolio.Content.{Projects, Blog}

  @contact_url "https://forgiolab.com/contact/"

  @doc "External contact page (Forgio Lab studio)."
  def contact_url, do: @contact_url

  # Projects

  def list_projects do
    Projects.all() |> Enum.sort_by(& &1.date, {:desc, Date})
  end

  def list_featured_projects do
    Projects.all()
    |> Enum.filter(& &1.featured)
    |> Enum.sort_by(& &1.date, {:desc, Date})
  end

  def get_project_by_slug!(slug) do
    Enum.find(Projects.all(), &(&1.slug == slug)) ||
      raise "Project not found: #{slug}"
  end

  def list_project_tags do
    Projects.all() |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
  end

  def list_projects_by_tag(tag) do
    Projects.all()
    |> Enum.filter(&(tag in &1.tags))
    |> Enum.sort_by(& &1.date, {:desc, Date})
  end

  # Blog Posts

  def list_blog_posts do
    Blog.all() |> Enum.sort_by(& &1.date, {:desc, Date})
  end

  def list_recent_blog_posts(limit \\ 3) do
    list_blog_posts() |> Enum.take(limit)
  end

  def get_blog_post_by_slug!(slug) do
    Enum.find(Blog.all(), &(&1.slug == slug)) ||
      raise "Blog post not found: #{slug}"
  end

  def list_blog_tags do
    Blog.all() |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
  end
end
