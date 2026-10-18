defmodule MqaPortfolioWeb.Router do
  use MqaPortfolioWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MqaPortfolioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MqaPortfolioWeb.Plugs.LocalePlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MqaPortfolioWeb do
    pipe_through :browser

    live "/", HomeLive, :index
    live "/projects", ProjectsLive, :index
    live "/projects/:slug", ProjectDetailLive, :show
    live "/experience", ExperienceLive, :index
    live "/blog", BlogLive, :index
    live "/blog/:slug", BlogPostLive, :show
  end

  scope "/", MqaPortfolioWeb do
    pipe_through :browser
    get "/contact", PageController, :contact
    get "/sitemap.xml", SitemapController, :index
  end

  scope "/api", MqaPortfolioWeb do
    pipe_through :api
    get "/health", HealthController, :index
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:mqa_portfolio, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MqaPortfolioWeb.Telemetry
    end
  end
end
