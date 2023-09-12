class AddTncToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :tnc, :string
  end
end
