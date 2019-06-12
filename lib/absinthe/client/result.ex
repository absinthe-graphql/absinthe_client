defmodule Absinthe.Client.Result do
  defstruct data: nil,
            errors: nil,
            extensions: nil

  @type t :: %__MODULE__{
          data: nil | map(),
          errors: nil | [map()],
          extensions: nil | map()
        }
end
