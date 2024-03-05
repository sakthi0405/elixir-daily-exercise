 alias TutorialApi.Repo
  alias TutorialApi.Course.Tutorial

  Repo.insert! %Tutorial{
    name: "Data structure",
    description: "test description",
    example: "text example"

  }
