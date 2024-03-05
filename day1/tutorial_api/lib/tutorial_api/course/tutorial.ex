defmodule TutorialApi.Course.Tutorial do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercise" do
    field :name, :string
    field :description, :string
    field :example, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tutorial, attrs) do
    tutorial
    |> cast(attrs, [:name, :description, :example])
    |> validate_required([:name, :description, :example])
  end
end
