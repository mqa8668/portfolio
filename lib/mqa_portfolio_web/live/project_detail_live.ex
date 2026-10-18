defmodule MqaPortfolioWeb.ProjectDetailLive do
  use MqaPortfolioWeb, :live_view

  alias MqaPortfolio.Content

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    project = Content.get_project_by_slug!(slug)

    {:ok,
     socket
     |> assign(:page_title, project.title)
     |> assign(:project, project)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_path="/projects">
      <section class="py-20 bg-base-100">
        <div class="max-w-4xl mx-auto px-4">
          <%!-- Back button --%>
          <.link navigate={~p"/projects"} id="back-to-projects" class="btn btn-ghost btn-sm mb-8">
            <.icon name="hero-arrow-left" class="size-4" /> Back to Projects
          </.link>

          <%!-- Hero --%>
          <div class="mb-12">
            <div class="flex items-center gap-3 mb-4">
              <span class={"badge #{status_badge_class(@project.status)}"}>
                {String.capitalize(@project.status)}
              </span>
              <span :for={tag <- @project.tags} class="badge badge-outline badge-sm">{tag}</span>
            </div>
            <h1 class="text-4xl md:text-5xl font-bold">{@project.title}</h1>
            <p class="text-xl text-base-content/60 mt-4">{@project.description}</p>
          </div>

          <%!-- Tech Stack --%>
          <div class="mb-8">
            <h2 class="text-lg font-semibold mb-3">Tech Stack</h2>
            <div class="flex flex-wrap gap-2">
              <span :for={t <- @project.tech} class="badge badge-primary badge-lg">{t}</span>
            </div>
          </div>

          <%!-- Metrics --%>
          <div :if={@project.metrics != []} class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
            <div
              :for={metric <- @project.metrics}
              class="stat bg-base-200 rounded-box p-4 text-center"
            >
              <div class="stat-title text-xs">{metric.label}</div>
              <div class="stat-value text-lg text-primary whitespace-normal break-words leading-snug">
                {metric.value}
              </div>
            </div>
          </div>

          <%!-- Content --%>
          <article class="prose prose-lg max-w-none">
            {raw(@project.body)}
          </article>

          <%!-- Navigation --%>
          <div class="mt-16 pt-8 border-t border-base-300 text-center">
            <.link navigate={~p"/projects"} class="btn btn-outline btn-primary">
              <.icon name="hero-arrow-left" class="size-5" /> All Projects
            </.link>
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
