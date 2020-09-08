class AddSusuToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :susu, :text
  end
end
