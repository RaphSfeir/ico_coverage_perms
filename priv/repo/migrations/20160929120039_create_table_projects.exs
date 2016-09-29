defmodule IcoCoveragePerms.Repo.Migrations.CreateTableProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string

      timestamps
    end
    create index(:projects, [:name], unique: true)
  end

  def down do
    drop table(:projects)
  end
end
