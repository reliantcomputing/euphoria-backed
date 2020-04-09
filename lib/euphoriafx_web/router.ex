defmodule EuphoriafxWeb.Router do
  use EuphoriafxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug EuphoriafxWeb.Auth.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EuphoriafxWeb do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/api", EuphoriafxWeb do
    pipe_through :api
    post "/auth/signup", AuthController, :signup
    post "/auth/signin", AuthController, :signin
  end

  # Other scopes may use custom stacks.
  # scope "/api", EuphoriafxWeb do
  #   pipe_through :api
  # end
  scope "/api", EuphoriafxWeb do
    pipe_through :api

    resources "/packages", PackageController
    resources "/users", UserController
    resources "/types", TypeController
    resources "/feeds", FeedController
    resources "/comments", CommentController
    resources "/likes", LikeController
    resources "/replies", ReplyController
    resources "/folders", FolderController
    resources "/videos", VideoController
    resources "/robot/notifications", RobotNotificationController
    resources "/team/notifications", TeamNotificationController
    resources "/other/notifications", OtherNotificationController
    resources "/chats", ChatController
    resources "/chat/messages", ChatMessageController
  end
end
