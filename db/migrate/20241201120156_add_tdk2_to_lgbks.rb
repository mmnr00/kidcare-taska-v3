class AddTdk2ToLgbks < ActiveRecord::Migration[6.1]
  def change
    add_column :lgbks, :bm, :text
    add_column :lgbks, :bi, :text
    add_column :lgbks, :mt, :text
    add_column :lgbks, :pi, :text
  end
end
