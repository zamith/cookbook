defmodule Parser.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> run
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse

    {opts, List.to_string(word)}
  end

  defp run({[], url}) do
    Parser.parse(url)
  end
end
