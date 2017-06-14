defmodule Parser do
  def parse(url) do
    Parser.Parsers.Default.parse(url)
  end
end
