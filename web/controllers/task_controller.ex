defmodule DispatchApi.TaskController do
  use DispatchApi.Web, :controller
  use Guardian.Phoenix.Controller

  alias DispatchApi.Task
  alias JaSerializer.Params

  plug Guardian.Plug.EnsureAuthenticated, [handler: DispatchApi.AuthErrorHandler]

  def index(conn, _params, user, _claims) do
    tasks = Repo.all(user_tasks(user))
    render(conn, "index.json-api", data: tasks)
  end

  def create(conn, %{"data" => data = %{"type" => "task", "attributes" => _task_params}}, user, _claims) do
    changeset =
      user
      |> build_assoc(:tasks)
      |> Task.changeset(%Task{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", task_path(conn, :show, task))
        |> render("show.json-api", data: task)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}, user, _claims) do
    task = Repo.get!(user_tasks(user), id)
    render(conn, "show.json-api", data: task)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "task", "attributes" => _task_params}}, user, _claims) do
    task = Repo.get!(user_tasks(user), id)
    changeset = Task.changeset(task, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, task} ->
        render(conn, "show.json-api", data: task)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user, _claims) do
    task = Repo.get!(user_tasks(user), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(task)

    send_resp(conn, :no_content, "")
  end

  def user_tasks(user) do
    assoc(user, :tasks)
  end

end
