defmodule MqaPortfolioWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use MqaPortfolioWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_path, :string,
    default: nil,
    doc: "the section path used to highlight the nav item"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="drawer">
      <input id="mobile-drawer" type="checkbox" class="drawer-toggle" />

      <div class="drawer-content flex flex-col">
        <%!-- Navbar --%>
        <header class="navbar bg-base-100/80 backdrop-blur-lg sticky top-0 z-50 border-b border-base-300 px-4 sm:px-6 lg:px-8">
          <div class="flex-none lg:hidden">
            <label for="mobile-drawer" aria-label="open sidebar" class="btn btn-square btn-ghost">
              <.icon name="hero-bars-3" class="size-5" />
            </label>
          </div>

          <div class="flex-1">
            <.link navigate={~p"/"} id="nav-brand" class="btn btn-ghost text-xl font-bold">
              Loc <span class="text-primary">Luong</span>
            </.link>
          </div>

          <div class="hidden lg:flex flex-none">
            <ul class="menu menu-horizontal px-1 gap-1 items-center">
              <li>
                <.link
                  navigate={~p"/projects"}
                  id="nav-projects"
                  class={nav_class(@current_path, "/projects")}
                  aria-current={if(active?(@current_path, "/projects"), do: "page")}
                >
                  Projects
                </.link>
              </li>
              <li>
                <.link
                  navigate={~p"/experience"}
                  id="nav-experience"
                  class={nav_class(@current_path, "/experience")}
                  aria-current={if(active?(@current_path, "/experience"), do: "page")}
                >
                  Experience
                </.link>
              </li>
              <li>
                <.link
                  navigate={~p"/blog"}
                  id="nav-blog"
                  class={nav_class(@current_path, "/blog")}
                  aria-current={if(active?(@current_path, "/blog"), do: "page")}
                >
                  Blog
                </.link>
              </li>
              <li>
                <a
                  href={MqaPortfolio.Content.contact_url()}
                  id="nav-contact"
                  class="font-medium"
                >
                  Contact
                </a>
              </li>
            </ul>
          </div>

          <div class="flex-none flex items-center gap-2 ml-2">
            <.locale_toggle locale={assigns[:locale]} />
            <.theme_toggle />
          </div>
        </header>

        <%!-- Main content --%>
        <main class="min-h-screen">
          <div class="mx-auto">
            {render_slot(@inner_block)}
          </div>
        </main>

        <%!-- Footer --%>
        <footer class="footer bg-base-200 text-base-content p-10">
          <nav>
            <h6 id="footer-brand" class="footer-title">
              Loc <span class="text-primary">Luong</span>
            </h6>
            <p class="max-w-xs text-base-content/70">Building systems that run themselves</p>
          </nav>
          <nav>
            <h6 class="footer-title">Quick Links</h6>
            <.link navigate={~p"/projects"} id="footer-projects" class="link link-hover">
              Projects
            </.link>
            <.link navigate={~p"/experience"} id="footer-experience" class="link link-hover">
              Experience
            </.link>
            <.link navigate={~p"/blog"} id="footer-blog" class="link link-hover">Blog</.link>
            <a href={MqaPortfolio.Content.contact_url()} id="footer-contact" class="link link-hover">
              Contact
            </a>
          </nav>
          <nav>
            <h6 class="footer-title">Connect</h6>
            <a
              href="https://github.com/mqa8668"
              class="link link-hover"
              target="_blank"
              rel="noopener noreferrer"
            >
              GitHub
            </a>
          </nav>
        </footer>
        <footer class="footer footer-center bg-base-300 text-base-content p-4">
          <aside>
            <p>
              &copy; {Date.utc_today().year} Loc Luong. Built with Phoenix LiveView &amp; Elixir.
              <span id="visitor-count"></span>
            </p>
          </aside>
        </footer>
      </div>

      <%!-- Mobile drawer sidebar --%>
      <div class="drawer-side z-[60]">
        <label for="mobile-drawer" aria-label="close sidebar" class="drawer-overlay"></label>
        <div class="menu bg-base-200 min-h-full w-72 p-4">
          <div class="mb-4">
            <.link navigate={~p"/"} id="drawer-brand" class="btn btn-ghost text-xl font-bold">
              Loc <span class="text-primary">Luong</span>
            </.link>
          </div>
          <ul class="space-y-1">
            <li>
              <.link
                navigate={~p"/projects"}
                id="drawer-projects"
                phx-click={JS.dispatch("mqa:close-drawer")}
                class={[
                  "font-medium text-lg",
                  active?(@current_path, "/projects") && "text-primary"
                ]}
              >
                Projects
              </.link>
            </li>
            <li>
              <.link
                navigate={~p"/experience"}
                id="drawer-experience"
                phx-click={JS.dispatch("mqa:close-drawer")}
                class={[
                  "font-medium text-lg",
                  active?(@current_path, "/experience") && "text-primary"
                ]}
              >
                Experience
              </.link>
            </li>
            <li>
              <.link
                navigate={~p"/blog"}
                id="drawer-blog"
                phx-click={JS.dispatch("mqa:close-drawer")}
                class={[
                  "font-medium text-lg",
                  active?(@current_path, "/blog") && "text-primary"
                ]}
              >
                Blog
              </.link>
            </li>
            <li>
              <a
                href={MqaPortfolio.Content.contact_url()}
                id="drawer-contact"
                class="font-medium text-lg"
              >
                Contact
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  defp active?(nil, _path), do: false
  defp active?(current, path), do: current == path or String.starts_with?(current, path <> "/")

  defp nav_class(current, path) do
    [
      "font-medium",
      if(active?(current, path), do: "text-primary underline underline-offset-8 decoration-2")
    ]
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Renders EN/VI locale toggle buttons using DaisyUI join component.
  """
  attr :locale, :string, default: "en"

  def locale_toggle(assigns) do
    ~H"""
    <div class="join">
      <a
        href="?locale=en"
        class={"join-item btn btn-xs #{if @locale == "en" or @locale == nil, do: "btn-primary", else: "btn-ghost"}"}
      >
        EN
      </a>
      <a
        href="?locale=vi"
        class={"join-item btn btn-xs #{if @locale == "vi", do: "btn-primary", else: "btn-ghost"}"}
      >
        VI
      </a>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle based on themes defined in app.css.

  See <head> in root.html.heex which applies the theme before page load.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
