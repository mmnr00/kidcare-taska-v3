class AddNwblToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :bill_id2, :string
    add_column :payments, :fin, :boolean
  end
end
