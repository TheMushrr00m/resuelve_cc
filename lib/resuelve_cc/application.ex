defmodule ResuelveCc.Application do
  @moduledoc "OTP Application specification for ResuelveCc"

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: ResuelveCc.Endpoint, port: Application.get_env(:resuelve_cc, :port)}
    ]

    opts = [strategy: :one_for_one, name: ResuelveCc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
