defmodule Parser.Mixfile do
  use Mix.Project

  def project do
    [app: :parser,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp escript do
    [main_module: Parser.CLI]
  end

  defp deps do
    [
      {:tesla, "~> 0.7.1"},
      {:floki, "~> 0.17.0"},
      {:trello, in_umbrella: true},
    ]
  end
end
