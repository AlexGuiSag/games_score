defmodule GamesWeb.PageController do
  use GamesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def new_random(conn, _params)do
    render(conn, "new_random.html")
  end
end
