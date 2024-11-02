class AddWabaToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :waba, :text
  end
end
