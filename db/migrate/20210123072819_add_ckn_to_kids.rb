class AddCknToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :ckn, :string
  end
end
