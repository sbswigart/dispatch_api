defmodule DispatchApi.UserView do
  use DispatchApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:username, :email]
end
