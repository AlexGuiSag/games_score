defmodule GamesWeb.ScoreControllerTest do
  use GamesWeb.ConnCase

  alias Games.Game

  @create_attrs %{goal: 42, goal_scorer: "some goal_scorer", red_card: 42, yellow_card: 42}
  @update_attrs %{goal: 43, goal_scorer: "some updated goal_scorer", red_card: 43, yellow_card: 43}
  @invalid_attrs %{goal: nil, goal_scorer: nil, red_card: nil, yellow_card: nil}

  def fixture(:score) do
    {:ok, score} = Game.create_score(@create_attrs)
    score
  end

  describe "index" do
    test "lists all scores", %{conn: conn} do
      conn = get(conn, Routes.score_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Scores"
    end
  end

  describe "new score" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.score_path(conn, :new))
      assert html_response(conn, 200) =~ "New Score"
    end
  end

  describe "create score" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.score_path(conn, :create), score: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.score_path(conn, :show, id)

      conn = get(conn, Routes.score_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Score"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.score_path(conn, :create), score: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Score"
    end
  end

  describe "edit score" do
    setup [:create_score]

    test "renders form for editing chosen score", %{conn: conn, score: score} do
      conn = get(conn, Routes.score_path(conn, :edit, score))
      assert html_response(conn, 200) =~ "Edit Score"
    end
  end

  describe "update score" do
    setup [:create_score]

    test "redirects when data is valid", %{conn: conn, score: score} do
      conn = put(conn, Routes.score_path(conn, :update, score), score: @update_attrs)
      assert redirected_to(conn) == Routes.score_path(conn, :show, score)

      conn = get(conn, Routes.score_path(conn, :show, score))
      assert html_response(conn, 200) =~ "some updated goal_scorer"
    end

    test "renders errors when data is invalid", %{conn: conn, score: score} do
      conn = put(conn, Routes.score_path(conn, :update, score), score: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Score"
    end
  end

  describe "delete score" do
    setup [:create_score]

    test "deletes chosen score", %{conn: conn, score: score} do
      conn = delete(conn, Routes.score_path(conn, :delete, score))
      assert redirected_to(conn) == Routes.score_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.score_path(conn, :show, score))
      end
    end
  end

  defp create_score(_) do
    score = fixture(:score)
    %{score: score}
  end
end
