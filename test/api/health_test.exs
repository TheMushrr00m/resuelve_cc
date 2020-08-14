defmodule ResuelveCcTest.Api.HealthTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ResuelveCc.Endpoint.init([])

  test "Getting /health response" do
    # Create a test connection and invoke the plug
    conn =
      :get
      |> conn("/_health", %{})
      |> ResuelveCc.Endpoint.call(@opts)

    # Assert the response
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Service running correctly!"
  end

  test "it returns 404 when no route matches" do
    # Create a test connection
    conn = conn(:get, "/fail")

    # Invoke the plug
    conn = ResuelveCc.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 404
  end
end
