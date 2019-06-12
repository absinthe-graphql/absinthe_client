defmodule Absinthe.Client.Phase.HTTP do
  use Absinthe.Phase

  @impl true
  def run(_request, _opts \\ []) do
    {:ok, %Absinthe.Client.Result{}}
  end
end
