defmodule JiraConnect.MixProject do
  use Mix.Project

  def project do
    [
      app: :jira_connect,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {JiraConnect.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.20"},
      {:construct, "~> 3.0"},
      {:jason, "~> 1.4"}
    ]
  end
end
