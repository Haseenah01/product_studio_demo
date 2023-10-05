defmodule ProductStudioDemo.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  #alias ProductStudioDemoWeb.Validator.JsonValidator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :float
    field :stock, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :stock])
    |> validate_required([:name, :description, :price, :stock])
    |> validate_format(:name, ~r/^[a-zA-Z0-9_ ]*$/,
     message: "only letters, numbers, and underscores please")
    |> validate_length(:name, min: 2, message: "Name must be at least 2 characters")
    |> validate_length(:description, min: 10, message: "Description must be at least 10 characters")
    |> validate_number(:price, greater_than: 0, message: "Price must be a positive number")
    |> validate_number(:stock, greater_than: 0, message: "Stock must not be a negative number")
    |> unique_constraint(:name)
  end
end
