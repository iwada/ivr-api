# # apps/myapp/lib/migration.ex

# defmodule Ivr.ReleaseTasks do
#   @start_apps [
#     :postgrex,
#     :ecto
#   ]
#   @app :ivr

#   def repos, do: Application.get_env(@app, :ecto_repos, [])

#   def seed do
#     prepare()
#     # Run seed script
#     Enum.each(repos(), &run_seeds_for/1)

#     # Signal shutdown
#     IO.puts("Success!")
#   end

#   defp run_seeds_for(repo) do
#     # Run the seed script if it exists
#     seed_script = seeds_path(repo)

#     if File.exists?(seed_script) do
#       IO.puts("Running seed script..")
#       Code.eval_file(seed_script)
#     end
#   end

#   def migrate do
#     prepare()
#     Enum.each(repos(), &run_migrations_for/1)
#     IO.puts("Migrations successful!")
#   end

#   defp run_migrations_for(repo) do
#     app = Keyword.get(repo.config, :otp_app)
#     IO.puts("Running migrations for #{app}")
#     migrations_path = priv_path_for(repo, "migrations")
#     Ecto.Migrator.run(repo, migrations_path, :up, all: true)
#   end

#   def rollback do
#     prepare()

#     get_step =
#       IO.gets("Enter the number of steps: ")
#       |> String.trim()
#       |> Integer.parse()

#     case get_step do
#       {int, _trailing} ->
#         Enum.each(repos(), fn repo -> run_rollbacks_for(repo, int) end)
#         IO.puts("Rollback successful!")

#       :error ->
#         IO.puts("Invalid integer")
#     end
#   end

#   defp run_rollbacks_for(repo, step) do
#     app = Keyword.get(repo.config, :otp_app)
#     IO.puts("Running rollbacks for #{app} (STEP=#{step})")
#     migrations_path = priv_path_for(repo, "migrations")
#     Ecto.Migrator.run(repo, migrations_path, :down, all: false, step: step)
#   end

#   defp prepare do
#     IO.puts("Loading #{@app}..")
#     # Load the code for myapp, but don't start it
#     :ok = Application.load(@app)

#     IO.puts("Starting dependencies..")
#     # Start apps necessary for executing migrations
#     Enum.each(@start_apps, &Application.ensure_all_started/1)

#     # Start the Repo(s) for myapp
#     IO.puts("Starting repos..")
#     Enum.each(repos(), & &1.start_link(pool_size: 1))
#   end

#   defp seeds_path(repo), do: priv_path_for(repo, "seeds.exs")

#   defp priv_path_for(repo, filename) do
#     app = Keyword.get(repo.config, :otp_app)
#     IO.puts("App: #{app}")
#     repo_underscore = repo |> Module.split() |> List.last() |> Macro.underscore()
#     Path.join([priv_dir(app), repo_underscore, filename])
#   end

#   defp priv_dir(app), do: "#{:code.priv_dir(app)}"
# end

defmodule Ivr.ReleaseTasks do
  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto,
    :ecto_sql # If using Ecto 3.0 or higher
  ]

  @repos Application.get_env(:ivr, :ecto_repos, [])

  def migrate(_argv) do
    start_services()

    run_migrations()

    stop_services()
  end

  def seed(_argv) do
    start_services()

    run_migrations()

    run_seeds()

    stop_services()
  end

  defp start_services do
    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
   # Enum.each(@start_apps, &Application.ensure_all_started/1)

    {:ok, _} = Application.ensure_all_started(:ecto_sql)
    {:ok, _} = Application.ensure_all_started(:ssl)
    {:ok, _} = Application.ensure_all_started(:crypto)
    {:ok, _} = Application.ensure_all_started(:postgrex)
    {:ok, _} = Application.ensure_all_started(:ecto)

    # Start the Repo(s) for app
    IO.puts("Starting repos..")
    
    # Switch pool_size to 2 for ecto > 3.0
    Enum.each(@repos, & &1.start_link(pool_size: 1))
  end

  defp stop_services do
    IO.puts("Success!")
    :init.stop()
  end

  defp run_migrations do
    Enum.each(@repos, &run_migrations_for/1)
  end

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config(), :otp_app)
    IO.puts("Running migrations for #{app}")
    migrations_path = priv_path_for(repo, "migrations")
    Ecto.Migrator.run(repo, migrations_path, :up, all: true)
  end

  defp run_seeds do
    Enum.each(@repos, &run_seeds_for/1)
  end

  defp run_seeds_for(repo) do
    # Run the seed script if it exists
    seed_script = priv_path_for(repo, "seeds.exs")

    if File.exists?(seed_script) do
      IO.puts("Running seed script..")
      Code.eval_file(seed_script)
    end
  end

  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config(), :otp_app)

    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    priv_dir = "#{:code.priv_dir(app)}"

    Path.join([priv_dir, repo_underscore, filename])
  end
end
