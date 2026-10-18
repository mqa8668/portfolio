defmodule MqaPortfolioWeb.BlogLive do
  use MqaPortfolioWeb, :live_view

  alias MqaPortfolio.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Blog")
     |> assign(:posts, Content.list_blog_posts())
     |> assign(:tags, Content.list_blog_tags())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_path="/blog">
      <section class="py-20 bg-base-100">
        <div class="max-w-4xl mx-auto px-4">
          <div class="text-center mb-12">
            <h1 class="text-5xl font-bold">Blog</h1>
            <p class="text-base-content/60 mt-3 text-lg">
              Technical articles and engineering insights
            </p>
          </div>

          <div class="space-y-8">
            <article
              :for={post <- @posts}
              class="card bg-base-200 shadow hover:shadow-lg transition-shadow"
            >
              <div class="card-body">
                <div class="flex items-center gap-3 text-sm text-base-content/50">
                  <time>{Calendar.strftime(post.date, "%B %d, %Y")}</time>
                  <span>·</span>
                  <span>{post.reading_time} min read</span>
                </div>
                <h2 class="card-title text-2xl">
                  <.link
                    navigate={~p"/blog/#{post.slug}"}
                    class="hover:text-primary transition-colors"
                  >
                    {post.title}
                  </.link>
                </h2>
                <p class="text-base-content/70">{post.description}</p>
                <div class="flex flex-wrap gap-2 mt-2">
                  <span :for={tag <- post.tags} class="badge badge-outline badge-sm">{tag}</span>
                </div>
                <div class="card-actions justify-end mt-2">
                  <.link navigate={~p"/blog/#{post.slug}"} class="btn btn-primary btn-sm">
                    Read More <.icon name="hero-arrow-right" class="size-4" />
                  </.link>
                </div>
              </div>
            </article>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
