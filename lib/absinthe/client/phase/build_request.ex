defmodule Absinthe.Client.Phase.BuildRequest do
  use Absinthe.Phase

  @impl true
  def run(document, opts \\ []) do
    request = %Absinthe.Client.Request{
      document: document,
      operation_name: Keyword.get(opts, :operation_name),
      context: Keyword.get(opts, :context, %{}),
      extensions: Keyword.get(opts, :extensions, %{}),
      variables: Keyword.get(opts, :variables, %{})
    }

    {:ok, request}
  end
end
