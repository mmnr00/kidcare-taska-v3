class AddPrtToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :tdo, :string
    add_column :lgbks, :sih, :string
    add_column :lgbks, :sbb, :string
    add_column :lgbks, :mand, :string
    add_column :lgbks, :tool, :text
    add_column :lgbks, :medc, :text
    add_column :lgbks, :phyc, :string
  end
end
