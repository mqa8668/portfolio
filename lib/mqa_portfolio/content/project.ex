defmodule MqaPortfolio.Content.Project do
  @moduledoc "Schema for portfolio projects compiled from markdown."

  @enforce_keys [:id, :slug, :title, :description, :body, :tags, :tech, :date]
  defstruct [
    :id,
    :slug,
    :title,
    :description,
    :body,
    :tags,
    :tech,
    :date,
    featured: false,
    status: "live",
    metrics: [],
    hero_image: nil
  ]

  def build(filename, attrs, body) do
    slug = filename |> Path.rootname() |> Path.split() |> List.last()

    struct!(
      __MODULE__,
      [id: slug, slug: slug, body: body] ++ Map.to_list(attrs)
    )
  end
end
