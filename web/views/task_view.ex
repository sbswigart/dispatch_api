defmodule DispatchApi.TaskView do
  use DispatchApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:description, :completed, :inserted_at, :updated_at]
  

end
