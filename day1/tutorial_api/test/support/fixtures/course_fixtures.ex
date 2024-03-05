defmodule TutorialApi.CourseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TutorialApi.Course` context.
  """

  @doc """
  Generate a tutorial.
  """
  def tutorial_fixture(attrs \\ %{}) do
    {:ok, tutorial} =
      attrs
      |> Enum.into(%{
        description: "some description",
        example: "some example",
        name: "some name"
      })
      |> TutorialApi.Course.create_tutorial()

    tutorial
  end
end
