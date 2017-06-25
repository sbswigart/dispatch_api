defmodule DispatchApi.User do
  use DispatchApi.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :encrypted_password, :password])
    |> validate_required([:email])
    |> hash_password
  end

  defp hash_password(model) do
    case get_change(model, :password) do
      nil -> model
      password -> put_change(model, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
    end
  end
end
