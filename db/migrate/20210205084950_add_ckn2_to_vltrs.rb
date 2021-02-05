class AddCkn2ToVltrs < ActiveRecord::Migration[5.2]
  def change
    add_column :vltrs, :edu, :string
    add_column :vltrs, :marr, :string
    add_column :vltrs, :crs, :string
    add_column :vltrs, :ocrs, :string
  end
end
