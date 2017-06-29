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

task = %Task{
          description: "complete dispatch api",
          completed: false
        }

User.changeset(%User{}, %{username: "test", email: "test@test.com", password: "testing"})
|> Repo.insert!
|> Ecto.build_assoc(:tasks, task)
|> Repo.insert!


task = %Task{
          description: "complete all the tasks",
          completed: false
        }

User.changeset(%User{}, %{username: "test02", email: "test02@test.com", password: "testing"})
|> Repo.insert!
|> Ecto.build_assoc(:tasks, task)
|> Repo.insert!
