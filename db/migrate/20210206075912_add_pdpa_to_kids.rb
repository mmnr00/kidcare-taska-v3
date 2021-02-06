class AddPdpaToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :pdpa, :string
  end
end
