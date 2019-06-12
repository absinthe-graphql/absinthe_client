defmodule Absinthe.Client.Request do
  @enforce_keys [:document]
  defstruct [
    :document,
    operation_name: nil,
    context: %{},
    extensions: %{},
    variables: %{}
  ]

  @type t :: %__MODULE__{
          document: Absinthe.Blueprint.t()
        }
end
