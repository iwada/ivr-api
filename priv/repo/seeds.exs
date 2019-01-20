# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ivr.Repo.insert!(%Ivr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

user =
Ivr.Accounts.User.registration_changeset(%Ivr.Accounts.User{}, %{
    name: "dev dev",
    email: "dev@dev.com",
    password: "devaccess"
  })

Ivr.Repo.insert!(user)


