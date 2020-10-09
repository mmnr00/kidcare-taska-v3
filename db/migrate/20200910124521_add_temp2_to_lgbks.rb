class AddTemp2ToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :temp, :text
  end
end
