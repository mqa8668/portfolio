defmodule MqaPortfolioWeb.BlogPostLive do
  use MqaPortfolioWeb, :live_view

  alias MqaPortfolio.Content

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    post = Content.get_blog_post_by_slug!(slug)

    {:ok,
     socket
     |> assign(:page_title, post.title)
     |> assign(:post, post)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_path="/blog">
      <section class="py-20 bg-base-100">
        <div class="max-w-3xl mx-auto px-4">
          <.link navigate={~p"/blog"} id="back-to-blog" class="btn btn-ghost btn-sm mb-8">
            <.icon name="hero-arrow-left" class="size-4" /> Back to Blog
          </.link>

          <article>
            <header class="mb-12">
              <div class="flex items-center gap-3 text-sm text-base-content/50 mb-4">
                <time>{Calendar.strftime(@post.date, "%B %d, %Y")}</time>
                <span>·</span>
                <span>{@post.reading_time} min read</span>
              </div>
              <h1 class="text-4xl md:text-5xl font-bold leading-tight">{@post.title}</h1>
              <p class="text-xl text-base-content/60 mt-4">{@post.description}</p>
              <div class="flex flex-wrap gap-2 mt-6">
                <span :for={tag <- @post.tags} class="badge badge-primary badge-outline">{tag}</span>
              </div>
            </header>

            <div class="prose prose-lg max-w-none">
              {raw(@post.body)}
            </div>
          </article>

          <div class="mt-16 pt-8 border-t border-base-300 text-center">
            <.link navigate={~p"/blog"} class="btn btn-outline btn-primary">
              <.icon name="hero-arrow-left" class="size-5" /> All Posts
            </.link>
          </div>
        </div>
      </section>
    </Layouts.app>
    """
  end
end
