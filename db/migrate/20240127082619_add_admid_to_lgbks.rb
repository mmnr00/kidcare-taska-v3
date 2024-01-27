class AddAdmidToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :admid, :text
  end
end
