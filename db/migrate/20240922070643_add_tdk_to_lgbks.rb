class AddTdkToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :nmaktdk, :string
    add_column :lgbks, :rfpltdk, :string
  end
end
