# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DispatchApi.Repo.insert!(%DispatchApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias DispatchApi.{Task, User, Repo}

[
  %Task{
    description: "complete dispatch api",
    completed: false
  },
  %Task{
    description: "start dispatch api",
    completed: true
  }
] |> Enum.each(&Repo.insert!(&1))

User.changeset(%User{}, %{username: "test", email: "test@test.com", password: "testing"})
|> Repo.insert!
