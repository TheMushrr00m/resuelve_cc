defmodule ResuelveCc.V1.Payrolls do
  @moduledoc """
  The Payrolls context
  """

  alias ResuelveCc.V1.Payrolls.Player
  alias ResuelveCc.V1.Payrolls.Team

  #@spec calculate(list(), list()) :: list(Player)
  def calculate(players_map, teams_map) do
    teams = for team <- teams_map, do: convert_to_struct(Team, team)
    players = for player <- players_map, do: convert_to_struct(Player, player)

    calculate_payroll(players, teams)
  end

  defp calculate_payroll(players, teams) do
    goals_scored_at_month = Enum.reduce(players, 0, fn player, acc -> player.goles + acc end)
    minimum_goals = calculate_minimum_goals(players, teams, 0)

    calculate_salary(players, goals_scored_at_month, minimum_goals, teams)
  end

  defp calculate_minimum_goals([player | players], teams, minimum_goals) do
    team = get_player_team(player, teams)
    minimum_goals = minimum_goals + Map.get(team.niveles, player.nivel)

    calculate_minimum_goals(players, teams, minimum_goals)
  end

  defp calculate_minimum_goals([], _, minimum_goals) do
    minimum_goals
  end

  defp calculate_salary([player | players], goals_scored_at_month, minimum_goals, teams) do
    team = get_player_team(player, teams)
    player = %{player | goles_minimos: Map.get(team.niveles, player.nivel)}

    [calculate_salary_by_player(player, goals_scored_at_month, minimum_goals) | calculate_salary(players, goals_scored_at_month, minimum_goals, teams)]
  end

  defp calculate_salary([], _, _, _) do
    []
  end

  defp calculate_salary_by_player(player, goals_scored_at_month, minimum_goals) do
    bonus_team = (goals_scored_at_month * 100) / minimum_goals
    bonus_player = (player.goles * 100) / player.goles_minimos

    bonus_percentage = Float.round((bonus_player + bonus_team) / 2, 1)

    bonus_total = Float.round((player.bono * bonus_percentage) / 100, 1)

    # Using trunc to avoid return with cientific notation i.e: (1.393e5)
    total_salary = trunc(player.sueldo + Float.round(bonus_total, 1))

    %{player | sueldo_completo: total_salary}
  end

  defp convert_to_struct(kind, from_map) do
    team = struct(kind)
    Enum.reduce Map.to_list(team), team, fn {k, _}, acc ->
      case Map.fetch(from_map, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
  end

  defp get_player_team(player, teams) do
    Enum.find(teams, fn team -> player.equipo == team.nombre end)
  end
end
