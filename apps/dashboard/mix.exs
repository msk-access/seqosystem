defmodule Dashboard.MixProject do
  use Mix.Project

  def project do
    [
      app: :dashboard,
      version: append_revision("0.0.1"),
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def append_revision(version) do
    "#{version}+#{revision}"
  end

  defp revision() do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.trim_trailing()
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Dashboard.Application, []},
      extra_applications: [:logger, :mdb, :domain, :runtime_tools, :edeliver, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.3"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_live_view, "~> 0.14.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.2.2"},
      {:lims_client, in_umbrella: true},
      {:access_tracker_client, in_umbrella: true},
      {:domain, in_umbrella: true},
      {:timex, "~> 3.5"},
      {:elixir_uuid, "~> 1.2"},
      {:mdb, in_umbrella: true},

      # {:ex_state_ecto, "~> 0.2"},
      # {:oban, "~> 1.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
