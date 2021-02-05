class AddGenderToVltrs < ActiveRecord::Migration[5.2]
  def change
    add_column :vltrs, :gender, :string
  end
end
