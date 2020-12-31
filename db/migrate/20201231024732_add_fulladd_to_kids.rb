class AddFulladdToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :fulladd, :string
  end
end
