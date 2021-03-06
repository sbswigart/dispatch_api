defmodule DispatchApi.TaskTest do
  use DispatchApi.ModelCase

  alias DispatchApi.Task

  @valid_attrs %{completed: true, description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Task.changeset(%Task{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Task.changeset(%Task{}, @invalid_attrs)
    refute changeset.valid?
  end
end
