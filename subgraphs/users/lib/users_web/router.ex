defmodule UsersWeb.Router do
  use UsersWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UsersWeb do
    pipe_through :api
  end
end
