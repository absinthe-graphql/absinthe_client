defmodule Absinthe.Client do
  @enforce_keys [:module, :pipeline]

  defstruct [
    :module,
    :pipeline
  ]

  @type t :: %__MODULE__{
          module: module(),
          pipeline: [Client.Phase.t()]
        }

  defmacro __using__(_opts) do
    quote do
      @behaviour Absinthe.Client

      def new(opts \\ []) do
        Absinthe.Client.new(__MODULE__, opts)
      end

      def pipeline(pipeline), do: pipeline

      def pipeline(pipeline, _request), do: pipeline

      defoverridable(new: 1, pipeline: 1, pipeline: 2)
    end
  end

  @callback new(opts :: Keyword.t()) :: {:ok, t()} | {:error, any()}

  @callback pipeline(pipeline :: Absinthe.Client.Pipeline.t()) :: Absinthe.Client.Pipeline.t()
  @callback pipeline(
              pipeline :: Absinthe.Client.Pipeline.t(),
              request :: Absinthe.Client.Request.t()
            ) :: Absinthe.Client.Pipeline.t()

  @default_pipeline

  @spec new(client_module :: module(), opts :: Keyword.t()) :: {:ok, t()} | {:error, any()}
  def new(client_module, opts \\ []) do
    {pipeline, opts} = extract_pipeline(client_module, opts)
    {:ok, struct(%__MODULE__{module: client_module, pipeline: pipeline}, opts)}
  end

  @spec extract_pipeline(client_module :: module(), opts :: Keyword.t()) ::
          {pipeline :: Absinthe.Client.Pipeline.t(), opts :: Keyword.t()}
  defp extract_pipeline(client_module, opts) do
    {pipeline, opts} = Keyword.pop(opts, :pipeline)
    pipeline = client_module.pipeline(pipeline || default_pipeline(opts))
    {pipeline, opts}
  end

  @spec default_pipeline(opts :: Keyword.t()) :: Absinthe.Pipeline.t()
  def default_pipeline(opts \\ []) do
    [
      {Absinthe.Client.Phase.BuildRequest, opts},
      {Absinthe.Client.Phase.HTTP, opts}
    ]
  end
end
