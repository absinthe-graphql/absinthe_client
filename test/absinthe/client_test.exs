defmodule Absinthe.ClientTest do
  use ExUnit.Case
  doctest Absinthe.Client

  defmodule TestClient do
    use Absinthe.Client
  end

  test "new/1 stores the implementing module" do
    assert {:ok, %Absinthe.Client{module: TestClient}} = TestClient.new()
  end
end
