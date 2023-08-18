defmodule Windog.MixProject do
  use Mix.Project

  @description """
  API client for winticket.jp
  """

  def project do
    [
      app: :windog,
      version: "0.5.4",
      elixir: "~> 1.15",
      package: package(),
      description: @description,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/buysake/windog"
    ]
  end

  defp package do
    [
      maintainers: ["sake"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/buysake/windog"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:timex, "~> 3.5"},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.7"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
