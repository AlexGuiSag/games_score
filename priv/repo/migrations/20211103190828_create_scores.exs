defmodule Games.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :red_card, :integer
      add :yellow_card, :integer
      add :goal, :integer
      add :goal_scorer, :string

      timestamps()
    end

  end
end
