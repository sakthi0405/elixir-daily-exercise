defmodule TutorialApi.CourseTest do
  use TutorialApi.DataCase

  alias TutorialApi.Course

  describe "exercise" do
    alias TutorialApi.Course.Tutorial

    import TutorialApi.CourseFixtures

    @invalid_attrs %{name: nil, description: nil, example: nil}

    test "list_exercise/0 returns all exercise" do
      tutorial = tutorial_fixture()
      assert Course.list_exercise() == [tutorial]
    end

    test "get_tutorial!/1 returns the tutorial with given id" do
      tutorial = tutorial_fixture()
      assert Course.get_tutorial!(tutorial.id) == tutorial
    end

    test "create_tutorial/1 with valid data creates a tutorial" do
      valid_attrs = %{name: "some name", description: "some description", example: "some example"}

      assert {:ok, %Tutorial{} = tutorial} = Course.create_tutorial(valid_attrs)
      assert tutorial.name == "some name"
      assert tutorial.description == "some description"
      assert tutorial.example == "some example"
    end

    test "create_tutorial/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Course.create_tutorial(@invalid_attrs)
    end

    test "update_tutorial/2 with valid data updates the tutorial" do
      tutorial = tutorial_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", example: "some updated example"}

      assert {:ok, %Tutorial{} = tutorial} = Course.update_tutorial(tutorial, update_attrs)
      assert tutorial.name == "some updated name"
      assert tutorial.description == "some updated description"
      assert tutorial.example == "some updated example"
    end

    test "update_tutorial/2 with invalid data returns error changeset" do
      tutorial = tutorial_fixture()
      assert {:error, %Ecto.Changeset{}} = Course.update_tutorial(tutorial, @invalid_attrs)
      assert tutorial == Course.get_tutorial!(tutorial.id)
    end

    test "delete_tutorial/1 deletes the tutorial" do
      tutorial = tutorial_fixture()
      assert {:ok, %Tutorial{}} = Course.delete_tutorial(tutorial)
      assert_raise Ecto.NoResultsError, fn -> Course.get_tutorial!(tutorial.id) end
    end

    test "change_tutorial/1 returns a tutorial changeset" do
      tutorial = tutorial_fixture()
      assert %Ecto.Changeset{} = Course.change_tutorial(tutorial)
    end
  end
end
