defmodule TutorialApiWeb.TutorialControllerTest do
  use TutorialApiWeb.ConnCase

  import TutorialApi.CourseFixtures

  alias TutorialApi.Course.Tutorial

  @create_attrs %{
    name: "some name",
    description: "some description",
    example: "some example"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    example: "some updated example"
  }
  @invalid_attrs %{name: nil, description: nil, example: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exercise", %{conn: conn} do
      conn = get(conn, ~p"/api/exercise")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tutorial" do
    test "renders tutorial when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/exercise", tutorial: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/exercise/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "example" => "some example",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/exercise", tutorial: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tutorial" do
    setup [:create_tutorial]

    test "renders tutorial when data is valid", %{conn: conn, tutorial: %Tutorial{id: id} = tutorial} do
      conn = put(conn, ~p"/api/exercise/#{tutorial}", tutorial: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/exercise/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "example" => "some updated example",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tutorial: tutorial} do
      conn = put(conn, ~p"/api/exercise/#{tutorial}", tutorial: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tutorial" do
    setup [:create_tutorial]

    test "deletes chosen tutorial", %{conn: conn, tutorial: tutorial} do
      conn = delete(conn, ~p"/api/exercise/#{tutorial}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/exercise/#{tutorial}")
      end
    end
  end

  defp create_tutorial(_) do
    tutorial = tutorial_fixture()
    %{tutorial: tutorial}
  end
end
