defmodule MqaPortfolioWeb.ProjectsLive do
  use MqaPortfolioWeb, :live_view

  alias MqaPortfolio.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Projects")
     |> assign(:projects, Content.list_projects())
     |> assign(:tags, Content.list_project_tags())
     |> assign(:selected_tag, nil)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    tag = params["tag"]
    projects = if tag, do: Content.list_projects_by_tag(tag), else: Content.list_projects()

    {:noreply,
     socket
     |> assign(:projects, projects)
     |> assign(:selected_tag, tag)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_path="/projects">
      <section class="py-20 bg-base-100">
        <div class="max-w-6xl mx-auto px-4">
          <div class="text-center mb-12">
            <h1 class="text-5xl font-bold">Projects</h1>
            <p class="text-base-content/60 mt-3 text-lg">Production systems I've built and shipped</p>
          </div>

          <%!-- Tag Filter --%>
          <div class="flex flex-wrap gap-2 justify-center mb-12">
            <.link
              patch={~p"/projects"}
              class={"btn btn-sm #{if @selected_tag == nil, do: "btn-primary", else: "btn-ghost"}"}
            >
              All
            </.link>
            <.link
              :for={tag <- @tags}
              patch={~p"/projects?tag=#{tag}"}
              class={"btn btn-sm #{if @selected_tag == tag, do: "btn-primary", else: "btn-ghost"}"}
            >
              {String.capitalize(tag)}
            </.link>
          </div>

          <%!-- Project Grid --%>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div
              :for={project <- @projects}
              class="card bg-base-200 shadow-xl hover:shadow-2xl transition-all hover:-translate-y-1"
            >
              <figure class="h-40 bg-gradient-to-br from-primary/20 to-secondary/20 flex items-center justify-center">
                <span class="text-4xl font-bold text-primary/30">{String.first(project.title)}</span>
              </figure>
              <div class="card-body">
                <div class="flex items-center justify-between">
                  <h2 class="card-title text-lg">{project.title}</h2>
                </div>
                <div class="mb-2">
                  <span class={"badge badge-sm #{status_badge_class(project.status)}"}>
                    {String.capitalize(project.status)}
                  </span>
                </div>
                <p class="text-base-content/70 text-sm line-clamp-3">{project.description}</p>
                <div class="flex flex-wrap gap-1 mt-2">
                  <span :for={tag <- project.tags} class="badge badge-outline badge-xs">{tag}</span>
                </div>
                <div class="card-actions justify-end mt-4">
                  <.link navigate={~p"/projects/#{project.slug}"} class="btn btn-primary btn-sm">
                    View Details <.icon name="hero-arrow-right" class="size-4" />
                  </.link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end

  defp status_badge_class("live"), do: "badge-success"
  defp status_badge_class("development"), do: "badge-info"
  defp status_badge_class(_), do: "badge-ghost"
end
