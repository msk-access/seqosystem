defmodule Dashboard.Projects.Assay do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assays" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(assay, attrs) do
    assay
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
