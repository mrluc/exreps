defmodule SpacedRepetitions.Mixfile do

  use Mix.Project

  @description "Spaced repetitions library with basic sm2 implementation"

  @package [
    files: [ "lib", "mix.exs", "README.md", "LICENSE.md"],
    contributors: [ "github/mrluc" ],
    licenses: [ "MIT" ],
    links: %{"Github" => "https://github.com/mrluc/exreps"}
  ]

  @deps [{ :timex, "~> 0.16.0"}]

  def project do
    [
      app:         :spaced_repetitions,
      version:     "0.0.1",
      elixir:      ">= 1.0.0",
      deps:        @deps,
      description: @description,
      package:     @package
    ]
  end
end
