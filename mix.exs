defmodule Bls.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_bls,
      version: "0.1.1",
      elixir: "~> 1.8",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      compilers: Mix.compilers(),
      source_url: "https://github.com/timjp87/elixir-bls",
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  defp description() do
    "Wrapper ETH2 Herumui BLS 12-381 Elliptic Curve construction and signature aggregation scheme."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/timjp87/elixir_bls"},
      files: ~w(lib priv .formatter.exs mix.exs README* LICENSE* native)
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
      {:wasmex, "~> 0.2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
