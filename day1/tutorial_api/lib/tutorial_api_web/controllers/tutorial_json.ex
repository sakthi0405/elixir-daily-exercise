defmodule TutorialApiWeb.TutorialJSON do
  alias TutorialApi.Course.Tutorial

  @doc """
  Renders a list of exercise.
  """
  def index(%{exercise: exercise}) do
    %{data: for(tutorial <- exercise, do: data(tutorial))}
  end

  @doc """
  Renders a single tutorial.
  """
  def show(%{tutorial: tutorial}) do
    %{data: data(tutorial)}
  end

  defp data(%Tutorial{} = tutorial) do
    %{
      id: tutorial.id,
      name: tutorial.name,
      description: tutorial.description,
      example: tutorial.example
    }
  end
end
