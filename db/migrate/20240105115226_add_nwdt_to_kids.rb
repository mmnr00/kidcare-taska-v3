class AddNwdtToKids < ActiveRecord::Migration[6.1]
  def change
    add_column :kids, :emerctc, :string
    add_column :kids, :birthcert, :string
  end
end
