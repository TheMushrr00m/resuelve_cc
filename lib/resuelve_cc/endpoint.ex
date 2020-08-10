defmodule ResuelveCc.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  # Using it for logging request information
  plug Plug.Logger
  plug :match
  # Using Jason for JSON decoding
  plug Plug.Parsers,
    parsers: [:json], json_decoder: Jason
  # responsible for dispatching responses
  plug :dispatch

  # Define a health_checker route for the service
  get "/_health" do
    send_resp(conn, 200, "Service running correctly!")
  end

  # A catchall route, 'match' will match no matter the request method,
  # so a response is always returned, even if there is no route to match.
  match _ do
    send_resp(conn, 404, "Route not found.")
  end
end
