defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

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
    extends()

    field :all_products, list_of(:product) do
      resolve(fn _, _, _ -> {:ok, @products} end)
    end

    field :product, :product do
      arg(:id, non_null(:id))

      resolve(fn %{id: id}, _ -> {:ok, @products |> Enum.find(&(&1.id == id))} end)
    end
  end

  object :product do
    key_fields(["id", "sku package", "sku variation { id }"])
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
      provides_fields("totalProductsCreated")

      resolve(fn _, _, _ ->
        {:ok, %{email: "support@apollographql.com", total_products_created: 1337}}
      end)
    end

    field :_resolve_reference, :product do
      resolve(fn
        _, %{id: id}, _ ->
          {:ok, @products |> Enum.find(&(&1.id == id)) |> Map.put(:__typename, "Product")}

        _, %{package: package, sku: sku}, _ ->
          {:ok,
           @products
           |> Enum.find(&(&1.package == package && &1.sku == sku))
           |> Map.put(:__typename, "Product")}

        _, %{}, _ ->
          {:ok, @products |> hd() |> Map.put(:__typename, "Product")}
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
    extends()
    key_fields(["email"])

    field(:email, non_null(:id), do: external())

    field(:total_products_created, :integer, do: external())
  end
end
