defmodule TutorialApi.Repo do
  use Ecto.Repo,
    otp_app: :tutorial_api,
    adapter: Ecto.Adapters.Postgres
end
