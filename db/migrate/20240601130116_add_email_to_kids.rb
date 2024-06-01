class AddEmailToKids < ActiveRecord::Migration[6.1]
  def change
    add_column :kids, :email, :string
  end
end
