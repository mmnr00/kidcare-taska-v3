class AddKcToKids < ActiveRecord::Migration[6.1]
  def change
    add_column :kids, :okutype, :string
    add_column :kids, :okuregno, :string
  end
end
