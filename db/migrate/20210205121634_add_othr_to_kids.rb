class AddOthrToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :ftosct, :string
    add_column :kids, :mmosct, :string
    add_column :kids, :oku, :string
  end
end
