defmodule ResuelveCc.Endpoint do
  use Plug.Router

  plug Plug.RequestId
  plug Plug.Logger

  plug :match

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  plug :dispatch

  # Define a health_checker route for the service
  get "/_health" do
    send_resp(conn, 200, "Service running correctly!")
  end

  # Forward requests to versioned router(s)
  forward "/v1", to: ResuelveCc.V1.Router

  # A catchall route, that will match no matter the request method,
  # so a response is always returned, even if there is no route to match.
  match _ do
    send_resp(conn, 404, "Not found")
  end
end
