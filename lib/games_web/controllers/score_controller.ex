defmodule GamesWeb.ScoreController do
  use GamesWeb, :controller

  alias Games.Game
  alias Games.Game.Score

  def index(conn, _params) do
    scores = Game.list_scores()
    changeset = Game.change_score(%Score{})
    render(conn, "index.html", scores: scores, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Game.change_score(%Score{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"score" => score_params}) do
    case Game.create_score(score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score created successfully.")
        |> redirect(to: Routes.score_path(conn, :show, score))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Game.get_score!(id)
    render(conn, "show.html", score: score)
  end

  def edit(conn, %{"id" => id}) do
    score = Game.get_score!(id)
    changeset = Game.change_score(score)
    render(conn, "edit.html", score: score, changeset: changeset)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Game.get_score!(id)

    case Game.update_score(score, score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score updated successfully.")
        |> redirect(to: Routes.score_path(conn, :show, score))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", score: score, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Game.get_score!(id)
    {:ok, _score} = Game.delete_score(score)

    conn
    |> put_flash(:info, "Score deleted successfully.")
    |> redirect(to: Routes.score_path(conn, :index))
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
