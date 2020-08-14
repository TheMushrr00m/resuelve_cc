defmodule ResuelveCc.V1.Router do
  use Plug.Router

  alias ResuelveCc.V1.Payrolls

  plug(:match)
  plug(:dispatch)

  post "/payroll" do
    {status, body} =
      case conn.body_params do
        %{"jugadores" => players, "equipos" => teams} -> {200, process_payroll(players, teams)}
        _ -> {422, missing_data()}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  defp process_payroll(players, teams) when is_list(players) and is_list(teams) do
    Payrolls.calculate(players, teams)
    |> Jason.encode!()
  end

  defp process_payroll(_, _) do
    missing_data()
  end

  defp missing_data do
    Jason.encode!(%{"error" => "Expected payload: { 'jugadores': [...], 'equipos': [...] }"})
  end
end
