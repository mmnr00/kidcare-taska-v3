class AddExsToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :exs, :boolean
  end
end
