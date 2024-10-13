class AddIncdToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :incd, :string
  end
end
