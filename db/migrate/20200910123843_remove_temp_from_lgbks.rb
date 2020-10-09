class RemoveTempFromLgbks < ActiveRecord::Migration[5.2]
  def change
    remove_column :lgbks, :temp, :float
  end
end
