defmodule Parser do
  def parse(url) do
    url |> URI.parse |> select_parser
  end

  defp select_parser(uri = %URI{host: "www.jamieoliver.com"}) do
    uri |> URI.to_string |> Parser.Parsers.JamieOliver.parse
  end
end
