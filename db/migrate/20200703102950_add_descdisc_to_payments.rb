class AddDescdiscToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :discdx, :string
  end
end
