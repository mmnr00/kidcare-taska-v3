class AddLgbkToFotos < ActiveRecord::Migration[6.1]
  def change
    add_column :fotos, :lgbk_id, :integer
  end
end
