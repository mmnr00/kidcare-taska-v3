class AddTskToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :taska_id, :integer
  end
end
