defmodule MqaPortfolioWeb.Plugs.LocalePlug do
  @moduledoc "Sets the Gettext locale from session, params, or Accept-Language header."
  import Plug.Conn

  @locales ["en", "vi"]
  @default "en"

  def init(opts), do: opts

  def call(conn, _opts) do
    locale =
      conn.params["locale"] ||
        get_session(conn, :locale) ||
        get_preferred_locale(conn) ||
        @default

    locale = if locale in @locales, do: locale, else: @default

    Gettext.put_locale(MqaPortfolioWeb.Gettext, locale)

    conn
    |> put_session(:locale, locale)
    |> assign(:locale, locale)
  end

  defp get_preferred_locale(conn) do
    conn
    |> get_req_header("accept-language")
    |> List.first()
    |> parse_accept_language()
  end

  defp parse_accept_language(nil), do: nil

  defp parse_accept_language(header) do
    header
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn lang ->
      lang |> String.split(";") |> List.first() |> String.split("-") |> List.first()
    end)
    |> Enum.find(&(&1 in @locales))
  end
end
