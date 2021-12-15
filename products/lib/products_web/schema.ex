defmodule ProductsWeb.Schema do
  use Absinthe.Schema

  @products [
    %{
      id: "apollo-federation",
      sku: "federation",
      package: "absinthe_federation",
      variation: "OSS"
    },
    %{
      id: "apollo-studio",
      sku: "studio",
      package: "",
      variation: "platform"
    }
  ]

  query do
    field :all_products, list_of(:product) do
      resolve(fn _, _, _ -> {:ok, @products} end)
    end

    field :product, :product do
      arg(:id, non_null(:id))

      resolve(fn %{id: id}, _ -> {:ok, @products |> Enum.find(&(&1.id == id))} end)
    end
  end

  object :product do
    field(:id, non_null(:id))
    field(:sku, :string)
    field(:package, :string)

    field :variation, :product_variation do
      resolve(fn
        %{variation: variation}, _, _ ->
          {:ok, %{id: variation}}

        %{id: id}, _, _ ->
          {:ok, Enum.find(@products, &(&1.id == id)) |> Map.get(:variation)}

        _, _, _ ->
          {:error, :error}
      end)
    end

    field :dimensions, :product_dimension do
      resolve(fn _, _, _ -> {:ok, %{size: "1", weight: 1}} end)
    end

    field :created_by, :user do
      resolve(fn _, _, _ ->
        {:ok, %{email: "support@apollographql.com", total_products_created: 1337}}
      end)
    end
  end

  object :product_variation do
    field(:id, non_null(:id))
  end

  object :product_dimension do
    field(:size, :string)
    field(:weight, :float)
  end

  object :user do
    field(:email, non_null(:id))

    field(:total_products_created, :integer)
  end
end
