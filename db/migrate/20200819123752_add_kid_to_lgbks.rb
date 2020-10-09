class AddKidToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :kid_id, :integer
  end
end
