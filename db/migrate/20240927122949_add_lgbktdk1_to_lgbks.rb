class AddLgbktdk1ToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :nmaktdk1, :string
    add_column :lgbks, :nmaktdk2, :string
    add_column :lgbks, :nmaktdk3, :string
  end
end
