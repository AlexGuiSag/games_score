defmodule GamesWeb.RandomScoreController do
  use GamesWeb, :controller

  alias Games.Game
  alias Games.Game.Score

   def index(conn, _params) do
    scores = Game.list_scores()
    render(conn, "index_random.html", scores: scores)
  end

  def new_random(conn, _params) do
    changeset = Game.change_score(%Score{})
    render(conn, "new_random.html", changeset: changeset)
  end

    def create_random(conn, %{"score" => score_params}) do
    case Game.create_score(score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score created successfully.")
        |> redirect(to: Routes.score_path(conn, :show, score))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
