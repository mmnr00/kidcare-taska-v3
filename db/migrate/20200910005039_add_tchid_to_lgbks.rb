class AddTchidToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :tchid, :text
  end
end
