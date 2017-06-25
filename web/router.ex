defmodule DispatchApi.Router do
  use DispatchApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api", "json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
  end

  scope "/api", DispatchApi do
    pipe_through :api

    resources "/tasks", TaskController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    post "/login", SessionController, :create, as: :login
  end
end
