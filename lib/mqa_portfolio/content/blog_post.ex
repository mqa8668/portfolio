defmodule MqaPortfolio.Content.BlogPost do
  @moduledoc "Schema for blog posts compiled from markdown."

  @enforce_keys [:id, :slug, :title, :description, :body, :tags, :date]
  defstruct [
    :id,
    :slug,
    :title,
    :description,
    :body,
    :tags,
    :date,
    reading_time: 0
  ]

  def build(filename, attrs, body) do
    slug = filename |> Path.rootname() |> Path.split() |> List.last()
    words = body |> String.split(~r/\s+/) |> length()
    reading_time = max(1, div(words, 200))

    struct!(
      __MODULE__,
      [id: slug, slug: slug, body: body, reading_time: reading_time] ++ Map.to_list(attrs)
    )
  end
end
