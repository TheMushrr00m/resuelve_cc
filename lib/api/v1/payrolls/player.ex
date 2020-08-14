defmodule ResuelveCc.V1.Payrolls.Player do
  @moduledoc """
  An struct to define a Player model
  """

  @derive Jason.Encoder
  @enforce_keys [:nombre, :nivel, :goles, :sueldo, :bono, :sueldo_completo, :equipo]
  defstruct [:nombre, :nivel, :goles, :goles_minimos, :sueldo, :bono, :sueldo_completo, :equipo]
end
