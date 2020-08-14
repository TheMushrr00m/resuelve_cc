defmodule ResuelveCc.V1.Payrolls.Team do
  @moduledoc """
  An struct to define a Team model
  """

  @derive Jason.Encoder
  @enforce_keys [:nombre, :niveles]
  defstruct [:nombre, :niveles]
end
