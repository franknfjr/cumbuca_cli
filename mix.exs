defmodule CumbucaCli.MixProject do
  use Mix.Project

  @version "1.0.0"

  def project do
    [
      app: :cumbuca_cli,
      version: @version,
      elixir: "~> 1.17",
      description: "The command-line tool for the kings and queens of Cumbúquia.",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: CumbucaCLI]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
