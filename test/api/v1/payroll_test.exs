defmodule ResuelveCcTest.Api.V1 do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ResuelveCc.Endpoint.init([])

  test "Getting /v1/payroll [Success]" do
    # Create a test connection and invoke the plug
    conn =
      :post
      |> conn("/v1/payroll", %{
        "jugadores" => [
          %{
              "nombre" => "Juan Perez",
              "nivel" => "C",
              "goles" => 10,
              "sueldo" => 50000,
              "bono" => 25000,
              "equipo" => "rojo"
          }],
        "equipos" => [
          %{
            "nombre" => "rojo",
            "niveles" => %{
                "A" => 5,
                "B" => 10,
                "C" => 15,
                "Cuauh" => 20
            }
          }]
        }
      )
      |> ResuelveCc.Endpoint.call(@opts)

    # Assert the response
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "[{\"bono\":25000,\"equipo\":\"rojo\",\"goles\":10,\"goles_minimos\":15,\"nivel\":\"C\",\"nombre\":\"Juan Perez\",\"sueldo\":50000,\"sueldo_completo\":66675}]"
  end

  test "Getting /v1/payroll [Failure]" do
    # Create a test connection and invoke the plug
    conn =
      :post
      |> conn("/v1/payroll", %{})
      |> ResuelveCc.Endpoint.call(@opts)

    # Assert the response
    assert conn.state == :sent
    assert conn.status == 422
    assert conn.resp_body == "{\"error\":\"Expected payload: { 'jugadores': [...], 'equipos': [...] }\"}"
  end
end
