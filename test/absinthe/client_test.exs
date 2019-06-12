defmodule Absinthe.ClientTest do
  use ExUnit.Case

  defmodule TestClient do
    use Absinthe.Client
  end

  describe "new/0" do
    test "stores the implementing module" do
      assert {:ok, %Absinthe.Client{module: TestClient}} = TestClient.new()
    end

    test "sets a default pipeline" do
      assert {:ok,
              %Absinthe.Client{
                pipeline: [
                  {Absinthe.Client.Phase.BuildRequest, []},
                  {Absinthe.Client.Phase.HTTP, []}
                ]
              }} = TestClient.new()
    end
  end
end
