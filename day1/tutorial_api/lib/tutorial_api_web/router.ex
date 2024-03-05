defmodule TutorialApiWeb.Router do
  use TutorialApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TutorialApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", TutorialApiWeb do
  #   pipe_through :browser

  #   get "/", PageController, :home
  # end

  # Other scopes may use custom stacks.
  scope "/api", TutorialApiWeb do
    pipe_through :api
    resources "/tutorial", TutorialController, only: [:index, :show]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:tutorial_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TutorialApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
