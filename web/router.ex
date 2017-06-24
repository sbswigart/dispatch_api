defmodule DispatchApi.Router do
  use DispatchApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", DispatchApi do
    pipe_through :api

    resources "/tasks", TaskController, except: [:new, :edit]
  end
end
