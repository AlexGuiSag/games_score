defmodule Games.Game.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :goal, :integer
    field :goal_scorer, :string
    field :red_card, :integer
    field :yellow_card, :integer

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:red_card, :yellow_card, :goal, :goal_scorer])
    |> validate_required([:red_card, :yellow_card, :goal, :goal_scorer])
  end

  #|> cast(attrs, [:red_card, Enum.random([1..10]), :yellow_card, Enum.random([1..10]), :goal, Enum.random([1..20]), :goal_scorer, Enum.random(["Juanito", "Pedrito", "Angelito", "Pablito", "Toñito"]) ])
end
