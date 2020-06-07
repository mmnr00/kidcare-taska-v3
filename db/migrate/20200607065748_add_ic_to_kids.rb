class AddIcToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :mic, :string
    add_column :kids, :fic, :string
  end
end
