defmodule Absinthe.Client do
  @enforce_keys [:module]

  defstruct [:module]

  @type t :: %__MODULE__{
          module: module()
        }

  defmacro __using__(_opts) do
    quote do
      @behaviour Absinthe.Client

      def new(opts \\ []) do
        Absinthe.Client.new(__MODULE__, opts)
      end

      defoverridable(new: 1)
    end
  end

  @callback new(opts :: Keyword.t()) :: {:ok, t()} | {:error, any()}

  @spec new(impl_module :: module(), opts :: Keyword.t()) :: {:ok, t()} | {:error, any()}
  def new(impl_module, opts \\ []) do
    {:ok, struct(%__MODULE__{module: impl_module}, opts)}
  end
end
