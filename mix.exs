defmodule Bls.MixProject do
  use Mix.Project

  def project do
    [
      app: :bls,
      version: "0.1.0",
      elixir: "~> 1.8",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates(),
      source_url: "https://github.com/timjp87/elixir-bls",
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  defp description() do
    "NIF wrapper around the Rust BLS 12-381 Elliptic Curve construction and signature aggregation scheme."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/timjp87/elixir-bls"}
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
      {:rustler, "~> 0.20.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
    ]
  end

  defp rustler_crates do
    [
      bls: [path: "native/bls", mode: if(Mix.env() == :prod, do: :release, else: :debug)]
    ]
  end
end
