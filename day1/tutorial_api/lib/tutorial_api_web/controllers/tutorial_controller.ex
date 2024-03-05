defmodule TutorialApiWeb.TutorialController do
  use TutorialApiWeb, :controller

  alias TutorialApi.Course
  alias TutorialApi.Course.Tutorial

  action_fallback TutorialApiWeb.FallbackController

  def index(conn, _params) do
    exercise = Course.list_exercise()
    render(conn, :index, exercise: exercise)
  end

  def create(conn, %{"tutorial" => tutorial_params}) do
    with {:ok, %Tutorial{} = tutorial} <- Course.create_tutorial(tutorial_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/exercise/#{tutorial}")
      |> render(:show, tutorial: tutorial)
    end
  end

  def show(conn, %{"id" => id}) do
    tutorial = Course.get_tutorial!(id)
    render(conn, :show, tutorial: tutorial)
  end

  def update(conn, %{"id" => id, "tutorial" => tutorial_params}) do
    tutorial = Course.get_tutorial!(id)

    with {:ok, %Tutorial{} = tutorial} <- Course.update_tutorial(tutorial, tutorial_params) do
      render(conn, :show, tutorial: tutorial)
    end
  end

  def delete(conn, %{"id" => id}) do
    tutorial = Course.get_tutorial!(id)

    with {:ok, %Tutorial{}} <- Course.delete_tutorial(tutorial) do
      send_resp(conn, :no_content, "")
    end
  end
end
