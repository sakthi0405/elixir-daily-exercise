defmodule TutorialApi.Repo.Migrations.CreateExercise do
  use Ecto.Migration

  def change do
    create table(:exercise) do
      add :name, :string
      add :description, :string
      add :example, :string

      timestamps(type: :utc_datetime)
    end
  end
end
