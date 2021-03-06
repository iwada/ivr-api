use Bootleg.DSL

# Configure the following roles to match your environment.
# `build` defines what remote server your distillery release should be built on.
#
# Some available options are:
#  - `user`: ssh username to use for SSH authentication to the role's hosts
#  - `password`: password to be used for SSH authentication
#  - `identity`: local path to an identity file that will be used for SSH authentication instead of a password
#  - `workspace`: remote file system path to be used for building and deploying this Elixir project

#role :build, "build.example.com", workspace: "/tmp/bootleg/build"

# Phoenix has some extra build steps such as asset digesting that need to be done during
# compilation. To have bootleeg handle that for you, include the additional package
# `bootleg_phoenix` to your `deps` list. This will automatically perform the additional steps
# required for building phoenix releases.
#
#  ```
#  # mix.exs
#  def deps do
#    [{:distillery, "~> 1.5"},
#    {:bootleg, "~> 0.6"},
#    {:bootleg_phoenix, "~> 0.2"}]
#  end
#  ```
# For more about `bootleg_phoenix` see: https://github.com/labzero/bootleg_phoenix

role(:build, "35.185.121.230",
	 user: "iwada", 
	 identity: "~/.ssh/id_rsa", 
	 workspace: "/tmp/bootleg/build", 
	 silently_accept_hosts: true,
	 release_workspace: "/tmp/bootleg/build"
	 )
#role :app, "35.185.121.230", user: "iwada", identity: "~/.ssh/id_rsa", workspace: "/home/dev/ivr-api", silently_accept_hosts: true

 # #{:ok, _} = Application.ensure_all_started(:ivr)
 # path = Application.app_dir(:ivr, "priv/repo/migrations")
 # #Ecto.Migrator.run(Ivr.Repo, path, :up, all: true)
 # migrator = Ecto.Migrator
 # migrator.run(Ivr.Repo, path, :up, all: true)