class AddTchlsToLgbks < ActiveRecord::Migration[5.2]
  def change
    add_column :lgbks, :susudc, :string
    add_column :lgbks, :mkn, :text
    add_column :lgbks, :ctm, :text
    add_column :lgbks, :aktl, :text
    add_column :lgbks, :aktp, :text
    add_column :lgbks, :lmpn, :text
    add_column :lgbks, :gigi, :text
    add_column :lgbks, :mnd, :text
    add_column :lgbks, :tdur, :text
    add_column :lgbks, :aktb, :string
    add_column :lgbks, :othdc, :string
  end
end
