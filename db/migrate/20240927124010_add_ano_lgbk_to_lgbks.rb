class AddAnoLgbkToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :nmaktdk4, :string
  end
end
