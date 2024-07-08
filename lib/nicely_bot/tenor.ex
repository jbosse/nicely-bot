defmodule NicelyBot.Tenor do
  def find_gif_url(search_term) do
    search_term
    |> URI.encode()
    |> query_url()
    |> HTTPoison.get!([], hackney: [:insecure])
    |> parse_body()
    |> pick_random_result()
    |> pick_random_media()
    |> get_gif_url()
  end

  defp url() do
    "https://g.tenor.com/v1/search?key=#{Application.fetch_env!(:nicely_bot, :tenor_api_key)}&limit=10"
  end

  defp query_url(query), do: "#{url()}&q=#{query}"

  defp parse_body(%HTTPoison.Response{status_code: 200, body: body}), do: body |> Jason.decode()

  defp pick_random_result({:ok, %{"results" => results}}), do: results |> Enum.random()

  defp pick_random_media(%{"media" => media}), do: media |> Enum.random()

  defp get_gif_url(%{"gif" => %{"url" => url}}), do: url
end
